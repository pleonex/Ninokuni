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
using Xdelta;
using System.Reflection;

namespace NinoPatcher
{
    public class Patcher
    {
        private const string PatchId = "NinoPatcher.Resources.PatchES.xdelta";
        private const long ExpectedLength = 512 * 1024 * 1024;
        private static readonly string[] Md5s = {
            "f0e3027b9e97618732b4f2d4298ad0cf", // ROM
            "", // ROM + Spanish Patch
            "", // ROM + Spanish Patch + AP
            "", // ROM + Spanish Patch + Banner
            ""  // ROM + Spanish Patch + AP + Banner
        };


        public Patcher(bool antipiracy, bool banner)
        {
            AntiPiracy = antipiracy;
            Banner = banner;
            Translation = true; // By default true, later will disable if needed
        }

        public bool Translation {
            get;
            private set;
        }

        public bool AntiPiracy {
            get;
            private set;
        }

        public bool Banner {
            get;
            private set;
        }

        public string Input {
            get;
            private set;
        }

        public string Output {
            get;
            private set;
        }

        public bool SetInput(string input)
        {
            bool valid = CheckRomSize(input) ? IsMd5Valid(input) : false;
            if (valid)
                Input = input;

            return valid;
        }

        private bool IsMd5Valid(string rom)
        {
            int md5Index = GetMd5Index(rom);
            UpdateAvailablePatchs(md5Index);

            return md5Index != -1;
        }

        private int GetMd5Index(string rom)
        {
            int md5Index;
            using (FileStream fs = 
                new FileStream(rom, FileMode.Open, FileAccess.Read, FileShare.Read)) {

                MD5 md5 = MD5.Create();
                string currentHash = BitConverter.ToString(md5.ComputeHash(fs));
                currentHash = currentHash.Replace("-", "").ToLower();

                md5Index = Array.IndexOf<string>(Md5s, currentHash);
                md5.Clear();
            }

            return md5Index;
        }

        private void UpdateAvailablePatchs(int md5Index)
        {
            // If it's invalid do nothing
            if (md5Index == -1)
                return;

            // If it's clean everything is available
            if (md5Index == 0)
                return;

            // Other rom types has the translation patch already, so disable it
            Translation = false;

            // If it has already the AP patch (maybe the user wants the banner too)
            if (md5Index == 2)
                AntiPiracy = false;

            // If it has already the banner patch (maybe the user wants the AP too)
            if (md5Index == 3)
                Banner = false;

            // If it has everything already (maybe the user is stupid)
            if (md5Index == 4) {
                AntiPiracy = false;
                Banner = false;
            }
        }

        private bool CheckRomSize(string cleanRom)
        {
            return new FileInfo(cleanRom).Length == ExpectedLength;
        }

        public bool SetOutput(string output)
        {
            Output = output;
            return true;
        }

        public void Patch()
        {
            if (string.IsNullOrEmpty(Input) || string.IsNullOrEmpty(Output))
                throw new ArgumentException();

            using (var fsIn  = new FileStream(Input,  FileMode.Open, FileAccess.Read,      FileShare.Read)) {
            using (var fsOut = new FileStream(Output, FileMode.Open, FileAccess.ReadWrite, FileShare.Read)) {
                    Stream patch = Assembly.GetExecutingAssembly().GetManifestResourceStream(
                        PatchId);
                    Decoder decoder = new Decoder(fsIn, patch, fsOut);
                    decoder.Run();
            }
            }
        }
    }
}

