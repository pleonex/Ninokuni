//
//  Crc16.cs
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
using System.IO;

namespace NinoPatcher
{
    public static class Crc16
    {
        /// <summary>
        /// Calculates CRC16 from the stream.
        /// Code from "blz.c" (NDS Compressors) by CUE
        /// </summary>
        /// <param name="data">Data to calculate the checksum</param>
        public static ushort Calculate(Stream data, uint length)
        {
            ushort crc;
            uint   nbits;

            crc = 0xFFFF;
            while (length-- != 0) {
                crc ^= (byte)data.ReadByte();
                nbits = 8;
                while (nbits-- != 0) {
                    if ((crc & 1) != 0) { crc = (ushort)((crc >> 1) ^ 0xA001); }
                    else                  crc = (ushort)(crc >> 1);
                }
            }

            return crc;
        }
    }
}