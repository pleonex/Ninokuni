#!/bin/bash
# Compile and copy all the compiler programs.
# ~~ by pleonex ~~

# Get the path to some useful folders.
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMPILER_DIR="${SCRIPT_DIR}"
PROGRAMS_DIR="${SCRIPT_DIR}/../Programs"

# Default xbuild command to build
XBUILD="xbuild /v:minimal /p:TarjetFrameworkVersion=v4.5 /p:Configuration=Release /p:OutputPath=${COMPILER_DIR}"

# Clone submodules
git submodule update --init --recursive

# First and most important: modime
${XBUILD} "${PROGRAMS_DIR}"/modime/modime.sln

# Also NinoDrive with the GDrive Spreadsheets support
${XBUILD} "${PROGRAMS_DIR}"/NinoDrive/NinoDrive/NinoDrive.csproj

# NinoImager for the images!
pushd "${PROGRAMS_DIR}"/NinoImager/lib/emgucv
  pushd opencv
    patch -p1 -N -i ../../opencv_fix.patch
  popd

  patch -p1 -N -i ../emgucv_fix.patch
  cmake .
  make -j9
popd
cp "${PROGRAMS_DIR}"/NinoImager/lib/emgucv/bin/libcvextern.so "${COMPILER_DIR}"/linux/
${XBUILD}/linux "${PROGRAMS_DIR}"/NinoImager/ninoimager.sln

# NerdFontTerminatoR for fonts
${XBUILD} "${PROGRAMS_DIR}"/NerdFontTerminatoR/NerdFontTerminatoR.sln

# Finally remove all the debug symbols
rm "${COMPILER_DIR}"/*.mdb
