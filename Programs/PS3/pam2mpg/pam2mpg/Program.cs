//-----------------------------------------------------------------------
// <copyright file="GameFile.cs" company="none">
// Copyright (C) 2013
//
//   This program is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by 
//   the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.
//
//   This program is distributed in the hope that it will be useful, 
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details. 
//
//   You should have received a copy of the GNU General Public License
//   along with this program.  If not, see "http://www.gnu.org/licenses/". 
// </copyright>
// <author>pleoNeX</author>
// <email>benito356@gmail.com</email>
// <date>09/04/2013</date>
//-----------------------------------------------------------------------
using System;
using System.IO;

namespace pam2mpg
{
	public static class MainClass
	{
		private const int CutOffset = 0x800;

		public static void Main(string[] args)
		{
			foreach (string videoFile in Directory.GetFiles(".", "*.pam")) {
				string videoOutput = videoFile + ".mpg";

				Console.WriteLine("Converting {0} to {1}", Path.GetFileName(videoFile), Path.GetFileName(videoOutput));
				CutFile(videoFile, CutOffset, videoOutput);
			}
		}

		public static void CutFile(string pathOri, long offset, string pathNew)
		{
			FileStream oriFile = new FileStream(pathOri, FileMode.Open, FileAccess.Read);
			FileStream newFile = new FileStream(pathNew, FileMode.Create, FileAccess.Write);

			CutFile(oriFile, offset, newFile);

			newFile.Close();
			oriFile.Close();
		}

		public static void CutFile(Stream strOri, long offset, Stream strNew)
		{
			strOri.Seek(offset, SeekOrigin.Begin);

			const int BufferSize = 5 * 1024;
			byte[] buffer = new byte[BufferSize];
			int count;
			do {
				count = strOri.Read(buffer, 0, BufferSize);
				strNew.Write(buffer, 0, count);
				strNew.Flush();
			} while (count != 0);
		}
	}
}
