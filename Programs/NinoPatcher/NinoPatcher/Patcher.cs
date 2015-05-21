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

        public ErrorCode SetInput(string input)
        {
            ErrorCode code = CheckPath(input);
            code = code.Valid() ? CheckFileExists(input) : code;
            code = code.Valid() ? CheckRomSize(input)    : code;
            code = code.Valid() ? IsMd5Valid(input)      : code;

            if (code.Valid())
                Input = input;

            return code;
        }

        public ErrorCode SetOutput(string output)
        {
            ErrorCode code = CheckPath(output);
            code = code.Valid() ? CheckCanWrite(output) : code;

            if (code.Valid())
                Output = output;

            return code;
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

        private ErrorCode CheckPath(string file)
        {
            ErrorCode error = ErrorCode.InvalidPath;
            if (!string.IsNullOrEmpty(file))
                return error;
             
            // If there is an exception the path has invalid chars or no priviledges
            // https://msdn.microsoft.com/es-es/library/system.io.fileinfo.fileinfo%28v=vs.110%29.aspx
            FileInfo info;
            try   { info = new FileInfo(file); }
            catch { return error; }

            if (info.Attributes != FileAttributes.Normal)
                return error;

            return ErrorCode.Valid;
        }

        private ErrorCode CheckFileExists(string file)
        {
            return File.Exists(file) ? ErrorCode.Valid : ErrorCode.DoesNotExist;
        }

        private ErrorCode CheckCanWrite(string file)
        {
            return new FileInfo(file).IsReadOnly ? ErrorCode.IsReadOnly : ErrorCode.Valid;
        }

        private ErrorCode CheckRomSize(string rom)
        {
            return (new FileInfo(rom).Length == ExpectedLength) ? ErrorCode.Valid : ErrorCode.InvalidSize;
        }

        private ErrorCode IsMd5Valid(string rom)
        {
            int md5Index = GetMd5Index(rom);
            UpdateAvailablePatchs(md5Index);

            return md5Index == -1 ? ErrorCode.InvalidChecksum : ErrorCode.Valid;
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
    }
}

