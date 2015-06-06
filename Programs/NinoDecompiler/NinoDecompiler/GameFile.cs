//-----------------------------------------------------------------------
// <copyright file="GameFile.cs" company="none">
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
namespace NinoDecompiler
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    
    /// <summary>
    /// Description of GameFile.
    /// </summary>
    public class GameFile : IDisposable
    {
        private List<GameFile> childs = new List<GameFile>();
        
        public GameFile(string filepath)
        {
            this.BaseStream = File.OpenRead(filepath);
            this.Position = 0;
            this.Size = this.BaseStream.Length;
            this.FilePath = Path.GetDirectoryName(filepath);
            this.FileName = Path.GetFileName(filepath);
        }
        
        public GameFile(Stream stream)
        {
            this.BaseStream = stream;
        }
        
        public int NumChilds
        {
            get { return childs.Count; }
        }
        
        public Stream BaseStream
        {
            get;
            set;
        }
        
        public long Position
        {
            get;
            set;
        }
        
        public long Size
        {
            get;
            set;
        }
        
        public string FilePath
        {
            get;
            set;
        }
        
        public string FileName
        {
            get;
            set;
        }
              
        public GameFile Parent
        {
            get;
            set;
        }
        
        public void AddChild(GameFile child)
        {
            this.childs.Add(child);
        }
               
        public void Dispose()
        {
            if (this.childs.Count == 0)
            {
                if (this.Parent == null)
                {
                    this.Close();
                }
                else
                {
                    this.Parent.RemoveChild(this);
                }
            }
            else
            {
                throw new Exception();
            }
        }
        
        public uint ReadMagicStamp()
        {
            if (this.BaseStream != null && this.Size >= 4)
            {
                this.BaseStream.Position = this.Position;
                
                uint ms = (uint)this.BaseStream.ReadByte() << 24;
                ms |= (uint)this.BaseStream.ReadByte() << 16;
                ms |= (uint)this.BaseStream.ReadByte() << 8;
                ms |= (uint)this.BaseStream.ReadByte();
                return ms;
            }
            
            return 0x00;
        }
        
        public void Export()
        {
            string fileOut = Path.Combine(this.FilePath, this.FileName);
            if (!Directory.Exists(this.FilePath))
            {
                Directory.CreateDirectory(this.FilePath);
            }
            
            if (File.Exists(fileOut))
            {
                File.Delete(fileOut);
            }
            
            FileStream fs = new FileStream(fileOut, FileMode.CreateNew, FileAccess.Write);
            this.BaseStream.Position = this.Position;
            
            byte[] buffer = new byte[5*1024];
            int written = 0;
            while (written < this.Size)
            {
                int bytesToRead = (written + buffer.Length > this.Size) ?
                    (int)(this.Size - written) : buffer.Length;
                int count = this.BaseStream.Read(buffer, 0, bytesToRead);
                fs.Write(buffer, 0, count);
                fs.Flush();
                written += count;
            }
            
            fs.Close();
            fs.Dispose();
        }
        
        private void RemoveChild(GameFile child)
        {
            this.childs.Remove(child);
            
            if (this.childs.Count == 0)
            {
                this.Dispose();
            }
        }
        
        private void Close()
        {
            this.BaseStream.Close();
            this.BaseStream.Dispose();
            this.BaseStream = null;
        }
    }
}
