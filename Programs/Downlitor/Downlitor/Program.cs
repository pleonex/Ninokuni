//
//  Program.cs
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
using System.Xml.Linq;
using Libgame;

namespace Downlitor
{
	public static class Program
	{
		[STAThread]
		public static void Main(string[] args)
		{
			string xmlEdit = "Ninokuni español.xml";
			var document = XDocument.Load(xmlEdit);
			Configuration.Initialize(document);

            if (args.Length > 0) {
                CommandLine(args);
                return;
            }

            MainWindow window = new MainWindow();
            window.ShowDialog();
            window.Dispose();
		}

        private static void CommandLine(string[] args)
        {
            DlcBinaryFlags dlc;
            if ((args.Length == 2 || args.Length == 3) && args[0] == "-e") {
                dlc = new DlcBinaryFlags();
                if (args.Length == 3)
                    dlc = DlcBinaryFlags.FromDlc(args[1]);

                dlc.Export(args[2]);
            } else if (args.Length == 3 && args[0] == "-i") {
                dlc = DlcBinaryFlags.FromXml(args[1]);
                dlc.Write(args[2]);
            }
        }
	}
}

