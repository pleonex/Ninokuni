#!/bin/bash
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
desmume --arm9gdb 23946 "${SCRIPT_DIR}/GameData/Ninokuni [PATCHED].nds"
