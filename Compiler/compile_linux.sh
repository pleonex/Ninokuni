#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "USAGE: compile_linux.sh SOURCE_ROM TRANSLATION_DIR [IMPORT_IMG=1]"
    exit -1
fi

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OUTPUT_ROM="${SCRIPT_DIR}/../GameData/Ninokuni [PATCHED].nds"
OUTPUT_PATCH="${SCRIPT_DIR}/../GameData/Ninokuni.xdelta"

ORIGINAL_ROM=$1
TRANSLATION_DIR=$2
IMPORT_IMGS=${3:-1}

# Generate the images
if [ "$IMPORT_IMGS" -ne "0" ] ; then
    mono "${SCRIPT_DIR}/linux/ninoimager.exe" -i \
        "${TRANSLATION_DIR}/Images/Translated/"  \
        "${TRANSLATION_DIR}/Images/N2D/"         \
        "${SCRIPT_DIR}/Ninokuni.xml"             \
        "${SCRIPT_DIR}/Ninokuni english.xml"     \
        "${SCRIPT_DIR}/linux/MultiImport.xml"

    if [ $? -ne 0 ]; then echo "ERROR"; exit -1; fi
fi

# Generate game
mono "${SCRIPT_DIR}/modime.exe" --set-input-names=Ninokuni.nds -i \
    "${SCRIPT_DIR}/Ninokuni.xml"         \
    "${SCRIPT_DIR}/Ninokuni english.xml" \
    "$1" "${OUTPUT_ROM}"
if [ $? -ne 0 ]; then echo "ERROR"; exit -1; fi

# Generate patch
echo "Making patch..."
xdelta -e -9 -f -s "${ORIGINAL_ROM}" "${OUTPUT_ROM}" "${OUTPUT_PATCH}"
