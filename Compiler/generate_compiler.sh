#!/bin/bash
# Compile and copy all the compiler programs.
# ~~ by pleonex ~~

# Get the path to some useful folders.
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMPILER_DIR="${SCRIPT_DIR}"
PROGRAMS_DIR="${SCRIPT_DIR}/../Programs"

# Default xbuild command to build
XBUILD="xbuild /v:minimal /p:TarjetFrameworkVersion=v4.0 /p:Configuration=Debug /p:OutputPath=${COMPILER_DIR}"

# First and most important: modime
${XBUILD} "${PROGRAMS_DIR}"/modime/modime.sln

# Also NinoDrive with the GDrive Spreadsheets support
${XBUILD} "${PROGRAMS_DIR}"/NinoDrive/NinoDrive/NinoDrive.csproj

# Finally remove all the debug symbols
rm "${COMPILER_DIR}"/*.mdb
