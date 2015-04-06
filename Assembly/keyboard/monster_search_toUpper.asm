;;----------------------------------------------------------------------------;;
;;  Char to upper case for familar wiki search function.
;;  Copyright 2015 Benito Palacios (aka pleonex)
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

.org 0x020CBE78
.area 0x64
@toUpper:
  ; Alphabet
  CMP    R1, 'z'
  BGT    @accents
  CMP    R1, 'a'
  SUBGE  R1, #0x20

  ; Accents
  @accents:
  CMP    R1, #0xAC ; 'ú'
  BGT    @specialChars
  CMP    R1, #0xA8 ; 'á'
  SUBGE  R1, #0x05

  @specialChars:
  CMP    R1, #0xAD ; 'ñ'
  ADDEQ  R1, #1

  CMP    R1, #0xAF ; 'ü'
  ADDEQ  R1, #1

  @end:
  BX     LR
.endarea
