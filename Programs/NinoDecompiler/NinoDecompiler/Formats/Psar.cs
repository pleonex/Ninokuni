//-----------------------------------------------------------------------
// <copyright file="Psar.cs" company="none">
// Copyright (C) 2013
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
//   along with this program.  If not, see "http://www.gnu.org/licenses/". 
// </copyright>
// <author>pleoNeX</author>
// <email>benito356@gmail.com</email>
// <date>09/04/2013</date>
//-----------------------------------------------------------------------
namespace NinoDecompiler.Formats
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Security.Cryptography;
    using System.Text;
    using NinoDecompiler.Encoding;
    
    /// <summary>
    /// Description of Psar.
    /// </summary>
    public class Psar : Packer
    {
        private const uint Compression = 0x7A6C6962;    // 'zlib
        private const uint Version = 0x00010004;
        private const int TocOffset = 0x20;
        private const string Md5Null = "00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00";
        private static readonly System.Text.Encoding DefaultEncoding = System.Text.Encoding.GetEncoding("shift_jis");
        
        public Psar(GameFile file)
            : base(file)
        {
        }
        
        public static uint MagicStamp
        {
            get { return 0x50534152; /* 'PSAR' */ }
        }
        
        public override bool IsValid()
        {
            this.file.BaseStream.Position = this.file.Position;
            return IsValid(this.file.BaseStream);
        }
        
        public static bool IsValid(Stream str)
        {
            if (str.Length - str.Position < 12)
            {
                return false;
            }
            
            BinaryReaderBE br = new BinaryReaderBE(str);
            if (br.ReadUInt32() == MagicStamp &&
                br.ReadUInt32() == Version &&
                br.ReadUInt32() == Compression)
            {
                return true;
            }
            
            return false;
        }
        
        public override GameFile[] Unpack()
        {
            this.file.BaseStream.Position = this.file.Position;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);

            // Read header
            if (br.ReadUInt32() != MagicStamp ||
                br.ReadUInt32() != Version    ||
                br.ReadUInt32() != Compression )
            {
                throw new InvalidDataException();
            }
            
            uint offsetData = br.ReadUInt32();
            uint tocEntrySize = br.ReadUInt32();
            uint numFiles = br.ReadUInt32();
            uint unknown1 = br.ReadUInt32();
            uint unknown2 = br.ReadUInt32();

            // Read the TOC
            int fileListIndex = -1;
            TOCEntry[] toc = new TOCEntry[numFiles];
            for (int i = 0; i < numFiles; i++)
            {
                br.BaseStream.Position = this.file.Position + TocOffset + i * tocEntrySize;

                // Read entry
                toc[i].Md5Name = BitConverter.ToString(br.ReadBytes(0x10));
                toc[i].Block = br.ReadUInt32();
                toc[i].Size = br.ReadInt64() >> 24;    // Only 5 bytes
                br.BaseStream.Position -= 3;
                toc[i].Offset = br.ReadInt64() >> 24;   // Only 5 bytes

                if (toc[i].Md5Name == Md5Null)
                {
                    fileListIndex = i;
                }
            }

            // Read the file name table
            if (fileListIndex == -1)
            {
                throw new InvalidDataException("Error, file list NOT FOUND!");
            }

            GameFile listFile = this.GetFile(toc[fileListIndex]);
            BinaryReader brList = new BinaryReader(listFile.BaseStream);
            brList.BaseStream.Position = listFile.Position;
            byte[] listData = brList.ReadBytes((int)listFile.Size);
            string[] list = DefaultEncoding.GetString(listData).Split('\n');
            if (listFile.Parent == null)
            {
                listFile.BaseStream.Close();
                listFile.BaseStream.Dispose();
            }
                                       
            // For each entry search it relative path
            List<GameFile> files = new List<GameFile>();
            for (int i = 0; i < list.Length; i++)
            {
                // Matchs the md5 codes
                string md5 = ComputeMd5(list[i]);
                
                TOCEntry entry = new TOCEntry();
                for (int j = 0; j < toc.Length; j++)
                {
                    if (md5 == toc[j].Md5Name)
                    {
                        entry = toc[j];
                        break;
                    }
                }

                if (entry.Md5Name == null)
                {
                    throw new FileNotFoundException("Relative path: " + list[i] + " NOT FOUND!");
                }

                GameFile unpackFile = this.GetFile(entry);
                
                unpackFile.FileName = list[i].Substring(list[i].LastIndexOf('/') + 1);
                string relativePath = list[i].Substring(1, list[i].LastIndexOf('/'));
                //relativePath = relativePath.Replace('/', '\\');
                unpackFile.FilePath = Path.Combine(this.file.FilePath, relativePath);
                
                files.Add(unpackFile);
            }

            br = null;
            return files.ToArray();
        }
        
        private GameFile GetFile(TOCEntry entry)
        {
            GameFile unpackFile;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);
            
                // Check compression
            this.file.BaseStream.Position = this.file.Position + entry.Offset;
            if (Zlib.IsValid(br.ReadUInt16()))
            {
                unpackFile = new GameFile(new MemoryStream((int)entry.Size));
                Zlib zlib = new Zlib(this.file.BaseStream, this.file.Position + entry.Offset, -1);
                zlib.Decode(unpackFile.BaseStream, entry.Size);
            }
            else
            {
                unpackFile = new GameFile(this.file.BaseStream);
                unpackFile.Position = this.file.Position + entry.Offset;
                unpackFile.Parent = this.file;
                this.file.AddChild(unpackFile);
            }
            
            unpackFile.Size = entry.Size;
            return unpackFile;
        }
        
        private static string ComputeMd5(string s)
        {
            byte[] data = DefaultEncoding.GetBytes(s);

            MD5 md5 = MD5.Create();
            byte[] md5Code = md5.ComputeHash(data);
            md5.Clear();
            md5 = null;

            return BitConverter.ToString(md5Code);
        }
        
        private struct TOCEntry
        {
            public uint Block
            {
                get; set;
            }
            
            public long Size
            {
                get; set;
            }
            
            public long Offset
            {
                get; set;
            }
            
            public string Md5Name
            {
                get; set;
            }
        }
    }
}
