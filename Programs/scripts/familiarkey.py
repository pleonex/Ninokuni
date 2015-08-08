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
from crcmod import predefined

VERBOSE = 0
HACK = True  # Assembly/password/alphabet.asm changes some things.

ALPHABET1 = "0123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
ALPHABET2_ORIGINAL = ("０１２３４５６７８９"
                      "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん！？")
ALPHABET2_HACK = ("!#$%&()*+,-./0123456789:;<=>?@"
                  "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]"
                  "_abcdefghijklmnopqrstuvwxyz{|}"
                  "~")  # TODO: Missing symbol chars


def print_debug(verbose_level, msg):
    """Print a message in the output depending verbose level."""
    if verbose_level <= VERBOSE:
        print "# DEBUG" + str(verbose_level) + ":",
        print msg


def print_debug_hexlist(verbose_level, msg, hexlist):
    """Print a message and a hex list in the output depending verbose level."""
    if verbose_level <= VERBOSE:
        print "# DEBUG" + str(verbose_level) + ":",
        print msg,
        print "[" + ', '.join(["{:02X}".format(b) for b in hexlist]) + "]"


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

    key = text_to_key(text_key)
    print_debug_hexlist(2, "Key: ", key)

    swap(key)
    print_debug_hexlist(2, "Key: ", key)

    encryption2(key)
    print_debug_hexlist(2, "Key: ", key)

    crc_new = calculate_crc(key)
    crc_old = get_crc(key)
    valid_crc = crc_new == crc_old
    print_debug(2, "Is valid CRC? " + str(valid_crc))
    if not valid_crc:
        raise KeyError("The CRC of the key does not match")

    # CRC is no longer necessary in key
    key = key[0:len(key) - 2]

    encryption(key)
    print_debug_hexlist(2, "Key: ", key)

    # Reverse, I think it's not necessary to create a method for that
    print_debug(3, "Reversing key")
    key.reverse()
    print_debug_hexlist(2, "Key: ", key)

    # Random number can be skipped.

    # TODO: Read familira bit information

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
        idx = ALPHABET2.index(text_key[i]) / step
        alphabet1_key += ALPHABET1[idx]
        print_debug(3, str(i) + " key char " + char + " is at " + str(idx) +
                    " in alphabet2 and is " + ALPHABET1[idx] + " in alphabet1")

    return alphabet1_key


def text_to_key(text):
    """Convert the text representation of a key into a list of bytes."""
    print_debug(3, "Starting to convert to number")
    subkey_length = 0xB

    # Password is splitted into two substrings
    key = []
    for n in range(2):
        subkey = text[n * subkey_length:(n + 1) * subkey_length]
        print_debug(3, "Subkey: " + subkey)

        key_number = 0
        for i in range(subkey_length):
            idx = ALPHABET1.index(subkey[i])
            key_number = key_number + (idx * (len(ALPHABET1) ** i))
            print_debug(3, str(i) + ": char " + subkey[i] + " at " + str(idx) +
                        " makes " + hex(key_number))

        # Conver the number into a byte list and append
        key += [int((key_number >> i) & 0xFF) for i in range(0, 64, 8)]

    return key


#####################
# Common algorithms #
#####################
def swap(key):
    """Make the swap operation. It's the same in both ways."""
    print_debug(3, "Starting to swap")

    # Game implementation, because it's funny.
    rnd = 0x014A76E0              # Init random number
    rnd = (rnd * 0x021FC436) + 1  # Update random number
    rnd &= 0xFFFFFFFF             # ... cast to 32-bits.
    idx = rnd % (len(key) - 2)    # Get swap index, it's ALWAYS 0x0B.
    crc_pos = len(key) - 2
    print_debug(3, '"random" number: ' + hex(rnd) + ", index: " + str(idx) +
                ", CRC index: " + str(crc_pos) + " -> " + hex(key[crc_pos]) +
                ", " + hex(key[idx]))

    # Swap
    tmp = key[crc_pos]
    key[crc_pos] = key[idx]
    key[idx] = tmp


def encryption2(key):
    """Encrypt and decrypt with a second algorithm."""
    print_debug(3, "Starting second encryption")
    keylen = len(key)
    crc = get_crc(key)

    rnd = 0x05888F27 + crc
    for i in range(keylen - 2):
        rnd = (rnd * 0x021FC436) + 1      # Update random number
        rnd = rnd & 0xFFFFFFFF   # It is not necessay but make easier debugging
        encrypt_key = (rnd >> 24) & 0xFF  # Take last byte
        key[i] ^= encrypt_key             # Encrypt
        print_debug(3, '"random" number is ' + hex(rnd) + ", key: " +
                    hex(encrypt_key) + ", decryped: " + hex(key[i]))


def get_crc(key):
    """Get the CRC from the key bytes."""
    print_debug(3, "Getting the CRC from the key")

    keylen = len(key)
    crc = (key[keylen-1] << 8) | key[keylen-2]
    print_debug(3, "CRC is " + hex(crc))

    return crc


def calculate_crc(key):
    """Calculate the CRC16 and compare it."""
    print_debug(3, "Starting to compute CRC-16-genibus")

    keylen = len(key)
    keystring = [chr(b) for b in key[:keylen-2]]
    print_debug(3, "ASCII key: " + str(keystring))

    crc = predefined.Crc("crc-16-genibus")
    crc.update(keystring)
    crc_keydata = int(crc.hexdigest(), 16)

    # Do it like the game does, because it's funny
    constant = [0x5D, 0x10, 0x7A, 0x33, 0x00, 0x77, 0x13, 0x92, 0xDE]
    constant.reverse()
    constant = [(~b) & 0xFF for b in constant]
    constant = [chr(b) for b in constant]
    crc = predefined.Crc("crc-16-genibus")
    crc.update(constant)
    crc_constantdata = int(crc.hexdigest(), 16)  # It's always 0x00D3

    # Mix CRC
    crc_key = crc_constantdata ^ crc_keydata ^ 0x62D3
    print_debug(3, "Key CRC: " + hex(crc_keydata) + ", constant CRC: " +
                hex(crc_constantdata) + ", final CRC: " + hex(crc_key))
    return crc_key


def encryption(key):
    """Encrypt and decrypt with a first algorithm."""
    print_debug(3, "Starting first encryption")

    encryption_key = key[0]
    print_debug(3, "Encryption starts with " + hex(encryption_key))

    for i in range(1, len(key)):
        key[i] ^= encryption_key
        encryption_key = ((encryption_key << 1) & 0xFF) | (encryption_key >> 7)
        encryption_key ^= 0xFF
        print_debug(3, "New value is " + hex(key[i]) + ", new key: " +
                    hex(encryption_key))


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
