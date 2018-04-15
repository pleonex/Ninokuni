#!/bin/bash
overlay_folder=$1
overlay=$2

cp "$overlay_folder/overlay9_$overlay.bin" ./

wine armips.exe "overlay9_$overlay.asm"
if [[ $? -ne 0 ]] ; then
    echo "Error!"
else
    echo "Good ;)"
fi

#wine /home/pleonex/Dropbox/NinokuniEnglish/NinoPatcher/programs/blz.exe -en "./overlay9_$overlay.bin"
rm "./overlay9_$overlay.bin"
