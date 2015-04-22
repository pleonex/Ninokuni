//
//  AlchemyManager.cs
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
	public class AlchemyManager
	{
		private static AlchemyManager instance;
		private const string Filename = "AlchemyRecipeData.dat";

		private AlchemyRecipe[] recipes;

		private AlchemyManager()
		{
			Read();
		}

		public static AlchemyManager Instance {
			get {
				if (instance == null)
					instance = new AlchemyManager();

				return instance;
			}
		}

		public int NumEntries {
			get;
			private set;
		}

		public AlchemyRecipe GetRecipe(int index)
		{
			if (index < 0 || index >= NumEntries)
				throw new ArgumentException("Invalid index");

			return recipes[index];
		}

		public AlchemyRecipe this[int index] {
			get { return GetRecipe(index); }
		}

		private void Read()
		{
			var stream = new DataStream(Filename, FileMode.Open, FileAccess.Read);
			var reader = new DataReader(stream, EndiannessMode.LittleEndian,
				             System.Text.Encoding.GetEncoding("shift_jis"));

			NumEntries = reader.ReadUInt16();
			recipes = new AlchemyRecipe[NumEntries];

			var items = ItemManager.Instance;
			for (int i = 0; i < NumEntries; i++) {
				var name = items[reader.ReadInt32()];

				var item1 = reader.ReadUInt16();
				var item2 = reader.ReadUInt16();
				var item3 = reader.ReadUInt16();

				var recipe1 = new Ingredient(item1, reader.ReadUInt16());
				var recipe2 = new Ingredient(item2, reader.ReadUInt16());
				var recipe3 = new Ingredient(item3, reader.ReadUInt16());

				recipes[i] = new AlchemyRecipe(name, recipe1, recipe2, recipe3);
			}
		}
	}
}

