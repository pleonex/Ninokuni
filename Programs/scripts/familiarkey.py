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

from argparse import ArgumentParser, ArgumentTypeError

VERBOSE = 0
HACK = True  # Assembly/password/alphabet.asm changes some things.

ALPHABET1 = "0123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
ALPHABET2_ORIGINAL = ("０１２３４５６７８９"
                      "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん！？")
ALPHABET2_HACK = ("!#$%&()*+,-./0123456789:;<=>?@"
                  "ABCDEFGHIJKLMNPQRSTUVWXYZ[\\]_"
                  "abcdefghijkmnpqrstuvwxyz{|}")
""  # TODO: Missing symbol chars


def print_debug(verbose_level, msg):
    """Print a message in the console depending its verbose level."""
    if verbose_level <= VERBOSE:
        print "# DEBUG" + str(verbose_level) + ":",
        print msg


##################################
# Generate key from familir info #
##################################
def generate_key(familiar_info):
    """Generate a key with the familiar information provided."""
    return None


def key_to_text(key):
    """2.- Convert the key bytes into text representation."""
    text = ''
    while key != 0:
        index = key % 0x3A
        text += ALPHABET1[index]
        key /= 0x3A

    return text


####################################
# Get the familiar info from a key #
####################################
def get_familiar_info(text_key):
    """Get a dictionary with familiar information from the key."""
    print_debug(2, "Starting to decrypt key.")

    text_key = alphabet2_to_alphabet1(text_key)
    print_debug(2, "Key in alphabet1 format is " + text_key)

    key_number = text_to_key(text_key)
    print_debug(2, "Key in numeric number is " + str(key_number))

    return None


def is_valid_key(text_key):
    """Check if it's a valid familiar key."""
    if len(text_key) != 44:
        raise ArgumentTypeError("Invalid familiar key length. It must be 44.")

    return text_key


def alphabet2_to_alphabet1(text_key):
    """1.- Convert the string from alphabet2 representation to alphabet1."""
    print_debug(3, "Starting to convert to alphabet1")
    alphabet1_key = ""

    # With the hack we converted one kanji char to two ASCII chars.
    step = 2 if HACK else 1
    ALPHABET2 = ALPHABET2_HACK if HACK else ALPHABET2_ORIGINAL

    for i in range(0, len(text_key), step):
        char = text_key[i:i+2] if HACK else text_key[i]
        idx = ALPHABET2.find(text_key[i]) / step
        alphabet1_key += ALPHABET1[idx]
        print_debug(3, str(i) + " key char " + char + " is at " + str(idx) +
                    " in alphabet2 and is " + ALPHABET1[idx] + " in alphabet1")

    return alphabet1_key


def text_to_key(text):
    """Convert the text representation of a key into a list of bytes."""
    num_iterations = 0xB  # It's a constant in code, should guess how to get it
    key_new = 0
    for i in range(num_iterations):
        idx = ALPHABET1.find(text[i])
        key_new = key_new + (idx * (len(ALPHABET1) ** i))


if __name__ == "__main__":
    # Parse argument
    parser = ArgumentParser(description="Get familiar information from a key.")
    parser.add_argument("key", help="The familiar key", type=is_valid_key)
    parser.add_argument("--hack",
                        help="If the game had the password ASCII hack.",
                        type=bool,
                        default=True)
    parser.add_argument("--verbose", "-v", action='count')
    args = parser.parse_args()

    # Set verbose level
    VERBOSE = args.verbose
    print_debug(2, "Verbose level set to " + str(VERBOSE))

    # Select the alphabet2 to use depending the game version.
    print_debug(2, "The game had the ASCII hack? " + str(args.hack))
    HACK = args.hack

    # Decrypt key
    print_debug(2, "Input key is " + args.key)
    info = get_familiar_info(args.key)

    # Print result
    print "\nResult:"
    print info
