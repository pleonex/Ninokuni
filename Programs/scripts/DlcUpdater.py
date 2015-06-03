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

# from argparse import ArgumentParser
# from struct import unpack
from os import listdir
from datetime import date, datetime


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


if __name__ == "__main__":
    print(should_update_file(".", "tweet"))
