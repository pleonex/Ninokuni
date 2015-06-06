//-----------------------------------------------------------------------
// <copyright file="Deflate.cs" company="none">
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
namespace NinoDecompiler.Encoding
{
    using System;
    using System.IO;
    using Ionic.Zlib;
    
    /// <summary>
    /// Description of Deflate.
    /// </summary>
    public class Deflate : Encoder
    {
        private const int BufferSize = 5 * 1024;    // 5KB
        
        public Deflate(Stream stream, long position, long encodedSize)
            : base(stream, position, encodedSize)
        {
        }
        
        public override void Decode(Stream streamOut, long decodedSize)
        {
            int writtenBytes = 0;
            long offset = this.pos;
            
            DeflateStream deflate;
            while (writtenBytes < decodedSize)
            {
                this.stream.Position = offset;
                deflate = new DeflateStream(this.stream, CompressionMode.Decompress, true);

                int count = 0;
                byte[] buffer = new byte[BufferSize];
                do
                {
                    count = deflate.Read(buffer, 0, BufferSize);
                    if (count != 0)
                    {
                        streamOut.Write(buffer, 0, count);
                        writtenBytes += count;
                    }
                   
                } while (count > 0);

                offset += deflate.Position;
                streamOut.Flush();
            }
                        
            if (writtenBytes != decodedSize)
            {
                Console.WriteLine("# Warning: Decoded size doesn't match.");
            }
            
            if (this.stream.Position - this.pos < this.encSize)
            {
                Console.WriteLine("# Warning: There are data to process still.");
            }
        }
    }
}
