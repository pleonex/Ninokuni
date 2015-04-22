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

namespace Downlitor
{
	public static class AlchemyManager
	{
		private static AlchemyManager instance;
		private const string ItemName = "AlchemyRecipeData.dat";

		private AlchemyRecipe[] recipes;

		private AlchemyManager()
		{
			recipes = new AlchemyRecipe[NumEntries];
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

		private void Read()
		{

		}
	}
}

