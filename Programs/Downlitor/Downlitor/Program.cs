//
//  Program.cs
//
//  Author:
//       Benito Palacios Sánchez <benito356@gmail.com>
//
//  Copyright (c) 2015 Benito Palacios Sánchez
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
using System;
using System.IO;
using System.Xml.Linq;
using Libgame;
using Libgame.Utils.Checksums;
using Libgame.IO;

namespace Downlitor
{
	public static class Program
	{
        private const int NumEntries = 0x72;
        private static readonly byte[] Key = new byte[] {
            0x72, 0x2B, 0x41, 0x8B, 0x4C, 0xFB, 0x9F, 0x27,
            0xB2, 0x1D, 0x05, 0xAF, 0xFB, 0x2B, 0x80, 0x9F
        };

		[STAThread]
		public static void Main(string[] args)
		{
			string xmlEdit = "Ninokuni español.xml";
			var document = XDocument.Load(xmlEdit);
			Configuration.Initialize(document);

            if (args.Length >= 2 && args[0] == "-e") {
                if (args.Length == 3)
                    ExportFromDlc(args[1], args[2]);
                else
                    Export(args[1]);
                return;
            }  else if (args.Length == 3 && args[0] == "-i") {
                Import(args[1], args[2]);
                return;
            }

            MainWindow window = new MainWindow();
            window.ShowDialog();
            window.Dispose();
		}

        private static void Export(string output, bool[] activation = null)
        {
            XDocument xml = new XDocument();
            XElement root = new XElement("NinoDlc");

            var manager = DlcManager.Instance;
            for (int i = 0; i < manager.NumEntries; i++) {
                XElement entry = new XElement("Element");
                entry.SetAttributeValue("ID", i.ToString("D2"));
                entry.SetAttributeValue("Name", manager[i]);
                entry.Value = (activation == null) ? "false" : activation[i].ToString();
                root.Add(entry);
            }

            xml.Add(root);
            xml.Save(output);
        }

        private static void ExportFromDlc(string output, string dlc)
        {
            var activation = GetActivation(dlc);
            Export(output, activation);
        }

        private static bool[] GetActivation(string dlc)
        {
            bool[] activation = new bool[NumEntries];
            var dlcStream = new DataStream(dlc, FileMode.Open, FileAccess.Read);
            var dlcDecoded = Rc4.Run(dlcStream, Key);
            dlcStream.Dispose();

            dlcDecoded.Seek(0, SeekMode.Origin);
            Console.WriteLine(new DataReader(dlcDecoded).ReadUInt32());

            dlcDecoded.Seek(8, SeekMode.Origin);
            byte bitCount = 0;
            byte value = 0;
            for (int i = 0; i < activation.Length; i++) {
                if (bitCount == 0) {
                    value = (byte)dlcDecoded.ReadByte();
                    bitCount = 8;
                }

                activation[i] = (value & 1) == 1;
                value >>= 1;
                bitCount--;
            }

            dlcDecoded.Dispose();
            return activation;
        }

        private static void Import(string output, string list)
        {
            var activation = GetActivation(XDocument.Load(list));
            WriteDlc(output, activation);
        }

        private static bool[] GetActivation(XDocument list)
        {
            bool[] activation = new bool[NumEntries];
            foreach (var entry in list.Root.Elements("Element")) {
                int index = Convert.ToInt32(entry.Attribute("ID").Value);
                if (index >= NumEntries)
                    continue;

                activation[index] = Convert.ToBoolean(entry.Value);
            }

            return activation;
        }

        private static void WriteDlc(string output, bool[] activation)
        {
            DataStream stream = new DataStream(new MemoryStream(24), 0, 24);
            DataWriter writer = new DataWriter(stream);

            writer.Write(0x4E4B4E4E);   // 'NNKN'
            writer.Write(0x00);         // CRC updated later

            int bitCount = 0;
            uint value = 0;
            for (int i = 0; i < activation.Length; i++) {
                value |= (activation[i] ? 1u : 0u) << bitCount;
                bitCount++;

                if (bitCount == 32) {
                    writer.Write(value);
                    value = 0;
                    bitCount = 0;
                }
            }

            if (bitCount > 0)
                writer.Write(value);

            // Calculate CRC32
            stream.Seek(8, SeekMode.Origin);
            uint crc = Crc32.Run(stream, (uint)(stream.Length - 8));

            // Write it
            stream.Seek(4, SeekMode.Origin);
            writer.Write(crc);

            // Encode it
            stream.Seek(0, SeekMode.Origin);
            var encoded = Rc4.Run(stream, Key);
            encoded.WriteTo(output);

            encoded.Dispose();
            stream.Dispose();
        }
	}
}

