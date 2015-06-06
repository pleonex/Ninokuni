//-----------------------------------------------------------------------
// <copyright file="Cfg.cs" company="none">
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
// <date>10/04/2013</date>
//-----------------------------------------------------------------------
namespace NinoDecompiler.Formats
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    
    /*
        ##########
        # PART 1 #
        ##########
        Header:
        00 - 4 - Config info length
        04 - 4 - String offset
        08 - 4 - String size
        0C - 4 - Number of strings
        
        Config info:
        00 - 4 - Unique ID
        04 - 1 - Data size
        05 - 3 - Data type, each type is 2 bit, read from right to left skipping 11 bits.
        --Data
        ---Strings:
           08 - 4 - Relative offset
        ---Integer:
           08 - 4 - Number
        ---TEXT_INFO:
           08 - 4 - Unique ID (related to TEXT_INDEX)
           0C - 4 - Unknown 00000000h
           10 - 4 - Relative offset
        ---TEXT_INDEX:
           08 - 4 - Unique ID (related to TEXT_INFO)
           0C - 4 - Unknown 00000000h
           10 - 4 - Index
        
        Types:
        00h: String
        01h: Intenger
        02h: Decimal
        03h: No data
        
        Strings
        
        ##########
        # PART 2 #
        ##########
        Header:
        00 - 4 - Signature offset
        04 - 4 - Number of item
        08 - 4 - Offset to item names.
        0C - 4 - Item names size
        
        Item fat:
        Entry size 0x8 bytes
        00 - 4 - Unique ID
        00 - 4 - Relative offset to the name.
        
        Items name strings.
        
        Signature:
        00 - 1 - Version? (1)
        01 - 3 - t2b
        04 - 6 - FE 01 0Z 01 01 00 
        Z = 0: non-contextual
        Z = 1: contextual
     */
    
    /// <summary>
    /// Description of Cfg.
    /// </summary>
    public class Cfg : Packer
    {
        private const uint   Signature1 = 0x01743262;
        private const ushort Signature2 = 0xFE01;
        private const uint   Signature3 = 0x010100;
        
        private const char Splitter = ':';
        
        public Cfg(GameFile file)
            : base(file)
        {
        }
                
        public override bool IsValid()
        {
			if (this.file.Size < 0x30)
			{
				return false;
			}

            this.file.BaseStream.Position = this.file.Position + this.file.Size - 0x10;
            BinaryReaderBE br = new BinaryReaderBE(this.file.BaseStream);
                        
            if (br.ReadUInt32() == Signature1 &&
                br.ReadUInt16() == Signature2 &&
                (br.ReadUInt32() & 0x00FFFFFF) == Signature3)
            {
                this.file.BaseStream.Position = this.file.Position + 4;
                uint part2Offset = br.ReadUInt32() + br.ReadUInt32();
                if (part2Offset % 0x10 != 0)
                {
                    part2Offset += 0x10 - (part2Offset % 0x10);
                }
                
                if (part2Offset > this.file.Size)
                {
                    return false;
                }
                
                this.file.BaseStream.Position = this.file.Position + part2Offset;
                if (part2Offset + br.ReadUInt32() + 0x10 == this.file.Size)
                {
                    return true;
                }
            }
            
            return false;
        }
        
        public override GameFile[] Unpack()
        {
            this.file.BaseStream.Position = this.file.Position;
            BinaryReaderBE reader = new BinaryReaderBE(this.file.BaseStream);
            
            /** PART 1 **/
            // Read header
            uint numEntries   = reader.ReadUInt32();
            uint strSecOffset = reader.ReadUInt32();
            uint strSecSize   = reader.ReadUInt32();
            uint numStr       = reader.ReadUInt32();
            
            /** PART 2 **/
            reader.BaseStream.Position = this.file.Position + strSecOffset + strSecSize;
            if ((reader.BaseStream.Position - this.file.Position) % 0x10 != 0)
            {
                reader.BaseStream.Position += 0x10 - ((reader.BaseStream.Position - this.file.Position) % 0x10);
            }
            
            long part2Offset = reader.BaseStream.Position;
            
            // Read header
            uint signSecOffset  = reader.ReadUInt32();
            uint numNames       = reader.ReadUInt32();
            uint namesSecOffset = reader.ReadUInt32();
            uint namesSecSize   = reader.ReadUInt32();
            
            // Read names
            Dictionary<uint, string> entriesName = new Dictionary<uint, string>();
            for (int i = 0; i < numNames; i++)
            {
                reader.BaseStream.Position = part2Offset + 0x10 + i * 8;
                uint id = reader.ReadUInt32();
                
                reader.BaseStream.Position = part2Offset + namesSecOffset + reader.ReadUInt32();
                entriesName.Add(id, reader.ReadString());
            }
            
            // Read signature
            // Specially, the contextuality
            reader.BaseStream.Position = part2Offset + signSecOffset + 6;
            byte context = reader.ReadByte();
            
            /** PART 1 **/
            // At last, read config entries
            reader.BaseStream.Position = this.file.Position + 0x10;
            ConfigEntry[] entries = new ConfigEntry[numEntries];
            for (int i = 0; i < numEntries; i++)
            {
                entries[i].Id   = reader.ReadUInt32();
                entries[i].Name = entriesName[entries[i].Id];
                
                byte numValues  = reader.ReadByte();
                reader.BaseStream.Position--;
                
                uint[] types    = reader.ReadUInt32s(1 + (numValues + 3) / 16);
                types[0]      <<= 8;   // Remove numValues data
                
                
                // Get the data
                entries[i].Data = new ConfigValue[numValues];
                long dataOffset = reader.BaseStream.Position;
                for (int j = 0; j < numValues; j++)
                {
                    reader.BaseStream.Position = dataOffset + j * 4;
                    entries[i].Data[j] = this.GetValue(j, types, strSecOffset);
                }
                
                // Offset to next entry.
                reader.BaseStream.Position = dataOffset + numValues * 4;
            }
            
            // Write everything to a text file.  
            //Stream txtStream = WriteText(entries, (context == 0));
            Stream txtStream = WriteInfo(entries);
            if (txtStream == null)
            {
                txtStream = WriteText(entries, (context == 0));
            }
            
            // Create the virtual file
            GameFile textFile = new GameFile(txtStream);
            textFile.Position = 0;
            textFile.Size = txtStream.Length;
            textFile.FileName = this.file.FileName + ".txt";
            textFile.FilePath = this.file.FilePath;
            textFile.Parent = null;
            
            reader = null;
            return new GameFile[] { textFile };
        }
        
        private static Stream WriteText(ConfigEntry[] entries, bool context)
        {
            StreamWriter writer = new StreamWriter(new MemoryStream());
            writer.AutoFlush = true;
            
            writer.WriteLine((context ? "With" : "Without") + " context.");
            writer.WriteLine();
            
            foreach (ConfigEntry entry in entries)
            {
                writer.WriteLine("[{0}]", entry.Name);
                foreach (ConfigValue val in entry.Data)
                {
                    switch (val.Type)
                    {
                        case 0: writer.WriteLine("\"{0}\"", val.Value); break;
                        case 1: writer.WriteLine("I {0:X}h",  val.Value); break;
                        case 2: writer.WriteLine("F {0}",   val.Value); break;
                    }
                }
                
                writer.WriteLine();
            }
            
            return writer.BaseStream;
        }
        
        private static Stream WriteInfo(ConfigEntry[] entries)
        {
            // Gets entries
            TextEntry[] texts = GetInfoEntries(entries, "TEXT");
            TextEntry[] nouns = GetInfoEntries(entries, "NOUN");
            
            if (texts == null || nouns == null)
            {
                return null;
            }
            
            // Sorts entries
            Comparison<TextEntry> comparison = (x, y) => x.Index.CompareTo(y.Index);
            Array.Sort(texts, comparison);
            Array.Sort(nouns, comparison);
            
            // Write to stream
            StreamWriter writer = new StreamWriter(new MemoryStream());
            writer.AutoFlush = true;
            
            WriteInfo(writer, texts, "Texts");
            writer.WriteLine();
            WriteInfo(writer, nouns, "Nouns");

            return writer.BaseStream;
        }
        
        private static void WriteInfo(StreamWriter writer, TextEntry[] list, string typeName)
        {
            writer.WriteLine("########################################");
            writer.WriteLine("#               {0,5}                  #", typeName);
            writer.WriteLine("########################################");
            
            foreach (TextEntry entry in list) 
            {
                writer.WriteLine("{0}:", entry.Index.ToString().PadLeft(4, '0'));
                foreach (string s in entry.Info) 
                {
                    writer.WriteLine("\"{0}\"", s);
                }
                
                writer.WriteLine();
            }
        }
        
        private static TextEntry[] GetInfoEntries(ConfigEntry[] list, string typeName)
        {
            int infoBegin  = SearchEntry(list, typeName + "_INFO_BEGIN");
            int infoEnd    = SearchEntry(list, typeName + "_INFO_END");
            int indexBegin = SearchEntry(list, typeName + "_INDEX_BEGIN");
            int indexEnd   = SearchEntry(list, typeName + "_INDEX_END");
            
            if (infoBegin == -1 || infoEnd == -1 || indexBegin == -1 || indexEnd == -1)
            {
                return null;
            }
            
            uint numEntries = (uint)list[infoBegin].Data[0].Value;
            Dictionary<uint, TextEntry> entries = new Dictionary<uint, TextEntry>((int)numEntries);
            
            // Get info data
            for (int i = infoBegin + 1; i < infoEnd; i++)
            {
                uint id = (uint)list[i].Data[0].Value;
                List<string> infos = new List<string>();
                foreach (ConfigValue val in list[i].Data)
                {
                    if (val.Type == 0 && ((string)val.Value).Length > 2)
                    {
                        infos.Add((string)val.Value);
                    }
                }
                
                TextEntry entry = new TextEntry();
                entry.Info = infos.ToArray();
                entries[id] = entry;
            }
            
            // Get index
            for (int i = indexBegin + 1; i < indexEnd; i++)
            {
                uint id = (uint)list[i].Data[0].Value;
                TextEntry entry = entries[id];
                entry.Index = (uint)list[i].Data[2].Value;
                entries[id] = entry;
            }
            
            TextEntry[] ret = new TextEntry[entries.Count];
            entries.Values.CopyTo(ret, 0);
            return ret;
        }
                
        private static int SearchEntry(ConfigEntry[] list, string name)
        {
            int index = -1;
            
            for (int i = 0; i < list.Length && index == -1; i++)
            {
                if (list[i].Name == name)
                {
                    index = i;
                }
            }
            
            return index;
        }
                
        private ConfigValue GetValue(int index, uint[] types, uint strSecOffset)
        {
            ConfigValue val = new ConfigValue();
            BinaryReaderBE reader = new BinaryReaderBE(this.file.BaseStream);
            
            // Get the type 32bits value from the array
            uint type = types[0];
            for (int i = 1; i < types.Length && index >= (i == 1 ? 12 : 16) ; i++)
            {
                type = types[i];
                index -= (i == 1 ? 12 : 16);
            }
            
            // The value with the info type is stored in separated 8bits (a byte) values
            // here it takes the correct 8bits value for the index.
            uint info = 0;
            info = (00 <= index && index < 04) ? (type >> 24) & 0xFF : info;
            info = (04 <= index && index < 08) ? (type >> 16) & 0xFF : info;
            info = (08 <= index && index < 12) ? (type >> 08) & 0xFF : info;
            info = (12 <= index && index < 16) ? (type >> 00) & 0xFF : info;
            
            // Get the type
            val.Type = (byte)((info >> ((index % 4) * 2)) & 3);
            
            switch (val.Type)
            {
                case 0:     // String
                    int offset = reader.ReadInt32();
                    if (offset == -1)
                    {
                        val.Value = string.Empty; //"<Empty>";
                    }
                    else
                    {
                        reader.BaseStream.Position = this.file.Position + strSecOffset + offset;
                        val.Value = reader.ReadString();
                    }
                    
                    break;
                    
                case 1:     // Integer
                    val.Value = reader.ReadUInt32();
                    break;
                    
                case 2:     // Single value, IEEE-754
                    val.Value = reader.ReadSingle();
                    break;
                    
                case 3:
                    val.Value = null;
                    break;
            }
            
            reader = null;
            return val;
        }
        
        private struct TextEntry
        {
            public string[] Info
            {
                get; set;
            }
            
            public uint Index
            {
                get; set;
            }
        }
                
        private struct ConfigEntry
        {
            public uint Id
            {
                get; set;
            }
            
            public string Name
            {
                get; set;
            }
            
            public ConfigValue[] Data
            {
                get; set;
            }
        }
        
        private struct ConfigValue
        {
            public byte Type
            {
                get; set;
            }
            
            public object Value
            {
                get; set;
            }
            
            public override string ToString()
            {
                return Value.ToString();
            }
        }
    }
}
