//
//  SubquestManager.cs
//
//  Author:
//       Benito Palacios <benito356@gmail.com>
//
//  Copyright (c) 2015 Benito Palacios
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
using Libgame;
using Libgame.IO;
using System.IO;
using System.Collections.Generic;

namespace Downlitor
{
	public class SubquestManager
	{
		const string FormatName = "SubQuest{0:D4}.sq";
        const string Folder = "subquests";
		static SubquestManager instance;

        private string[] entries;

		private SubquestManager()
		{
            Read();
		}

        public int NumEntries {
            get { return entries.Length; }
        }

        public int LastSubQuest {
            get { return 2030; }
        }

		public static SubquestManager Instance {
			get {
				if (instance == null)
					instance = new SubquestManager();

				return instance;
			}
		}

        public string GetEntry(int index) {
            if (index < 0 || index >= NumEntries)
                return null;

            return this.entries[index];
        }

        public int GetNumber(int index)
        {
            if (index < 0 || index >= NumEntries)
                return -1;

            string num = this.entries[index];
            return Convert.ToUInt16(num.Substring(0, 4));
        }

        public int GetIndex(int number)
        {
            for (int i = 0; i < NumEntries; i++)
                if (GetNumber(i) == number)
                    return i;

            return -1;
        }

        private void Read()
        {
            List<string> entries = new List<string>();
            for (int i = 0; i < LastSubQuest; i++) {
                string title = GetTitle(i);
                if (!string.IsNullOrEmpty(title))
                    entries.Add(i.ToString("D4") + " - " + title);
            }

            this.entries = entries.ToArray();
        }

        public string GetTitle(int index)
		{
			if (index < 0)
				return null;

            var filename = Path.Combine(Folder, string.Format(FormatName, index));
            if (!File.Exists(filename))
                return null;

            var stream = new DataStream(filename, FileMode.Open, FileAccess.Read);
            var reader = new DataReader(stream, 
                EndiannessMode.LittleEndian, System.Text.Encoding.GetEncoding("shift_jis"));
			stream.Seek(4, SeekMode.Origin);

			ushort nameLen = reader.ReadUInt16();
			string name = reader.ReadString(nameLen, "replace", false);

			stream.Dispose();
			return name;
		}
	}
}

