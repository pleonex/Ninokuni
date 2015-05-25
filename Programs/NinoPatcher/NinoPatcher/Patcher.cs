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
using System.ComponentModel;
using System.IO;
using System.Reflection;
using System.Security.Cryptography;
using Xdelta;
using System.Collections.Generic;

namespace NinoPatcher
{
    public delegate void FinishedPatchingHandler(ErrorCode error);

    public class Patcher
    {
        private const string GameTitle = "Ninokuni\nEl Mago de las Tinieblas\nLEVEL5";
        private const string PatchId = "PatchES.xdelta";
        private static readonly Dictionary<uint, byte[]> ApPatch = new Dictionary<uint, byte[]> {
            { 0x00004200, new byte[] {
                    0x00, 0x00, 0x9F, 0xE5, 0x1E, 0xFF, 0x2F, 0xE1,
                    0xCF, 0xB3, 0x00, 0x00, 0x00, 0x00, 0x9F, 0xE5 } },
            { 0x00004210, new byte[] {
                    0x1E, 0xFF, 0x2F, 0xE1, 0x77, 0xB1, 0x00, 0x00,
                    0x07, 0x40, 0x2D, 0xE9, 0x1C, 0x00, 0x9F, 0xE5 } },
            { 0x00004220, new byte[] {
                    0x1C, 0x10, 0x9F, 0xE5, 0x00, 0x20, 0x91, 0xE5,
                    0x02, 0x00, 0x50, 0xE1, 0x14, 0x00, 0x9F, 0x05 } },
            { 0x00004230, new byte[] {
                    0x00, 0x00, 0x81, 0x05, 0x0C, 0x00, 0x80, 0x02,
                    0x3C, 0x00, 0x81, 0x05, 0x07, 0x80, 0xBD, 0xE8 } },
            { 0x00004240, new byte[] {
                    0xE0, 0xD7, 0x15, 0x02, 0x4C, 0xC0, 0x15, 0x02,
                    0x00, 0x23, 0x00, 0x02 } },
            { 0x000049F8, new byte[] {
                    0x06, 0xFE, 0xFF, 0xEA } }
        };
        private static readonly Dictionary<uint, byte[]> UnApPatch = new Dictionary<uint, byte[]> {
            { 0x00004200, new byte[] {
                    0xE2, 0x26, 0x89, 0x33, 0x28, 0x01, 0x4D, 0x39,
                    0xBD, 0xDA, 0xEC, 0xC9, 0x7C, 0xCD, 0xAB, 0x7F } },
            { 0x00004210, new byte[] {
                    0xDC, 0x75, 0xB3, 0xD1, 0xE8, 0x0B, 0x68, 0x3F,
                    0x9A, 0xF4, 0x3C, 0x02, 0x0D, 0xD2, 0xAB, 0xDE } },
            { 0x00004220, new byte[] {
                    0x41, 0xDD, 0x29, 0x28, 0xFE, 0xC0, 0xB7, 0x19,
                    0xDC, 0xB6, 0xC6, 0x32, 0x7C, 0x20, 0xCB, 0x0F } },
            { 0x00004230, new byte[] {
                    0x7C, 0x6C, 0xFF, 0x7D, 0xEB, 0x06, 0xF6, 0x56,
                    0x79, 0x79, 0xD6, 0x27, 0x44, 0xEB, 0xCE, 0x5D } },
            { 0x00004240, new byte[] {
                    0xCF, 0x1E, 0x36, 0x1B, 0xC6, 0xEF, 0x89, 0x63,
                    0xBF, 0xFF, 0x8E, 0x8A } },
            { 0x000049F8, new byte[] {
                    0x1E, 0xFF, 0x2F, 0xE1 } }
        };

        public Patcher(bool antipiracy, bool banner)
        {
            AntiPiracy = antipiracy;
            Banner = banner;
            Translation = true; // By default true, later will disable if needed
            RemoveAntiPiracy = false;   // Later could be enable if needed
        }

        public bool Translation {
            get;
            private set;
        }

        public bool RemoveAntiPiracy {
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

        public event ProgressChangedHandler ProgressChanged;
        public event FinishedPatchingHandler Finished;

        public ErrorCode SetInput(string input)
        {
            RomType type;
            ErrorCode code = FileChecker.CheckInput(input, out type);
            UpdateAvailablePatchs(type);

            if (code.IsValid())
                Input = input;

            return code;
        }

        public ErrorCode SetOutput(string output, long maxLength)
        {
            ErrorCode code = FileChecker.CheckOutput(output, maxLength);
            if (code.IsValid())
                Output = output;

            return code;
        }

        public void Patch()
        {
            if (string.IsNullOrEmpty(Input) || string.IsNullOrEmpty(Output))
                throw new ArgumentException();

            BackgroundWorker worker = new BackgroundWorker();
            worker.ProgressChanged += HandleProgressChanged;;
            worker.RunWorkerCompleted += HandleRunWorkerCompleted;
            worker.WorkerReportsProgress = true;
            worker.WorkerSupportsCancellation = false;
            worker.DoWork += delegate {
                using (var outStream =
                    new FileStream(Output, FileMode.Create, FileAccess.ReadWrite, FileShare.Read)) {
                
                    if (RemoveAntiPiracy) {
                        // In this case it needs write permissions to edit origin...
                        using (FileStream inStream = 
                               new FileStream(Input, FileMode.Open, FileAccess.ReadWrite, FileShare.Read))
                            UnpatchAntipiracy(inStream);
                    }

                    if (Translation)
                        ApplyTranslation(worker, outStream);

                    if (AntiPiracy)
                        ApplyAntipiracy(outStream);

                    if (Banner)
                        ApplyBanner(outStream);
                }
            };

            worker.RunWorkerAsync();
        }

        private void HandleProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            if (ProgressChanged != null)
                ProgressChanged(e.ProgressPercentage);
        }

        private void HandleRunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            Console.WriteLine(e.Error);
            if (Finished != null)
                Finished(e.Error == null ? ErrorCode.Valid : ErrorCode.UnknownError);
        }

        private void ApplyTranslation(BackgroundWorker worker, Stream outStream)
        {
            using (FileStream inStream = 
                new FileStream(Input, FileMode.Open, FileAccess.Read, FileShare.Read)) {
                using (Stream patch = ResourcesManager.GetStream(PatchId)) {
                    outStream.Position = 0;

                    Decoder decoder = new Decoder(inStream, patch, outStream);
                    decoder.ProgressChanged += delegate (double p) {
                        worker.ReportProgress((int)(p * 100));
                    };

                    decoder.Run();
                }
            }
        }

        private void ApplyAntipiracy(Stream outStream)
        {
            ApplyCodePatch(outStream, ApPatch);
        }

        private void UnpatchAntipiracy(Stream outStream)
        {
            ApplyCodePatch(outStream, UnApPatch);
        }

        private void ApplyCodePatch(Stream outStream, Dictionary<uint, byte[]> patch)
        {
            foreach (KeyValuePair<uint, byte[]> codePatch in patch) {
                outStream.Position = codePatch.Key;
                outStream.Write(codePatch.Value, 0, codePatch.Value.Length);
            }
        }

        private void ApplyBanner(Stream outStream)
        {
            BinaryReader reader = new BinaryReader(outStream);
            BinaryWriter writer = new BinaryWriter(outStream);

            // Get banner offset
            outStream.Position = 0x68;
            uint offset = reader.ReadUInt32();

            // Go to title strings
            outStream.Position = offset + 0x20 + 0x200 + 0x20;

            // Write six times the title (for all languages)
            byte[] data = new byte[0x100];
            System.Text.Encoding.Unicode.GetBytes(GameTitle, 0, GameTitle.Length, data, 0);
            writer.Write(data); // Japanese
            writer.Write(data); // English
            writer.Write(data); // French
            writer.Write(data); // German
            writer.Write(data); // Italian
            writer.Write(data); // Spanish

            // Compute again the CRC
            outStream.Position = offset + 0x20;
            ushort crc16 = Crc16.Calculate(outStream, 0x200 + 0x20 + 0x0600);

            // Write the CRC
            outStream.Position = offset + 0x02;
            writer.Write(crc16);
        }

        private void UpdateAvailablePatchs(RomType romType)
        {
            // If it's invalid do nothing
            if (romType == RomType.Invalid)
                return;

            // If it's clean everything is available
            if (romType == RomType.Clean)
                return;

            if (romType == RomType.CleanAp) {
                RemoveAntiPiracy = true;
                return;
            }

            // Other rom types has the translation patch already, so disable it
            Translation = false;

            // If it has already the AP patch (maybe the user wants the banner too)
            if (romType == RomType.TranslationAp)
                AntiPiracy = false;

            // If it has already the banner patch (maybe the user wants the AP too)
            if (romType == RomType.TranslationBanner)
                Banner = false;

            // If it has everything already (maybe the user is stupid)
            if (romType == RomType.TranslationApBanner) {
                AntiPiracy = false;
                Banner = false;
            }
        }
    }
}

