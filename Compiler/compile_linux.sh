#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OUTPUT_ROM="${SCRIPT_DIR}/../GameData/Ninokuni [PATCHED].nds"
OUTPUT_PATCH="${SCRIPT_DIR}/../GameData/Ninokuni.xdelta"

# Generate game
mono modime.exe --set-input-names=Ninokuni.nds -i "${SCRIPT_DIR}/Ninokuni.xml" "${SCRIPT_DIR}/Ninokuni english.xml" \
    "$1" "${OUTPUT_ROM}"

# Generate patch
echo "Making patch..."
xdelta -e -9 -f -s "$1" "${OUTPUT_ROM}" "${OUTPUT_PATCH}"
