//-----------------------------------------------------------------------
// <copyright file="Hpk.cs" company="none">
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
// <date>10/04/2013</date>
//-----------------------------------------------------------------------
namespace NinoDecompiler.Formats
{
    using System;
    using System.IO;
    
    /*
        Header
        00 - 04 - Type 01PH
        04 - 04 - Number of entries
        08 - 04 - File size
        0C - 04 - Header + FAT size
        10 - 04 - Name section offset
        14 - 04 - File section offset
        18 - 02 - Unknown, 20h
        1A - 02 - Unknown, 10h
        1C - 04 - Padding?
        
        FAT - For each file
        00 - 10 - Unknown, MD5?
        10 - 04 - Relative offset
        14 - 04 - File size
        18 - 04 - Name offset in TOC
        1C - 04 - File ID?
        
        Name - For each file
         String null-terminated
    */
    
    /// <summary>
    /// Description of Hpk.
    /// </summary>
    public class Hpk : Packer
    {
        public Hpk(GameFile file)
            : base(file)
        {
        }
        
        public static uint MagicStamp
        {
            get { return 0x30315048; /* '01PH' */ }
        }
        
        public override bool IsValid()
        {
            this.file.BaseStream.Position = this.file.Position;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);
            if (this.file.Size < 0x20 || br.ReadUInt32() != MagicStamp)
            {
                return false;
            }
            
            return true;
        }
        
        public override GameFile[] Unpack()
        {
            this.file.BaseStream.Position = this.file.Position;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);
            
            // Read header
            if (br.ReadUInt32() != MagicStamp)
            {
                throw new InvalidDataException();
            }
            
            uint numFiles = br.ReadUInt32();
            br.ReadUInt32();    // File size
            br.ReadUInt32();    // Header + FAT size
            uint nameSecOffset = br.ReadUInt32();
            uint fileSecOffset = br.ReadUInt32();
            br.ReadUInt32();    // Unknown, maybe FAT entry or header size?
            br.ReadUInt32();    // Unknown, maybe MD5 size?
            br.ReadUInt32();    // Unknown, padding?
            
            // Read FAT & name
            GameFile[] files = new GameFile[numFiles];
            for (int i = 0; i < numFiles; i++)
            {
                this.file.BaseStream.Position = this.file.Position + 0x20 + i * 0x20;
                files[i] = new GameFile(this.file.BaseStream);
                
                byte[] md5 = br.ReadBytes(0x10);
                files[i].Position = this.file.Position + fileSecOffset + br.ReadUInt32();
                files[i].Size = br.ReadUInt32();
                
                // Get name
                this.file.BaseStream.Position = this.file.Position + nameSecOffset + br.ReadUInt32();
                string relativePath = br.ReadString();
                //relativePath = relativePath.Replace('/', '\\');
                if (relativePath.Contains("//"))
                relativePath = relativePath.Replace("//", "");
                if (relativePath.Contains("/"))
                {
                    files[i].FileName = relativePath.Substring(relativePath.LastIndexOf('/') + 1);
                    files[i].FilePath = Path.Combine(
                        this.file.FilePath,
                        relativePath.Substring(0, relativePath.LastIndexOf('/')));
                }
                else
                {
                    files[i].FileName = relativePath;
                    files[i].FilePath = Path.Combine(this.file.FilePath, relativePath);
                }
                
                files[i].Parent = this.file;
                this.file.AddChild(files[i]);
            }
            
            br = null;
            return files;
        }
    }
}
