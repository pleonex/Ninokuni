//-----------------------------------------------------------------------
// <copyright file="Zarc.cs" company="none">
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
    using System.IO;
    using NinoDecompiler.Encoding;
    
    /// <summary>
    /// Description of Zarc.
    /// </summary>
    public class Zarc : Packer
    {
        private const ushort Version = 0x1;
        private const int HeaderSize = 0x10;
        private const int EntrySize = 0x08;
        
        
        public Zarc(GameFile file)
            : base(file)
        {
        }
        
        public static uint MagicStamp
        {
            get { return 0x7A617263; /* 'zarc' */ }
        }
        
        public override bool IsValid()
        {
            this.file.BaseStream.Position = this.file.Position;
            return IsValid(this.file.BaseStream);
        }
        
        public static bool IsValid(Stream str)
        {
            if (str.Length - str.Position < 8)
            {
                return false;
            }
            
            BinaryReaderBE br = new BinaryReaderBE(str);
            if (br.ReadUInt32() == MagicStamp && br.ReadUInt16() == Version)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        public override GameFile[] Unpack()
        {
            this.file.BaseStream.Position = this.file.Position;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);
            GameFile decoded;
            
            // Read header
            if (br.ReadUInt32() != MagicStamp)
            {
                throw new InvalidDataException();
            }
            
            if (br.ReadUInt16() != Version)
            {
                throw new InvalidDataException();
            }
            
            ushort numBlocks = br.ReadUInt16();
            int decompressedSize = br.ReadInt32();
            uint fileSize = br.ReadUInt32();
            
            decoded = new GameFile(new MemoryStream(decompressedSize));
            decoded.Size = decompressedSize;
            decoded.FilePath = this.file.FilePath;
            if (this.file.FileName.Contains(".zarc"))
            {
                decoded.FileName = this.file.FileName.Remove(this.file.FileName.LastIndexOf(".zarc"));
            }
            else
            {
                decoded.FileName = this.file.FileName;
            }
            
            for (int i = 0; i < numBlocks; i++)
            {
                this.file.BaseStream.Position = this.file.Position + HeaderSize + i * EntrySize;
                
                // Read entry
                int blockCompSize = br.ReadUInt16();
                int blockDecompSize = br.ReadUInt16();
                uint dataOffset = br.ReadUInt32();
                
                if (blockDecompSize == 0)
                {
                    blockDecompSize = 0x10000;
                }
                
                // Invalid file
                if (dataOffset <= 0x20)
                {
                    return new GameFile[0];
                }
                
                Deflate deflate = new Deflate(
                    this.file.BaseStream,
                    this.file.Position + dataOffset - 1,
                    blockCompSize);
                try
                {
                    deflate.Decode(decoded.BaseStream, blockDecompSize);
                }
                catch
                {
                    return new GameFile[0];
                }
            }
            
            br = null;
            
            return new GameFile[] { decoded };
        }
    }
}
