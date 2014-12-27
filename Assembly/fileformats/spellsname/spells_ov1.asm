;;----------------------------------------------------------------------------;;
;;  Increase spell name size - Code in overlay 1 from arm9
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

; In battles, spell list
.thumb
.org 0x0207F86C
  MOV     R1, R4
  LDR     R0, [SP,#0x14]
  DCB 0x86  ; Jump
  DCB 0xF0  ; to
  DCB 0xE0  ; spell_getBlockPtr
  DCB 0xEB  ; routine
  SUB     r0, #0x08         ; Fix to get the right pointer to name
  STR     R0, [SP,#0x18]
