//
//  Program.cs
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
using Libgame.IO;

namespace Downlitor
{
    public static class Rc4
    {
        public static DataStream Run(DataStream data, byte[] key)
        {
            byte[] s = CreateArrayS(key);
            DataStream output = new DataStream(
                new System.IO.MemoryStream((int)data.Length), 0, data.Length);

            for (int i = 0, j = 0; data.Position < data.Length; ) {
                i = (i + 1) % 256;
                j = (j + s[i]) % 256;

                byte swap = s[i];
                s[i] = s[j];
                s[j] = swap;

                byte k = s[(s[i] + s[j]) % 256];
                output.WriteByte((byte)(data.ReadByte() ^ k));
            }

            return output;
        }

        private static byte[] CreateArrayS(byte[] key)
        {
            byte[] s = new byte[256];
            byte[] t = new byte[256];

            for (int i = 0; i < 256; i++) {
                s[i] = (byte)i;
                t[i] = key[i % key.Length];
            }
                
            for (int i = 0, j = 0; i < 256; i++) {
                j = (j + s[i] + t[i]) % 256;

                byte swap = s[i];
                s[i] = s[j];
                s[j] = swap;
            }

            return s;
        }
    }
}

