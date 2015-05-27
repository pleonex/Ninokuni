using System;
using System.Linq;
using System.Xml.Linq;
using Libgame;
using Libgame.IO;

namespace NinoTweet
{
    public class Tweet
    {
        private const string MagicHeader = "NTWM";  // Nintendo TWeet Media ??
        private const int NumEntries = 7;
        private Entry[] entries;

        public Tweet()
        {
            this.entries = new Entry[NumEntries];
        }

        public void Read(string file)
        {
			DataStream stream = new DataStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            this.Read(stream);
            stream.Dispose();
        }

		public void Read(DataStream inStr)
        {
			DataReader br = new DataReader(inStr);
			if (br.ReadString(4) != MagicHeader)
                throw new FormatException("Invalid MagicHeader");

			br.ReadUInt32();
            //uint crc32 = br.ReadUInt32();
            // TODO: Check CRC

            for (int i = 0; i < NumEntries; i++)
                this.entries[i] = Entry.FromStream(inStr);
        }

		public void Write(DataStream outStr)
        {
			DataWriter bw = new DataWriter(outStr);
            bw.Write(MagicHeader);

            uint crc = 0;   // TODO: Calculate CRC
            bw.Write(crc);

            foreach (Entry entry in this.entries)
                entry.Write(outStr);
        }

        public void Export(string filePath)
        {
            XDocument xml = new XDocument();
            xml.Declaration = new XDeclaration("1.0", "utf-8", "yes");

            XElement root = new XElement("NinoTweet");
            xml.Add(root);

			foreach (Entry entry in this.entries)
				root.Add(entry.Export());

			xml.Save(filePath);
        }

        public void Import(string filePath)
        {
            XDocument xml = XDocument.Load(filePath);

            if (xml.Root.Elements().Count() != NumEntries)
                throw new FormatException("The XML does NOT have 7 entries");

            int i = 0;
            foreach (XElement xmlEntry in xml.Root.Elements())
                this.entries[i++] = Entry.FromXml(xmlEntry);
        }

        private class Entry
        {
            private static readonly System.Text.Encoding Encoding = System.Text.Encoding.GetEncoding("shift_jis");
            private const int TitleSize = 0x30;
            private const int BodySize  = 0x120;

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

				entry.Title = br.ReadString(TitleSize);
				entry.Body  = br.ReadString(BodySize);
                entry.Id    = br.ReadUInt16();
                entry.Date  = new DateTime(br.ReadUInt16(), br.ReadUInt16(), br.ReadUInt16());

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
				bw.Write(this.Title, TitleSize);
				bw.Write(this.Body,  BodySize);
                bw.Write(this.Id);
                bw.Write((ushort)this.Date.Year);
                bw.Write((ushort)this.Date.Month);
                bw.Write((ushort)this.Date.Day);
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

