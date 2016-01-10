#!/bin/bash

# Generate game
mono modime.exe --set-input-names=Ninokuni.nds -i "Ninokuni.xml" "Ninokuni english.xml" "$1" "$HOME/Ninokuni [PATCHED].nds"

# Generate patch
echo "Making patch..."
xdelta -e -9 -s "$1" "$HOME/Ninokuni [PATCHED].nds" "$HOME/Ninokuni.patch"
