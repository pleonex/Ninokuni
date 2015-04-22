//
//  ItemManager.cs
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
using System.IO;
using Libgame.IO;

namespace Downlitor
{
	public class ItemManager
	{
		const string ItemName = "ItemParam.dat";
		const string SpItemName = "SpItemParam.dat";
		const int NumActualItems = 0x1E8;
		const int NumItems   = 0x260;
		const int NumSpItems = 0x90;

		private static ItemManager instance;
		private string[] items;

		private ItemManager()
		{
			items = new string[NumEntries];
			ReadItems();
			ReadSpecialItems();
		}

		public static ItemManager Instance {
			get {
				if (instance == null)
					instance = new ItemManager();

				return instance;
			}
		}

		public static int NumEntries {
			get { return NumItems + NumSpItems; }
		}

		public string GetItem(int index)
		{
			if (index < 0 || index >= NumEntries)
				return null;

			if (index >= NumActualItems && index < NumItems)
				return null;

			return items[index];
		}

		public string this[int index] {
			get { return GetItem(index); }
		}

		private Stream Decode(string file)
		{
			var output = new MemoryStream();
			using (var stream = new FileStream(file, FileMode.Open)) {
				output.Capacity = (int)stream.Length;
				while (stream.Position < stream.Length)
					output.WriteByte((byte)~stream.ReadByte());
			}

			return output;
		}

		private void ReadItems()
		{
			var stream = new DataStream(Decode(ItemName), 0, -1);
			var reader = new DataReader(stream, EndiannessMode.LittleEndian,
				System.Text.Encoding.GetEncoding("shift_jis"));

			int numEntries = reader.ReadUInt16();
			for (int i = 0; i < numEntries; i++) {
				items[i] = reader.ReadString(0x20, "replace", false);
				stream.Seek(0x4C, SeekMode.Current);
			}

			stream.Dispose();
		}

		private void ReadSpecialItems()
		{
			var stream = new DataStream(Decode(SpItemName), 0, -1);
			var reader = new DataReader(stream, EndiannessMode.LittleEndian,
				System.Text.Encoding.GetEncoding("shift_jis"));

			int numEntries = reader.ReadUInt16();
			for (int i = 0; i < numEntries; i++) {
				items[NumItems + i] = reader.ReadString(0x20, "replace", false);
				stream.Seek(0x10, SeekMode.Current);
			}

			stream.Dispose();
		}
	}
}

