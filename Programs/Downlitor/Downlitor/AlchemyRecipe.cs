//
//  AlchemyRecipe.cs
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
using System.Text;

namespace Downlitor
{
	public struct AlchemyRecipe
	{
		public AlchemyRecipe(string name, Ingredient ingredient1, Ingredient ingredient2,
			Ingredient ingredient3) : this()
		{
			Name = name;
			Ingredient1 = ingredient1;
			Ingredient2 = ingredient2;
			Ingredient3 = ingredient3;
		}

		public string Name {
			get;
			private set;
		}

		public Ingredient Ingredient1 {
			get;
			private set;
		}

		public Ingredient Ingredient2 {
			get;
			private set;
		}

		public Ingredient Ingredient3 {
			get;
			private set;
		}

		public override string ToString()
		{
			var output = new StringBuilder();
			output.AppendFormat("Recipe {0} = {1}", Name, Ingredient1);

            if (Ingredient2.Quantity > 0 && Ingredient2.Quantity != 0xFFFF)
				output.AppendFormat(" + {0}", Ingredient2);

            if (Ingredient3.Quantity > 0 && Ingredient3.Quantity != 0xFFFF)
				output.AppendFormat(" + {0}", Ingredient3);

			return output.ToString();
		}
		
	}
}

