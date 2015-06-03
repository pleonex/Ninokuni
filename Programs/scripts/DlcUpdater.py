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
# from struct import unpack
from os import listdir, path
from datetime import date, datetime
import xml.etree.ElementTree as ET


def should_update_file(path, prefix):
    FILE_DATE_FORMAT = "%m%d%Y"

    # Get full name without extension and basename
    date_string = ""
    for file in listdir(path):
        if file.startswith(prefix) and file.endswith(".bin"):
            filename = file.replace(".bin", "")
            date_string = filename.replace(prefix, "")

    file_date = datetime.strptime(date_string, FILE_DATE_FORMAT).date()
    return file_date < date.today()


def update_distribution(node, base_path, lang):
    # Get output path and date format
    out_path = path.join(base_path, node.get("output"))
    date_format = node.get("dateFormat")

    # Get distribution node
    if not should_update_file(out_path, lang + "_" + "tweet"):
        print "Distribution already updated"
        return
    
    print date_format


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
