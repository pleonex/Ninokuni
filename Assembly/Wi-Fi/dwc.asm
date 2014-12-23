;;----------------------------------------------------------------------------;;
;;  Change Wi-Fi menu settings language
;;  Copyright 2014 Benito Palacios (aka pleonex)
;;
;;  Licensed under the Apache License, Version 2.0 (the "License");
;;  you may not use this file except in compliance with the License.
;;  You may obtain a copy of the License at
;;
;;      http://www.apache.org/licenses/LICENSE-2.0
;;
;;  Unless required by applicable law or agreed to in writing, software
;;  distributed under the License is distributed on an "AS IS" BASIS,
;;  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;  See the License for the specific language governing permissions and
;;  limitations under the License.
;;----------------------------------------------------------------------------;;

JAPANESE        equ #0x00
ENGLISH         equ #0x01
FRENCH          equ #0x02
GERMAN          equ #0x03
ITALIAN         equ #0x04
SPANISH         equ #0x05
KOREAN          equ #0x06

SCR_NJAP_START  equ #0x00   ; "Default start" screen for language different to Japanese
SCR_NJAP_SELECT equ #0x01   ; "Select connection" screen for language different to Japanese
SCR_JAP_START   equ #0x10   ; "Default start" screen for Japanese language
SCR_JAP_SELECT  equ #0x11   ; "Select connection" screen for Japanese language

.org 0209CB48h
    MOV         R1, SPANISH
    MOV         R2, SCR_NJAP_START
