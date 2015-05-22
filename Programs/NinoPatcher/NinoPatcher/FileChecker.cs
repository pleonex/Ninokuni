//
//  FileChecker.cs
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
    public static class FileChecker
    {
        private const long ExpectedLength = 512 * 1024 * 1024;
        private static readonly string[] Md5s = {
            "f0e3027b9e97618732b4f2d4298ad0cf", // ROM
            "", // ROM + Spanish Patch
            "", // ROM + Spanish Patch + AP
            "", // ROM + Spanish Patch + Banner
            ""  // ROM + Spanish Patch + AP + Banner
        };

        public static ErrorCode CheckInput(string file, out RomType type)
        {
            type = RomType.Invalid; // In case of previous invalid validations

            ErrorCode code = CheckPath(file);
            code = code.IsValid() ? CheckFileExists(file) : code;
            code = code.IsValid() ? CheckRomSize(file) : code;
            code = code.IsValid() ? IsMd5Valid(file, out type) : code;
            return code;
        }

        public static ErrorCode CheckOutput(string file)
        {
            ErrorCode code = CheckPath(file);
            code = code.IsValid() ? CheckCanWrite(file) : code;
            return code;
        }

        private static ErrorCode CheckPath(string file)
        {
            ErrorCode error = ErrorCode.InvalidPath;
            if (string.IsNullOrEmpty(file))
                return error;

            // If there is an exception the path has invalid chars or no priviledges
            // https://msdn.microsoft.com/es-es/library/system.io.fileinfo.fileinfo%28v=vs.110%29.aspx
            FileInfo info;
            try   { info = new FileInfo(file); }
            catch { return error; }

            if (info.Exists && info.Attributes != FileAttributes.Normal)
                return error;

            return ErrorCode.Valid;
        }

        private static ErrorCode CheckFileExists(string file)
        {
            return File.Exists(file) ? ErrorCode.Valid : ErrorCode.DoesNotExist;
        }

        private static ErrorCode CheckCanWrite(string file)
        {
            if (!File.Exists(file))
                return ErrorCode.Valid;

            return new FileInfo(file).IsReadOnly ? ErrorCode.IsReadOnly : ErrorCode.Valid;
        }

        private static ErrorCode CheckRomSize(string rom)
        {
            return (new FileInfo(rom).Length == ExpectedLength) ? ErrorCode.Valid : ErrorCode.InvalidSize;
        }

        private static ErrorCode IsMd5Valid(string rom, out RomType type)
        {
            type = GetMd5Index(rom);
            if (type == RomType.Invalid)
                return ErrorCode.InvalidChecksum;
            else if (type == RomType.TranslationApBanner)
                return ErrorCode.DoNothing;
            else
                return ErrorCode.Valid;
        }

        private static RomType GetMd5Index(string rom)
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

            return (RomType)md5Index;
        }
    }
}

