#!/bin/python
# -*- coding: utf-8 -*-
"""
Generate familiar key and show its information.

Copyright 2015 Benito Palacios (aka pleonex)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

from argparse import ArgumentParser

ALPHABET1 = "0123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
ALPHABET2 = ""  # Selected in run-time.
ALPHABET2_JAPANESE = "０１２３４５６７８９"
"あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん！？"
ALPHABET2_SPANISH = "!#$%&()*+,-./0123456789:;<=>?@"
"ABCDEFGHJKLMNPQRSTUVWXYZ[\\]_abcdefghijkmnpqrstuvwxyz{|}"
""  # TODO: Missing symbol chars


##################################
# Generate key from familir info #
##################################
def generate_key(familiar_info):
    """Generate a key with the familiar information provided."""
    return None


def text_to_key(text):
    """Convert the text representation of a key into a list of bytes."""
    num_iterations = 0xB  # It's a constant in code, should guess how to get it
    for i in range(num_iterations):
        idx = ALPHABET1.find(text[i])
        key_new = key_new + (idx * (len(ALPHABET1) ** i))


####################################
# Get the familiar info from a key #
####################################
def get_familiar_info(text_key):
    """Get a dictionary with familiar information from the key."""
    text_key = alphabet2_to_alphabet1(text_key)
    key = key_to_text(text_key)

    return None


def alphabet2_to_alphabet1(text_key):
    """1.- Convert the string from alphabet2 representation to alphabet1."""
    for i in range(len(text_key)):
        idx = ALPHABET2.find(text_key[i])
        text_key[i] = ALPHABET1[idx]

    return text_key


def key_to_text(key):
    """2.- Convert the key bytes into text representation."""
    text = ''
    while key != 0:
        index = key % 0x3A
        text += ALPHABET1[index]
        key /= 0x3A

    return text


if __name__ == "__main__":
    # Parse argument
    parser = ArgumentParser(description="Get familiar information from a key.")
    parser.add_argument("key", help="The familiar key")
    parser.add_argument("--language",
                        help="The game language where the key was generated.",
                        choices=['japanese', 'spanish'],
                        default='japanese')
    args = parser.parse_args()

    # Select the alphabet2 to use depending the game version.
    if args.language == "japanese":
        ALPHABET2 = ALPHABET2_JAPANESE
    elif args.language == "spanish":
        ALPHABET2 = ALPHABET2_SPANISH

    # Decrypt key
    info = get_familiar_info(args.key)
