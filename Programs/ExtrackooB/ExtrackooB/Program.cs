// ----------------------------------------------------------------------
// <copyright file="Program.cs" company="none">

// Copyright (C) 2012
//
//   This program is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by 
//   the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.
//
//   This program is distributed in the hope that it will be useful, 
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details. 
//
//   You should have received a copy of the GNU General Public License
//   along with this program.  If not, see <http://www.gnu.org/licenses/>. 
//
// </copyright>

// <author>pleoNeX</author>
// <email>benito356@gmail.com</email>
// <date>06/10/2012 21:20:50</date>
// -----------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.IO;
using iTextSharp.text.pdf;

namespace ExtrackooB
{
    class Program
    {
        static string fileIn, folderOut;
        static int mode = 0;
        static int[] pages_num = new int[0];
        static string[] pages_name = new string[0];
        static int blocked = 0;
        static int quality = 0;
        static int convert = 0;
        static iTextSharp.text.Document pdf;
        static bool nofolder = false;

        static void Main(string[] args)
        {
            Console.WriteLine("GVD.dat extractor for \"Ni no kuni\"\t-> by pleonex\n");

            #region Get arguments
            if (args.Length < 3)
            {
                Show_Help();
                return;
            }

            for (int i = 0; i < args.Length - 2; i++)
            {
                switch (args[i])
                {
                    // Modes
                    case "-x": mode = 0; break;
                    case "-en":
                        if (i + 1 == args.Length)
                        {
                            Show_Help();
                            return;
                        }
                        mode = 1;

                        // Get number of pages to extract
                        string[] nums = args[++i].Split(',');
                        pages_num = new int[nums.Length];
                        for (int n = 0; n < nums.Length; n++)
                        {
                            try { pages_num[n] = Convert.ToInt32(nums[n]); }
                            catch { Show_Help(); return; }
                        }
                        break;
                    case "-es":
                        mode = 2;
                        pages_name = args[++i].Split(',');
                        break;
                        
                    // Options
                    case "-bx": blocked = 0; break;
                    case "-bb": blocked = 1; break;
                    case "-bu": blocked = 2; break;
                    case "-q":
                        try { quality = Convert.ToInt32(args[++i]); }
                        catch { Show_Help(); return; }
                        break;
                    case "-pdf": convert = 1; break;
                    case "-nofol": nofolder = true; break;

                    default: Show_Help(); return;
                }
            }
            fileIn = args[args.Length - 2];
            folderOut = args[args.Length - 1];
            if (!Directory.Exists(folderOut))
                Directory.CreateDirectory(folderOut);
            #endregion

            DateTime start = DateTime.Now;

            // Convert to PDF, initialize it
            if (convert == 1)
            {
                string pdf_file = Path.Combine(folderOut, Path.GetFileNameWithoutExtension(fileIn) + ".pdf");
                if (File.Exists(pdf_file))
                    File.Delete(pdf_file);
                pdf = new iTextSharp.text.Document();
                PdfWriter.GetInstance(pdf, new FileStream(pdf_file, FileMode.Create));
                pdf.Open();
                pdf.AddAuthor("Studio Ghibli - Level 5");
                pdf.AddTitle("Ni no kuni - Vademecum");
                pdf.AddSubject("Book extracted from the PS3 version of Ni no kuni.");
            }

            // WORK!
            Read_BookPack(fileIn, folderOut);

            if (convert == 1)
            {
                if (pdf.PageNumber == 0)
                {
                    pdf.NewPage();
                    pdf.Add(iTextSharp.text.Paragraph.GetInstance("No pages!"));
                }
                pdf.Close();
            }

            Console.WriteLine("\nFinished in {0}!", (DateTime.Now - start).ToString());
            Console.ReadKey(true);
        }
        static void Show_Help()
        {
            Console.WriteLine("Usage: extrackoob [mode] [options] \"fileIn\" \"folderOut\"");
            Console.WriteLine("** Mode");
            Console.WriteLine("\t-x\t\tExtract all pages");
            Console.WriteLine("\t-en a\t\tExtract page number 'a'.");
            Console.WriteLine("\t-es LR0001\tExtract page with input name (without extension).");
            Console.WriteLine("** Options");
            Console.WriteLine("\t-bx\t\tExtract blocked and unblocked images.");
            Console.WriteLine("\t-bb\t\tExtract blocked (if present) images.");
            Console.WriteLine("\t-bu\t\tExtract unblocked (if present) images.");
            Console.WriteLine("\n\t-q a\t\tExtract only images with quality 'a'\n\t\t\tfrom 0 to 6, -1  for all of them.");
            Console.WriteLine("\n\t-pdf\t\tConvert extracted images to PDF.");
            Console.WriteLine("\n\t-nofol\t\tExtract all the files in the same folder.");
            Console.WriteLine();
            Console.WriteLine("* Allowed multiple input in '-en' and '-es' separeted by ','.");
            Console.ReadKey(true);
        }

        static void Read_BookPack(string fileIn, string folderOut)
        {
            Console.WriteLine("Reading\t\t{0}", fileIn);
            Console.WriteLine("Output folder\t{0}\n", folderOut);

            BinaryReaderBE br;
            try { br = new BinaryReaderBE(fileIn); }
            catch (Exception ex) { Console.WriteLine("ERROR opening file: {0}", ex.Message); return; }

            // Read header
            ulong header = br.ReadUInt64();     // TGDT0100
            if (header != 0x5447445430313030)
            {
                Console.WriteLine("ERROR Invalid header! BOOK");
                return;
            }
            uint num_entries = br.ReadUInt32(); // Should be 0xB5
            uint data_offset = br.ReadUInt32(); // 0xB5 * 0x10 + padding

            Console.Write("Header:\t"); Show_String(header);
            Console.WriteLine("Pages:\t{0}", num_entries.ToString());

            sGVD[] gvds = new sGVD[num_entries];
            for (int i = 0; i < num_entries; i++)
            {
                br.BaseStream.Position = i * 0x10 + 0x10;   // Each entry is 0x10 bytes

                uint pageName_offset = br.ReadUInt32() + data_offset;   // Relative offset to page name
                uint pageName_size = br.ReadUInt32();                   
                gvds[i].offset = br.ReadUInt32() + data_offset;   // Relative offset to page data
                gvds[i].size = br.ReadUInt32();

                // Get page name
                br.BaseStream.Position = pageName_offset;
                gvds[i].name = Encoding.ASCII.GetString(br.ReadBytes((int)pageName_size));
                gvds[i].extension = Path.GetExtension(gvds[i].name);            // Separate extension from name
                gvds[i].name = Path.GetFileNameWithoutExtension(gvds[i].name);

                // Check if we should extract this page
                bool extract = false;
                if (mode == 0)      // Extract everything
                    extract = true;
                if (mode == 1)      // Extract page by number
                {
                    for (int n = 0; n < pages_num.Length; n++)
                        if (pages_num[n] == i)
                            extract = true;
                }
                else if (mode == 2) // Extract page by name
                {
                    for (int n = 0; n < pages_name.Length; n++)
                        if (pages_name[n] == gvds[i].name)
                            extract = true;
                }
                if (!extract)
                    continue;

                string folderPage = folderOut;
                if (!nofolder)
                {
                    folderPage = Path.Combine(folderOut, gvds[i].name);
                    if (!Directory.Exists(folderPage))
                        Directory.CreateDirectory(folderPage);
                }

                Console.WriteLine("\t| Reading (GVD) page {0} ({1})", i.ToString(), gvds[i].name);
                Read_GVD(br, gvds[i], folderPage);
            }

            br.Close();
            br = null;
        }
        static void Read_GVD(BinaryReaderBE br, sGVD gvd, string folderOut)
        {
            br.BaseStream.Position = gvd.offset;

            // Read header
            byte[] header = br.ReadBytes(0x10); // GVEW0100JPEG0100
            gvd.bigSize = new Size(br.ReadInt32(), br.ReadInt32());  // Size of the biggest quality

            Console.Write("\t\tHeader:\t"); Show_String(header);
            Console.WriteLine("\t\tBiggest size: {0}", gvd.bigSize.ToString() + " px");

            // Read first BLK_ section (contains TOC)
            BLK_Header blk1 = new BLK_Header();
            blk1.type = br.ReadUInt32();
            if (blk1.type != 0x424C4B5F)
            {
                Console.WriteLine("Error Invalid header! BLK_");
                return;
            }
            blk1.size = br.ReadUInt32();
            blk1.id = br.ReadUInt32();
            blk1.padding = br.ReadUInt32();
            
            // Unknown values, inside the BLK_ section
            br.ReadUInt32();    // Unknown: Always 0x20
            br.ReadUInt32();    // Unknown: Always 0x04

            // Start of the TOC section
            uint num_entries = blk1.size / BlockImage.ENTRY_SIZE;
            uint curroffset = gvd.offset + blk1.size + sGVD.HEADER_SIZE + 2 * BLK_Header.HEADER_SIZE;
            uint entry_offset = gvd.offset + sGVD.HEADER_SIZE + BLK_Header.HEADER_SIZE + 0x08;      // 0x08 = unknown values

            Page[] page = new Page[BlockImage.MAX_QUALITY];
            for (int i = 0; i < page.Length; i++)
                page[i].blocks = new List<BlockImage>();

            // Read each TOC entry into a BlockImage structure
            for (int i = 0; i < num_entries; i++)
            {
                br.BaseStream.Position = entry_offset + i * BlockImage.ENTRY_SIZE;

                BlockImage bi = new BlockImage();
                bi.posX = br.ReadUInt32();
                bi.posY = br.ReadUInt32();
                bi.quality = br.ReadUInt32();
                bi.data_size = br.ReadUInt32();
                bi.unk1 = br.ReadUInt32();
                bi.padding = br.ReadUInt32();
                bi.width = br.ReadUInt32();
                bi.height = br.ReadUInt32();

                // Get image data, it could be compressed in a GVMP structure
                // for blocked and unblocked images
                br.BaseStream.Position = curroffset;
                bi.data = new byte[1][];
                bi.data[0] = br.ReadBytes((int)bi.data_size);
                if (Encoding.ASCII.GetString(bi.data[0], 0, 4) == "GVMP")
                    bi.data = Decompress_GVMP(bi.data[0]);
                if (bi.data == null)
                    continue;
                
                page[bi.quality].blocks.Add(bi);

                // Pad size and add to the current offset
                curroffset += bi.data_size;
                if (curroffset % 0x10 != 0)
                    curroffset += 0x10 - (curroffset % 0x10);
            }

            // Draw and save page
            for (int i = 0; i < page.Length; i++)
            {
                if (quality != -1 && quality != i)
                    continue;

                if (page[i].blocks.Count == 0)
                    continue;

                // For blocked and unblocked
                for (int j = 0; j < page[i].blocks[0].data.Length; j++)
                {
                    // Check if we should extract that page
                    bool extract = (page[i].blocks[0].data.Length == 1);    // Only if there are blocked and unblocked pages
                    if (blocked == 0)
                        extract = true;
                    else if (blocked == 1 && j == 0)
                        extract = true;
                    else if (blocked == 2 &&  j == 1)
                        extract = true;
                    if (!extract)
                        continue;

                    string img_out = Path.Combine(folderOut, gvd.name + '_' + i.ToString());
                    if (j != 0)
                        img_out += "_unblocked";
                    img_out += ".jpg";

                    Bitmap bmp = Draw_Page(page[i], j);
                    if (bmp != null)
                    {
                        if (File.Exists(img_out))
                            File.Delete(img_out);
                        bmp.Save(img_out, System.Drawing.Imaging.ImageFormat.Jpeg);

                        // Add it to the pdf
                        if (convert == 1)
                        {
                            pdf.SetPageSize(new iTextSharp.text.Rectangle(0, 0, bmp.Width, bmp.Height));
                            pdf.NewPage();
                            iTextSharp.text.Image jpg = iTextSharp.text.Jpeg.GetInstance(img_out);
                            //jpg.Alignment = iTextSharp.text.Image.ORIGINAL_JPEG;
                            jpg.SetAbsolutePosition(0, 0);
                            pdf.Add(jpg);
                        }

                        bmp.Dispose();
                        bmp = null;
                    }
                }

                page[i].blocks.Clear();
            }
            page = null;
        }
        static byte[][] Decompress_GVMP(byte[] data)
        {
            uint header = ReadUInt32BE(data, 0);    // GVMP
            if (header != 0x47564D50)
            {
                Console.WriteLine("ERROR Invalid header! GVMP");
                return null;
            }
            uint num = ReadUInt32BE(data, 4);       // Must be 2

            byte[][] ret = new byte[num][];
            for (int i = 0; i < num; i++)
            {
                uint offset = ReadUInt32BE(data, 8 + 8 * i);
                uint size = ReadUInt32BE(data, 8 + 8 * i + 4);

                ret[i] = new byte[size];
                Array.Copy(data, offset, ret[i], 0, size);
            }

            return ret;
        }
        static Bitmap Draw_Page(Page page, int block)
        {
            if (page.blocks.Count == 0)
                return null;

            // Get image width
            BlockImage last_bi = page.blocks[page.blocks.Count - 1];
            int img_width = (int)(last_bi.posX * 0x100 + last_bi.width);
            int img_height = (int)(last_bi.posY * 0x100 + last_bi.height);

            Bitmap bmp = new Bitmap(img_width, img_height);
            Graphics graphic = Graphics.FromImage(bmp);

            // Write image
            for (int i = 0; i < page.blocks.Count; i++)
            {
                // Save the JPG data to open it
                string temp = Path.GetTempFileName();
                File.WriteAllBytes(temp, page.blocks[i].data[block]);
                Image img;
                try { img = Image.FromFile(temp); }
                catch { Console.WriteLine("Error opening JPG file!"); return null; }

                // Draw it
                graphic.DrawImageUnscaled(img,
                    (int)page.blocks[i].posX * 0x100,
                    (int)page.blocks[i].posY * 0x100);

                img.Dispose();
                img = null;
                File.Delete(temp);
            }
            graphic.Dispose();
            graphic = null;

            return bmp;
        }

        #region Helper
        static void Show_String(ulong s)
        {
            Console.WriteLine(Encoding.ASCII.GetString(BitConverter.GetBytes(s).Reverse().ToArray()));
        }
        static void Show_String(uint s)
        {
            Console.WriteLine(Encoding.ASCII.GetString(BitConverter.GetBytes(s).Reverse().ToArray()));
        }
        static void Show_String(byte[] s)
        {
            Console.WriteLine(Encoding.ASCII.GetString(s));
        }
        static uint ReadUInt32BE(byte[] data, int pos)
        {
            uint v = BitConverter.ToUInt32(data, pos);
            byte[] b = BitConverter.GetBytes(v).Reverse().ToArray();
            return BitConverter.ToUInt32(b, 0);
        }
        #endregion

    }

    struct sGVD
    {
        public const int HEADER_SIZE = 0x18;
        public uint offset;
        public uint size;
        public string name;
        public string extension;

        public Size bigSize;
    }
    struct Page
    {
        public List<BlockImage> blocks;
    }
    struct BlockImage
    {
        public const int ENTRY_SIZE = 0x20;
        public const int MAX_QUALITY = 7;

        public uint posX;           // must be multiplied by 0x0100
        public uint posY;           // must be multiplied by 0x0100
        public uint quality;        // from 0 to 6
        public uint data_size;
        public uint unk1;
        public uint padding;        // always 0x00
        public uint width;
        public uint height;
        public byte[][] data;       // for blocked and unblocked data
    }
    struct BLK_Header
    {
        public const int HEADER_SIZE = 0x10;
        public uint type;
        public uint size;
        public uint id;
        public uint padding;
    }
}
