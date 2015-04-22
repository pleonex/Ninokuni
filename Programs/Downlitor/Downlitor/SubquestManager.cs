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

namespace Downlitor
{
	public class SubquestManager
	{
		const string FormatName = "Subquest{0:D4}";
		static SubquestManager instance;

		private SubquestManager()
		{
		}

		public static SubquestManager Instance {
			get {
				if (instance == null)
					instance = new SubquestManager();

				return instance;
			}
		}

		public string GetTitle(int index)
		{
			if (index < 0)
				return null;

			// TODO: Get file

			var reader = new DataReader(null);
			reader.Stream.Seek(4, SeekMode.Origin);

			ushort nameLen = reader.ReadUInt16();
			string name = reader.ReadString(nameLen, "replace", false);

			reader.Stream.Dispose();
			return name;
		}
	}
}

