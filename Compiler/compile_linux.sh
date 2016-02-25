#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OUTPUT_ROM="${SCRIPT_DIR}/../GameData/Ninokuni [PATCHED].nds"
OUTPUT_PATCH="${SCRIPT_DIR}/../GameData/Ninokuni.xdelta"

ORIGINAL_ROM=$1
TRANSLATION_DIR=$2

# Generate the images
mono "${SCRIPT_DIR}/linux/ninoimager.exe" -i \
    "${TRANSLATION_DIR}/Images/Translated/"  \
    "${TRANSLATION_DIR}/Images/N2D/"         \
    "${SCRIPT_DIR}/Ninokuni.xml"             \
    "${SCRIPT_DIR}/Ninokuni english.xml"     \
    "${SCRIPT_DIR}/linux/MultiImport.xml"

# Generate game
mono "${SCRIPT_DIR}/modime.exe" --set-input-names=Ninokuni.nds -i \
    "${SCRIPT_DIR}/Ninokuni.xml"         \
    "${SCRIPT_DIR}/Ninokuni english.xml" \
    "$1" "${OUTPUT_ROM}"

# Generate patch
echo "Making patch..."
xdelta -e -9 -f -s "${ORIGINAL_ROM}" "${OUTPUT_ROM}" "${OUTPUT_PATCH}"
