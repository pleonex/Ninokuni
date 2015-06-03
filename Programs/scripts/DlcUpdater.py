#!/bin/python
# -*- coding: utf-8 -*-
###############################################################################
#  Update the content of distribution and tweet files - V1.0                  #
#  Copyright 2015 Benito Palacios (aka pleonex)                               #
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
from struct import pack
from os import listdir, path
from datetime import datetime
from binascii import crc32
import xml.etree.ElementTree as ET

# Set today as global variable just in case the day change while the
# program is running (very very rare case but...)
TODAY = datetime.today()


def add_distribution_header(data):
    HEADER = "NNKN"
    checksum = crc32(data)
    return bytearray(HEADER, 'ascii') + pack("<i", checksum) + data


def xml2binary(node, date_format):
    NUM_ELEMENTS = 0x80 / 8  # Actually, there are 0x72
    INVALID_DATE = datetime(1, 1, 1)

    data = bytearray(NUM_ELEMENTS)
    for element in node.findall("Element"):
        element_date = datetime.strptime(element.get("releaseOn"), date_format)

        if element_date != INVALID_DATE and element_date <= TODAY:
            element_id = int(element.get("id"))
            byte_index = element_id / 8
            bit_index = element_id % 8
            data[byte_index] |= (1 << bit_index)

    return data


def should_update_file(path, prefix):
    FILE_DATE_FORMAT = "%m%d%Y"

    # Get full name without extension and basename
    date_string = ""
    for file in listdir(path):
        if file.startswith(prefix) and file.endswith(".bin"):
            filename = file.replace(".bin", "")
            date_string = filename.replace(prefix, "")

    # If the file does not exist
    if date_string == "":
        return True

    file_date = datetime.strptime(date_string, FILE_DATE_FORMAT).date()
    return file_date < TODAY


def update_distribution(node, base_path, lang):
    # Get output path and date format
    out_path = path.join(base_path, node.get("output"))
    date_format = node.get("dateFormat")

    # Get distribution node
    if should_update_file(out_path, lang + "_" + "tweet"):
        print "Updating distribution DLC"
        data = xml2binary(node, date_format)
        data = add_distribution_header(data)
        print '-'.join('{:02x}'.format(x) for x in data)


def update_magic_news(node, base_path, lang):
    # Not implemented
    pass


def update_translation_files(node, base_path):
    lang = node.get("language")

    # Get distribution node
    distribution = node.find("Distribution")
    update_distribution(distribution, base_path, lang)

    # Get magic news node
    magic_news = node.find("MagicNews")
    update_magic_news(magic_news, base_path, lang)


if __name__ == "__main__":
    # Get arguments
    parser = ArgumentParser(description="Update DLC files of Ninokuni DS")
    parser.add_argument('dlcinfo', help='path to XML with the info')
    args = parser.parse_args()

    # Get base path (the one from the xml)
    base_path = path.dirname(path.realpath(args.dlcinfo))

    # Get translations nodes
    root = ET.parse(args.dlcinfo).getroot()
    for trans in root.findall("Ninokuni"):
        update_translation_files(trans, base_path)
