// ----------------------------------------------------------------------
// <copyright file="BinaryReaderBE.cs" company="none">

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
// <date>06/10/2012 21:21:36</date>
// -----------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace System.IO
{
    public class BinaryReaderBE : BinaryReader
    {
        private static readonly Encoding DefaultEncoding = Encoding.UTF8;
        
        public BinaryReaderBE(Stream stream)
            : base(stream)
        {
        }
        
        public BinaryReaderBE(string file) : base(File.OpenRead(file)) { }
        
        public override string ReadString()
        {
            List<byte> data = new List<byte>();
            while (this.ReadByte() != 0)
            {
                this.BaseStream.Position--;
                data.Add(this.ReadByte());
            }
               
            string s = DefaultEncoding.GetString(data.ToArray());
            data.Clear();
            s = s.Replace("\n", Environment.NewLine);
            s = s.Replace("\\n", Environment.NewLine);
            
            //if (s.ToLower().Contains("bighorn"))
            //{
            //    return s;
            //}
            
            return s;
        }
        
        /// <inheritdoc />
        public override decimal ReadDecimal()
        {
            throw new NotSupportedException();
        }
        
        /// <inheritdoc />
        public override double ReadDouble()
        {
            byte[] b = BitConverter.GetBytes(base.ReadDouble());
            return BitConverter.ToDouble(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override short ReadInt16()
        {
            byte[] b = BitConverter.GetBytes(base.ReadInt16());
            return BitConverter.ToInt16(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override int ReadInt32()
        {
            byte[] b = BitConverter.GetBytes(base.ReadInt32());
            return BitConverter.ToInt32(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override long ReadInt64()
        {
            byte[] b = BitConverter.GetBytes(base.ReadInt64());
            return BitConverter.ToInt64(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override float ReadSingle()
        {
            byte[] b = BitConverter.GetBytes(base.ReadSingle());
            return BitConverter.ToSingle(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override ushort ReadUInt16()
        {
            byte[] b = BitConverter.GetBytes(base.ReadUInt16());
            return BitConverter.ToUInt16(b.Reverse().ToArray(), 0);
        }
        
        /// <inheritdoc />
        public override uint ReadUInt32()
        {
            byte[] b = BitConverter.GetBytes(base.ReadUInt32());
            return BitConverter.ToUInt32(b.Reverse().ToArray(), 0);
        }
        
        public uint[] ReadUInt32s(int count)
        {
            uint[] val = new uint[count];
            for (int i = 0; i < count; i++)
            {
                val[i] = this.ReadUInt32();
            }
            
            return val;
        }
        
        /// <inheritdoc />
        public override ulong ReadUInt64()
        {
            byte[] b = BitConverter.GetBytes(base.ReadUInt64());
            return BitConverter.ToUInt64(b.Reverse().ToArray(), 0);
        }
    }
}
