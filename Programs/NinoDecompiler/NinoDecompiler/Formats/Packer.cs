//-----------------------------------------------------------------------
// <copyright file="Packer.cs" company="none">
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
namespace NinoDecompiler.Formats
{
    using System;
    using System.IO;
    using NinoDecompiler.Formats;
    
    /// <summary>
    /// Description of Packer.
    /// </summary>
    public abstract class Packer
    {   
        protected GameFile file;        
        
        public Packer(GameFile file)
        {
            this.file = file;
        }
        
        public abstract bool IsValid();
        
        public static Packer GetInstance(GameFile file)
        {
            // Another way I thought it would be faster than using reflection
            // but testing I got 3 seconds of difference, so...
            file.BaseStream.Position = file.Position;           
            if (Zarc.IsValid(file.BaseStream))
            {
                return new Zarc(file);
            }
            
            file.BaseStream.Position = file.Position;
            if (Psar.IsValid(file.BaseStream))
            {
                return new Psar(file);
            }
            
            return null;
        }
        
        public abstract GameFile[] Unpack();
    }
}
