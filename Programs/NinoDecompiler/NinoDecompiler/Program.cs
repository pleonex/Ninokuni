// ----------------------------------------------------------------------
// <copyright file="Program.cs" company="none">
// Copyright (C) 2012
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
//   along with this program.  If not, see <http://www.gnu.org/licenses/>. 
//
// </copyright>
// <author>pleoNeX</author>
// <email>benito356@gmail.com</email>
// <date>06/10/2012 21:21:28</date>
// -----------------------------------------------------------------------
namespace NinoDecompiler
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Reflection;
    using NinoDecompiler.Formats;
    
    public static class Program
    {       
        public static void Main(string[] args)
        {
            Console.WriteLine("Ni no kuni PS3 - Decompiler");
            Console.WriteLine("V 3.0 ~ by pleoNeX");
            Console.WriteLine();
            
            if (args.Length < 1)
            {
                Console.WriteLine("No input file(s)!");
                return;
            }
            
            for (int i = 0; i < args.Length; i++)
            {
                string fileIn = args[i];
                string folderOut = Path.Combine(
                    Path.GetDirectoryName(fileIn),
                    Path.GetFileNameWithoutExtension(fileIn));
    
                Console.WriteLine("Decompiling: {0}", Path.GetFileName(fileIn));
                DateTime start = DateTime.Now;
                Decompiler(fileIn, folderOut);
                DateTime end = DateTime.Now;
                
                Console.WriteLine("Time: {0}", (end - start).ToString());
            }

            Console.WriteLine();
            Console.WriteLine("Done!");
            Console.ReadKey(true);
        }
        
        private static void Decompiler(string fileIn, string folderOut)
        {
            Stack<GameFile> fileStack = new Stack<GameFile>();
            fileStack.Push(new GameFile(fileIn) { FilePath = folderOut });
            
            IEnumerable<Type> packerList = GetPackTypes();
            Dictionary<Type, int> stats = new Dictionary<Type, int>();
            stats.Add(typeof(GameFile),  0);
            stats.Add(typeof(ErrorFile), 0);
            stats.Add(typeof(FinalFile), 0);
            foreach (Type t in packerList)
            {
                stats.Add(t, 0);
            }
            
            // Console info
            int xOld = Console.CursorLeft;
            int yOld = Console.CursorTop;
            Console.WriteLine("000000 processed files.");
            Console.CursorVisible = false;    
            
            while (fileStack.Count > 0)
            {                
                GameFile currentFile = fileStack.Pop();
                if (currentFile.Size == 0)
                {
                    continue;
                }
                
                // Match the format
                Packer packer = null;
                foreach (Type packerType in packerList)
                {
                    packer = (Packer)Activator.CreateInstance(packerType, currentFile);
                    if (!packer.IsValid())
                    {
                        packer = null;
                    }
                    else
                    {
                        stats[packerType]++;
                        break;
                    }
                }
                
                if (packer == null)
                {
                    // Export file
                    #if !DEBUG
                    currentFile.Export();
                    #endif
                    currentFile.Dispose();
                    stats[typeof(FinalFile)]++;
                }
                else
                {
                    // Decompress file
                    GameFile[] unpacked = packer.Unpack();
                    stats[typeof(ErrorFile)] += (unpacked.Length == 0 ? 1 : 0);
                    for (int i = unpacked.Length - 1; i >= 0; i--)
                    {
                        fileStack.Push(unpacked[i]);
                    }
                    
                    if (currentFile.NumChilds == 0)
                    {
                        currentFile.Dispose();
                    }
                }
                
                // Update the info of the console
                int xNew = Console.CursorLeft;
                int yNew = Console.CursorTop;
                Console.SetCursorPosition(xOld, yOld);
                Console.Write((++stats[typeof(GameFile)]).ToString().PadLeft(6, '0'));
                Console.SetCursorPosition(xNew, yNew);
            }
            
            // Show stats
            Console.WriteLine("# Statistics #");
            foreach (Type key in stats.Keys)
            {
                Console.WriteLine("|_[{0}]\t-> {1}", key, stats[key]);
            }
        }
        
        private static IEnumerable<Type> GetPackTypes()
        {
            return typeof(Packer).Assembly.GetTypes().Where(t => t.IsSubclassOf(typeof(Packer)) && !t.IsAbstract);
        }
    }
}
