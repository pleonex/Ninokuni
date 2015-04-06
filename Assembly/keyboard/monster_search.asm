;;----------------------------------------------------------------------------;;
;;  Familiar wiki search.
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

.arm

@toUpper equ 0x020CBE78

; # Copy user input
; First char must be upper case
.org 0x020911D8
  MOV     R2, #9

  @copyLoop:
  LDRB    R1, [R3],#1
  CMP     R2, #9
  BLEQ    @toUpper
  SUBS    R2, R2, #1
  STRB    R1, [R7], #1
  NOP
  BNE     @copyLoop
