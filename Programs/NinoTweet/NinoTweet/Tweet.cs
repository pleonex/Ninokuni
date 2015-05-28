//
//  Tweet.cs
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
using Libgame.IO;
using Libgame.Utils.Checksums;

namespace NinoTweet
{
    public class Tweet
    {
        private static readonly byte[] Key = new byte[] {
            0x72, 0x2B, 0x41, 0x8B, 0x4C, 0xFB, 0x9F, 0x27,
            0xB2, 0x1D, 0x05, 0xAF, 0xFB, 0x2B, 0x80, 0x9F
        };

        private const string MagicHeader = "NTWM";  // Nintendo TWeet Media ??
        private const int MaxEntries = 7;
        private Entry[] entries;

        public Tweet()
        {
            entries = new Entry[MaxEntries];
            for (int i = 0; i < MaxEntries; i++)
                entries[i] = new Entry();
        }

        public void Read(string file)
        {
            using (DataStream stream = new DataStream(file, FileMode.Open, FileAccess.Read))
                Read(stream);
        }

		public void Read(DataStream inStr)
        {
            using (var decodedStr = new DataStream(new MemoryStream(), 0, -1)) {
                // Decode data
                Rc4.Run(inStr, Key, decodedStr);
                decodedStr.Seek(0, SeekMode.Origin);

                DataReader br = new DataReader(decodedStr);
                if (br.ReadString(4) != MagicHeader)
                    throw new FormatException("Invalid MagicHeader");

                br.ReadUInt32();    // CRC, I am not checking it

                for (int i = 0; i < MaxEntries; i++)
                    this.entries[i] = Entry.FromStream(decodedStr);
            }
        }

        public void Write(string file)
        {
            using (var stream = new DataStream(file, FileMode.Create, FileAccess.Write))
                Write(stream);
        }

		public void Write(DataStream outStr)
        {
            using (var decodedStr = new DataStream(new MemoryStream(), 0, -1)) {
                DataWriter bw = new DataWriter(decodedStr);
                bw.Write(MagicHeader);
                bw.Write((uint)0x00);   // CRC will be updated later

                foreach (Entry entry in this.entries)
                    entry.Write(decodedStr);

                // Calculate CRC and write it
                decodedStr.Seek(8, SeekMode.Origin);
                uint crc = Crc32.Run(decodedStr, (uint)decodedStr.Length - 8);
                decodedStr.Seek(4, SeekMode.Origin);
                bw.Write(crc);

                // Encode and write
                decodedStr.Seek(0, SeekMode.Origin);
                Rc4.Run(decodedStr, Key, outStr);
            }
        }

        public void Export(string filePath)
        {
            XDocument xml = new XDocument();
            xml.Declaration = new XDeclaration("1.0", "utf-8", "yes");

            XElement root = new XElement("NinoTweet");
            xml.Add(root);

			foreach (Entry entry in entries)
				root.Add(entry.Export());

			xml.Save(filePath);
        }

        public void Import(string filePath)
        {
            XDocument xml = XDocument.Load(filePath);

            int i = 0;
            foreach (XElement xmlEntry in xml.Root.Elements())
                entries[i++] = Entry.FromXml(xmlEntry);
        }

        private class Entry
        {
            private static readonly System.Text.Encoding Encoding = System.Text.Encoding.GetEncoding("shift_jis");
            private const int TitleSize = 0x30;
            private const int BodySize  = 0x120;

            public Entry()
            {
                Title = "";
                Body  = "";
                Date  = new DateTime(1, 1, 1);
                Id = 0; // If ID is 0, the game skip this entry
            }

            public static int Size {
                get { return 0x158; }
            }

            public string Title {
                get;
                set;
            }

            public string Body {
                get;
                set;
            }

            public DateTime Date {
                get;
                set;
            }

            public ushort Id {
                get;
                set;
            }

			public static Entry FromStream(DataStream inStr)
            {
				DataReader br = new DataReader(inStr, EndiannessMode.LittleEndian, Encoding);
                Entry entry = new Entry();

				entry.Title = br.ReadString(TitleSize, "replace", false);
				entry.Body  = br.ReadString(BodySize, "replace", false);
                entry.Id    = br.ReadUInt16();

                ushort year  = br.ReadUInt16();
                ushort month = br.ReadUInt16();
                ushort day   = br.ReadUInt16();

                if (year > 0)
                    entry.Date = new DateTime(year, month, day);
                else
                    entry.Date = new DateTime(1, 1, 1);

                return entry;
            }

            public static Entry FromXml(XElement xml)
            {
                Entry entry = new Entry();
                entry.Id    = Convert.ToUInt16(xml.Element("Id").Value, 16);
                entry.Date  = DateTime.Parse(xml.Element("Date").Value);
				entry.Title = xml.Element("Title").Value.FromXmlString('<', '>');
				entry.Body  = xml.Element("Body").Value.FromXmlString('<', '>');
                
                return entry;
            }

			public void Write(DataStream outStr)
            {
				DataWriter bw = new DataWriter(outStr, EndiannessMode.LittleEndian, Encoding);
				bw.Write(this.Title, TitleSize, "replace", true);
				bw.Write(this.Body,  BodySize, "replace", true);
                bw.Write(this.Id);

                if (this.Date.Year > 1) {
                    bw.Write((ushort)this.Date.Year);
                    bw.Write((ushort)this.Date.Month);
                    bw.Write((ushort)this.Date.Day);
                } else {
                    bw.Write((ushort)0x00);
                    bw.Write((ushort)0x00);
                    bw.Write((ushort)0x00);
                }
            }

            public XElement Export()
            {
                XElement root = new XElement("Tweet");
                root.Add(new XElement("Id", this.Id.ToString("X4")));
                root.Add(new XElement("Date", this.Date.ToShortDateString()));
				root.Add(new XElement("Title", this.Title.ToXmlString(3, '<', '>')));
				root.Add(new XElement("Body", this.Body.ToXmlString(3, '<', '>')));
                return root;
            }
        }
    }
}

