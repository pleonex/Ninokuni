//
//  DlcManager.cs
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
using System.IO;

namespace Downlitor
{
    public class DlcManager
    {
        const string DlcName = "DownloadParam.dat";
        private static DlcManager instance;
        private DlcItem[] items;

        private DlcManager()
        {
            Read();
        }

        public static DlcManager Instance {
            get {
                if (instance == null)
                    instance = new DlcManager();

                return instance;
            }
        }

        public int NumEntries {
            get;
            private set;
        }

        public DlcItem GetItem(int index)
        {
            if (index < 0 || index >= NumEntries)
                return null;

            return items[index];
        }

        public DlcItem[] GetItems()
        {
            return items;
        }

        public void SetItem(int index, DlcItem dlc)
        {
            if (index < 0 || index >= NumEntries)
                return;

            items[index] = dlc;
        }

        public DlcItem this[int index] {
            get { return GetItem(index); }
            set { SetItem(index, value); }
        }

        private void Read()
        {
            using (var stream = new DataStream(DlcName, FileMode.Open, FileAccess.Read)) {
                var reader = new DataReader(stream, EndiannessMode.LittleEndian,
                             System.Text.Encoding.GetEncoding("shift_jis"));

                NumEntries = reader.ReadUInt16();
                items = new DlcItem[NumEntries];
                for (int i = 0; i < NumEntries; i++) {
                    items[i] = new DlcItem {
                        Tab   = (DlcType)reader.ReadUInt16(),
                        Index = reader.ReadUInt16(),
                        Name  = reader.ReadString(0x30, "replace", false)
                    };
                }
            }
        }

        public void Write()
        {
            using (var stream = new DataStream(DlcName, FileMode.Create, FileAccess.Write)) {
                var writer = new DataWriter(stream, EndiannessMode.LittleEndian,
                    System.Text.Encoding.GetEncoding("shift_jis"));

                writer.Write((ushort)NumEntries);
                foreach (var item in items) {
                    writer.Write((ushort)item.Tab);
                    writer.Write(item.Index);
                    writer.Write(item.Name, 0x30, "replace", true);
                }
            }
        }
    }
}