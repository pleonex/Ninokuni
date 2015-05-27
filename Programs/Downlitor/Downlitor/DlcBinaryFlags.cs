//
//  DlcBinaryFlags.cs
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
using System.Xml.Linq;
using Libgame.IO;
using System.IO;
using Libgame.Utils.Checksums;

namespace Downlitor
{
    public class DlcBinaryFlags
    {
        private static readonly byte[] Key = new byte[] {
            0x72, 0x2B, 0x41, 0x8B, 0x4C, 0xFB, 0x9F, 0x27,
            0xB2, 0x1D, 0x05, 0xAF, 0xFB, 0x2B, 0x80, 0x9F
        };

        private bool[] flags;

        public DlcBinaryFlags()
        {
            flags = new bool[DlcManager.Instance.NumEntries];
        }

        public static DlcBinaryFlags FromDlc(string dlc)
        {
            DlcBinaryFlags dlcBinary = new DlcBinaryFlags();
            dlcBinary.Read(dlc);
            return dlcBinary;
        }

        public static DlcBinaryFlags FromXml(string xml)
        {
            DlcBinaryFlags dlcBinary = new DlcBinaryFlags();
            dlcBinary.Import(XDocument.Load(xml));
            return dlcBinary;
        }
            
        private void Read(string dlc)
        {
            using (DataStream decoded = new DataStream(new MemoryStream(), 0, -1)) {
                // Decode data
                using (DataStream dlcStream = new DataStream(dlc, FileMode.Open, FileAccess.Read))
                    Rc4.Run(dlcStream, Key, decoded);

                // Read it
                decoded.Seek(8, SeekMode.Origin);
                ReadFlags(decoded);
            }
        }

        private void ReadFlags(DataStream stream)
        {
            byte bitCount = 0;
            byte value = 0;
            for (int i = 0; i < flags.Length; i++) {
                if (bitCount == 0) {
                    value = stream.ReadByte();
                    bitCount = 8;
                }

                flags[i] = (value & 1) == 1;
                value >>= 1;
                bitCount--;
            }
        }

        public void Write(string output)
        {
            using (DataStream stream = new DataStream(new MemoryStream(24), 0, 24)) {
                DataWriter writer = new DataWriter(stream);

                // Write data
                writer.Write(0x4E4B4E4E);   // 'NNKN'
                writer.Write(0x00);         // CRC updated later
                WriteFlags(writer);

                // Calculate CRC32
                stream.Seek(8, SeekMode.Origin);
                uint crc = Crc32.Run(stream, (uint)(stream.Length - 8));
                stream.Seek(4, SeekMode.Origin);
                writer.Write(crc);

                // Encode and write
                stream.Seek(0, SeekMode.Origin);
                using (DataStream outputStream = new DataStream(output, FileMode.Create, FileAccess.Write))
                    Rc4.Run(stream, Key, outputStream);
            }
        }

        private void WriteFlags(DataWriter writer)
        {
            int bitCount = 0;
            uint value = 0;
            for (int i = 0; i < flags.Length; i++) {
                value |= (flags[i] ? 1u : 0u) << bitCount;
                bitCount++;

                if (bitCount == 32) {
                    writer.Write(value);
                    value = 0;
                    bitCount = 0;
                }
            }

            if (bitCount > 0)
                writer.Write(value);
        }

        private void Import(XDocument list)
        {
            foreach (var entry in list.Root.Elements("Element")) {
                int index = Convert.ToInt32(entry.Attribute("ID").Value);
                if (index >= flags.Length)
                    continue;

                flags[index] = Convert.ToBoolean(entry.Value);
            }
        }

        public void Export(string output)
        {
            XDocument xml = new XDocument();
            XElement root = new XElement("NinoDlc");

            var manager = DlcManager.Instance;
            for (int i = 0; i < manager.NumEntries; i++) {
                XElement entry = new XElement("Element");
                entry.SetAttributeValue("ID", i.ToString("D2"));
                entry.SetAttributeValue("Name", manager[i]);
                entry.Value = flags[i].ToString();
                root.Add(entry);
            }

            xml.Add(root);
            xml.Save(output);
        }
    }
}

