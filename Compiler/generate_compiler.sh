#!/bin/bash
# Compile and copy all the compiler programs.
# ~~ by pleonex ~~

# Get the path to some useful folders.
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMPILER_DIR="${SCRIPT_DIR}"
PROGRAMS_DIR="${SCRIPT_DIR}/../Programs"

# Default msbuild command to build
MSBUILD="msbuild /v:minimal /p:TarjetFrameworkVersion=v4.5 /p:Configuration=Release /p:OutputPath=${COMPILER_DIR}"

# Clone submodules
git submodule update --init --recursive

# Also NinoDrive with the GDrive Spreadsheets support
nuget restore "${PROGRAMS_DIR}"/NinoDrive/NinoDrive.sln
${MSBUILD} "${PROGRAMS_DIR}"/NinoDrive/NinoDrive/NinoDrive.csproj

# NinoImager for the images!
pushd "${PROGRAMS_DIR}"/NinoImager/lib/emgucv
  pushd opencv
    patch -p1 -N -i ../../opencv_fix.patch
  popd

  patch -p1 -N -i ../emgucv_fix.patch
  cmake .
  make
popd
cp "${PROGRAMS_DIR}"/NinoImager/lib/emgucv/bin/libcvextern.so "${COMPILER_DIR}"/linux/
${MSBUILD}/linux "${PROGRAMS_DIR}"/NinoImager/ninoimager.sln

# NerdFontTerminatoR for fonts
${MSBUILD} "${PROGRAMS_DIR}"/NerdFontTerminatoR/NerdFontTerminatoR.sln
mv NerdFontTerminatoR.CLI.exe NerdFontTerminatoR.exe

# First and most important: modime
${MSBUILD} "${PROGRAMS_DIR}"/modime/modime.sln

# Finally remove all the debug symbols
rm "${COMPILER_DIR}"/*.pdb
