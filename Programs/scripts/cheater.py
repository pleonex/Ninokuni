#!/bin/python
# -*- coding: utf-8 -*-
# Modify your Ninokuni save file with cheats ~~ by pleonex.
from __future__ import print_function

import hashlib
import struct
import shutil
import argparse

# CONSTANTS / OFFSETS
# HASH
HASH_TRICK_OFFSET = 0xC5EC
HAS_TRICK = [0x6E, 0x6B, 0x6E, 0x6E]
HASH_START = 0x0002
HASH_LENGTH = 0xFFE2
HASH_OFFSET = 0xFFE4

# ITEMS
ITEMS_OFFSET = 0xC944
ITEMS_NUM = 0x01E8
EQUIPITEMS_OFFSET = 0xCD44
EQUIPITEMS_NUM = 85
SPITEMS_OFFSET = 0xCE04
SPITEMS_NUM = 134
QTY = 99

# MONSTERS
MONSTERS_VIEWED_OFFSET = 0xE348
MONSTERS_VIEWED_NUM = 0x028F
MONSTERS_VIEWED_QTY = 0x0100

# SUBQUESTS
SUBQUESTS_OFFSET = 0x1410
SUBQUESTS_NUMBER = 0x78
SUBQUESTS_LENGTH = 0x20
SUBQUESTS_TODO = 0x0042

# MAGIC NEWS
NEWS_OFFSET = 0xE9E0
NEWS_TITLE_LEN = 0x30
NEWS_BODY_LEN = 0x120
NEWS_ENTRY_LEN = NEWS_TITLE_LEN + NEWS_BODY_LEN + 4


def update_hash(f):
    print("Updating hash...")

    # Write the hash key
    f.seek(HASH_TRICK_OFFSET)
    f.write(bytearray(HAS_TRICK))

    # Create the new hash
    sha1 = hashlib.sha1()
    f.seek(HASH_START)
    sha1.update(f.read(HASH_LENGTH))
    new_digest = sha1.digest()

    # Update the hash in the save
    f.seek(HASH_OFFSET)
    f.write(bytearray(new_digest))

    # Clean the hash key
    f.seek(HASH_TRICK_OFFSET)
    f.write(bytearray([0x00, 0x00, 0x00, 0x00]))


def update_items(f):
    print("Updating items...")

    # Update the quantity of each type of object
    f.seek(ITEMS_OFFSET)
    for _ in range(ITEMS_NUM):
        f.write(struct.pack('<H', QTY))

    f.seek(SPITEMS_OFFSET)
    for _ in range(SPITEMS_NUM):
        f.write(struct.pack('<H', QTY))

    f.seek(EQUIPITEMS_OFFSET)
    for _ in range(EQUIPITEMS_NUM):
        f.write(struct.pack('<H', QTY))


def update_imagens(f):
    print("Updating imagens...")

    # For each imagen, update the number of views
    f.seek(MONSTERS_VIEWED_OFFSET)
    for _ in range(MONSTERS_VIEWED_NUM):
        f.write(struct.pack('<H', MONSTERS_VIEWED_QTY))


def update_subquests(f):
    print("Updating subquests...")

    for i in range(SUBQUESTS_NUMBER):
        f.seek(SUBQUESTS_OFFSET + i * SUBQUESTS_LENGTH)
        f.write(struct.pack('<H', SUBQUESTS_TODO))


def update_magicnews(f):
    print("Updating magic news...")

    title = "Title test!"
    body = """This would be
the description of the magic news."""

    f.seek(NEWS_OFFSET + 0 * NEWS_ENTRY_LEN)
    f.write(title.ljust(NEWS_TITLE_LEN, '\0').encode())
    f.write(body.ljust(NEWS_BODY_LEN, '\0').encode())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Cheat Ni no kuni saves")
    parser.add_argument('save', help='Save file to modify')
    args = parser.parse_args()

    filepath = args.save

    # Make a backup
    shutil.copyfile(filepath, filepath + ".bak")
    print('Backup save file: ' + filepath + '.bak')
    print()

    with open(filepath, "r+b") as f:
        update_items(f)
        update_imagens(f)
        update_subquests(f)
        update_magicnews(f)
        update_hash(f)

    print()
    print('Done!')
