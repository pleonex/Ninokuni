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
using System.Diagnostics;

namespace NinoPatcher
{
    public static class FileChecker
    {
        private static readonly string[] Md5s = {
            "f0e3027b9e97618732b4f2d4298ad0cf", // ROM
            "", // ROM + Spanish Patch
            "", // ROM + Spanish Patch + AP
            "", // ROM + Spanish Patch + Banner
            "", // ROM + Spanish Patch + AP + Banner
            ""  // ROM + AP
        };

        public static long RomLength {
            get { return 512 * 1024 * 1024; }
        }

        public static long TorrentLength {
            get { return 1 * 1024 * 1024; }
        }

        public static ErrorCode CheckInput(string file, out RomType type)
        {
            type = RomType.Invalid; // In case of previous invalid validations

            ErrorCode code = CheckPath(file);
            code = code.IsValid() ? CheckFileExists(file) : code;
            code = code.IsValid() ? CheckRomSize(file, RomLength) : code;
            code = code.IsValid() ? IsMd5Valid(file, out type) : code;
            return code;
        }

        public static ErrorCode CheckOutput(string file, long maxLength)
        {
            ErrorCode code = CheckPath(file);
            code = code.IsValid() ? CheckEnoughDiskSpace(file, maxLength) : code;
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
            catch (Exception ex) { Console.WriteLine(ex); return error; }

            if (info.Exists && (info.Attributes & FileAttributes.Normal) != FileAttributes.Normal) {
                if (info.IsReadOnly)
                    return ErrorCode.IsReadOnly;
                else
                    return error;
            }

            return ErrorCode.Valid;
        }

        private static ErrorCode CheckFileExists(string file)
        {
            return File.Exists(file) ? ErrorCode.Valid : ErrorCode.DoesNotExist;
        }

        private static ErrorCode CheckEnoughDiskSpace(string file, long maxLength)
        {

            long availableSpace = 0;

            switch (Environment.OSVersion.Platform) {
            case PlatformID.MacOSX:
            case PlatformID.Unix:
                availableSpace = GetUnixDiskFreeSpace(file);
                break;

            default:
                availableSpace = GetWindowsDiskFreeSpace(file);
                break;
            }

            return availableSpace > maxLength ? ErrorCode.Valid : ErrorCode.NotEnoughDiskSpace;
        }

        private static long GetUnixDiskFreeSpace(string file)
        {
            // Since it is not very safe, on exception return maximum and guess the user
            // has enough space
            long freeSpace = Int64.MaxValue;
            try {
                string path = Path.GetDirectoryName(file);

                ProcessStartInfo processInfo = new ProcessStartInfo();
                processInfo.FileName = "df";
                processInfo.Arguments = "-P -k \"" + path + "\""; // -P for portability in POSIX
                processInfo.CreateNoWindow = true;
                processInfo.ErrorDialog = false;
                processInfo.UseShellExecute = false;
                processInfo.RedirectStandardOutput = true;

                Process dfProcess = Process.Start(processInfo);
                string output = dfProcess.StandardOutput.ReadToEnd();
                dfProcess.WaitForExit();

                string freeSpaceStr = output.Split(new char[] {'\n'}, StringSplitOptions.RemoveEmptyEntries)[1];
                freeSpaceStr = freeSpaceStr.Split(new char[] {' '}, StringSplitOptions.RemoveEmptyEntries)[3];
                freeSpace = Convert.ToInt64(freeSpaceStr) * 1024;
            } catch (Exception ex) { Console.WriteLine(ex); }

            return freeSpace;
        }

        private static long GetWindowsDiskFreeSpace(string file)
        {
            // Since it is not very safe (does not work with UNC),
            // on exception return maximum and guess the user has enough space
            long freeSpace = Int64.MaxValue;
            try {
                FileInfo winFileInfo   = new FileInfo(file);
                DriveInfo winDriveInfo = new DriveInfo(winFileInfo.Directory.Root.FullName);
                freeSpace = winDriveInfo.AvailableFreeSpace;
            } catch (Exception ex) { Console.WriteLine(ex); }

            return freeSpace;
        }

        private static ErrorCode CheckRomSize(string rom, long length)
        {
            return (new FileInfo(rom).Length == length) ? ErrorCode.Valid : ErrorCode.InvalidSize;
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

