using System;
using System.IO;
using System.Xml.Linq;
using Libgame;

namespace NinoTweet
{
    class MainClass
    {
        private static readonly byte[] Key = new byte[] {
            0x72, 0x2B, 0x41, 0x8B, 0x4C, 0xFB, 0x9F, 0x27,
            0xB2, 0x1D, 0x05, 0xAF, 0xFB, 0x2B, 0x80, 0x9F
        };

        public static void Main(string[] args)
        {
            args = new string[] { "tweet111209.bin" };

            if (args.Length != 1)
                return;

			XDocument xml = new XDocument();
			XElement root = new XElement("Configuration");
			root.Add(new XElement("RelativePaths"));
			root.Add(new XElement("CharTables"));
			XElement spchar = new XElement("SpecialChars");
			spchar.Add(new XElement("Ellipsis", "…"));
			spchar.Add(new XElement("QuoteOpen", "ﾜ"));
			spchar.Add(new XElement("QuoteClose", "ﾝ"));
			spchar.Add(new XElement("FuriganaOpen", "【"));
			spchar.Add(new XElement("FuriganaClose", "】"));
			root.Add(spchar);
			xml.Add(root);
			Configuration.Initialize(xml);

            string inputPath = args[0];
            string outputPath = Path.Combine(
                Path.GetDirectoryName(inputPath),
                Path.GetFileNameWithoutExtension(inputPath) + "_new" + ".bin"
                                );
			string outputXmlPath = Path.Combine(
				Path.GetDirectoryName(inputPath),
				Path.GetFileNameWithoutExtension(inputPath) + ".xml"
			                       );

            byte[] output = Rc4.Run(File.ReadAllBytes(args[0]), Key);
            File.WriteAllBytes(outputPath, output);

			Tweet tweet = new Tweet();
			tweet.Read(outputPath);
			tweet.Export(outputXmlPath);
        }
    }
}
