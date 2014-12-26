#!/bin/python
# -*- coding: utf-8 -*-
###############################################################################
#  Exports the relation between ImagenParam and ImagenName files - V1.0       #
#  Copyright 2014 Benito Palacios (aka pleonex)                               #
#                                                                             #
#  Licensed under the Apache License, Version 2.0 (the "License");            #
#  you may not use this file except in compliance with the License.           #
#  You may obtain a copy of the License at                                    #
#                                                                             #
#      http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                             #
#  Unless required by applicable law or agreed to in writing, software        #
#  distributed under the License is distributed on an "AS IS" BASIS,          #
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#  See the License for the specific language governing permissions and        #
#  limitations under the License.                                             #
###############################################################################

from argparse import ArgumentParser
from struct import unpack

# CONSTANTS / OFFSETS #
NUM_IMAGENS = 654
IMAGEN_FAMILY = 0x12
IMAGEN_INDEX = 0x14
IMAGENPARAM_BLOCK = 0xB4
IMAGENPARAM_NAME_LEN = 0x10
IMAGENNAME_ENTRIES = 0x08
IMAGENNAME_ENTRY_LEN = 0x08


# Gets the name index of ImagenName from ImagenParam entry
def get_nameIndex(f_param, index):
    offset = index * IMAGENPARAM_BLOCK

    # Imagen family
    f_param.seek(offset + IMAGEN_FAMILY + 2)
    fam = unpack("<H", f_param.read(2))[0]
    fam = fam ^ 0xFFFF

    # Imagen index
    f_param.seek(offset + IMAGEN_INDEX + 2)
    idx = unpack("<H", f_param.read(2))[0]
    idx = idx ^ 0xFFFF

    return (idx - 0x61) + (fam - 1) * 4


# Decode a shift-jis string into utf-8
def decode(string):
    return string.decode('shift_jis').encode('utf-8').replace('\0', '')


# Get the list of names of that familiar from ImagenName
def get_names(f_name, index):
    names = []

    # Seek to block
    f_name.seek(index * IMAGENNAME_ENTRIES * IMAGENNAME_ENTRY_LEN)

    # Read names
    for i in range(IMAGENNAME_ENTRIES):
        name = decode(f_name.read(IMAGENNAME_ENTRY_LEN))
        names.append(name)

    return names


if __name__ == "__main__":
    parser = ArgumentParser(description="Export the relation between ImagenParam and ImagenName")
    parser.add_argument('imagenparam', help='path to ImagenParam.dat file')
    parser.add_argument('imagenname', help='path to ImagenName.dat file')
    parser.add_argument('output', help='path to output file')
    args = parser.parse_args()

    # Open files
    with open(args.imagenparam, "rb") as f_param:
        with open(args.imagenname, "rb") as f_name:
            with open(args.output, "w") as f_out:
                # For each imagen
                for i in range(NUM_IMAGENS):
                    index = get_nameIndex(f_param, i)
                    names = get_names(f_name, index)

                    # Get real name
                    f_param.seek(i * IMAGENPARAM_BLOCK + 2)
                    name_enc = unpack("16B", f_param.read(IMAGENPARAM_NAME_LEN))
                    name = decode(''.join([chr(c ^ 0xFF) for c in name_enc]))

                    # Export results
                    f_out.write(name + '\n')
                    f_out.write('\t' + '\n\t'.join(names) + '\n')
                    f_out.write('\n\n')

    print 'Done!'
