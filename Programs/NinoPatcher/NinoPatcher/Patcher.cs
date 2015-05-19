//
//  Patcher.cs
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
using System.Security.Cryptography;

namespace NinoPatcher
{
    public class Patcher
    {
        private const string PatchId = "NinoPatcher.Resources.PatchES.xdelta";
        private const string AntiPiracyId = "NinoPatcher.Resources.AP.xdelta";
        private const string BannerId = "NinoPatcher.Resources.Banner.xdelta";
        private static readonly string CleanMd5 = "f0e3027b9e97618732b4f2d4298ad0cf";

        public bool AntiPiracy {
            get;
            set;
        }

        public bool Banner {
            get;
            set;
        }

        public bool CheckCleanRom(string cleanRom)
        {
            bool isClean = false;
            using (FileStream fs = 
                new FileStream(cleanRom, FileMode.Open, FileAccess.Read, FileShare.Read)) {

                MD5 md5 = MD5.Create();
                string currentHash = BitConverter.ToString(md5.ComputeHash(fs));
                currentHash = currentHash.Replace("-", "").ToLower();

                isClean = (currentHash == CleanMd5);
                md5.Clear();
            }

            return isClean;
        }

        public void Patch(string fileIn, string fileOut)
        {
            throw new NotImplementedException();
        }
    }
}

