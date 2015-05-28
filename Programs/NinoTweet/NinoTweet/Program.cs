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
using System.IO;
using System.Xml.Linq;
using Libgame;

namespace NinoTweet
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            if (args.Length != 3)
                return;

            string xmlEdit = "Ninokuni español.xml";
            var document = XDocument.Load(xmlEdit);
            Configuration.Initialize(document);

            string inputPath  = args[1];
            string outputPath = args[2];
            Tweet tweet = new Tweet();

            if (args[0] == "-e") {
                tweet.Read(inputPath);
                tweet.Export(outputPath);
            } else if (args[0] == "-i") {
                tweet.Import(inputPath);
                tweet.Write(outputPath);
            }
        }
    }
}
