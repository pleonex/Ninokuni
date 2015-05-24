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
using System.ComponentModel;

namespace NinoPatcher
{
    public delegate void FinishedPatchingHandler(ErrorCode error);

    public class Patcher
    {
        private const string PatchId = "PatchES.xdelta";

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
                
                    if (RemoveAntiPiracy)
                        UnpatchAntipiracy();

                    if (Translation)
                        ApplyTranslation(worker, outStream);

                    if (AntiPiracy)
                        ApplyAntipiracy();

                    if (Banner)
                        ApplyBanner();
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

        private void ApplyTranslation(BackgroundWorker worker, FileStream outStream)
        {
            using (FileStream inStream = 
                new FileStream(Input, FileMode.Open, FileAccess.Read, FileShare.Read)) {
                using (Stream patch = ResourcesManager.GetStream(PatchId)) {
                    Decoder decoder = new Decoder(inStream, patch, outStream);
                    decoder.ProgressChanged += delegate (double p) {
                        worker.ReportProgress((int)(p * 100));
                    };

                    decoder.Run();
                }
            }
        }

        private void ApplyAntipiracy()
        {
            throw new NotImplementedException();
        }

        private void UnpatchAntipiracy()
        {
            throw new NotImplementedException();
        }

        private void ApplyBanner()
        {
            throw new NotImplementedException();
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

