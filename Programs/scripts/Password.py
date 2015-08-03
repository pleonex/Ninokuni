#!/bin/python
# -*- coding: utf-8 -*-
###############################################################################
#  Create a Familiar key.                                                     #
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

ALPHABET1 = "0123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
ITERATION = 0xB
KEY = 0x207A49CEE50C8047

if __name__ == "__main__":
    data = KEY
    text = ''
    while data != 0:
        index = data % 0x3A
        text += ALPHABET1[index]
        data /= 0x3A

    key_new = 0
    for i in range(ITERATION):
        idx = ALPHABET1.find(text[i])
        key_new = key_new + (idx * (len(ALPHABET1) ** i))

        # print("Iteration {0:0{1}}: ".format(i, 2) +
        #       "{0:0{1}X}".format(key_new >> 32, 8) + "  " +
        #       "{0:0{1}X}".format(key_new & 0xFFFFFFFF, 8))

    print("{0:#0{2}X} == {1:#0{2}X} => {3} is ".format(KEY, key_new, 16, text) +
          str(KEY == key_new))
