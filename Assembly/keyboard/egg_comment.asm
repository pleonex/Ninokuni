;;----------------------------------------------------------------------------;;
;;  Update the cursor coordinates for the egg comments.
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

@getStringWidth equ 0x020CBE14
@copyArray      equ 0x0201F230

.arm

;; Calculate the X position of the cursor in this case
;; It was multiplying the current size by 0x0C
.org 0x0208C5E8
  MOV     r5, r4            ; Save the r4 value for later
  MOV     r4, r7            ; Arg3: Keyboard struct
  LDR     r1, [r7,#0x3D8]   ; Arg1: String length
  MOV     r7, r3,ASR#5      ; Number of lines = Num chars / Chars per line (32)
  MOV     r0, r7,LSL#5      ; Arg0: Skipped chars = remove previous lines chars
  MOV     r2, #0            ; Arg2: Extra width added
  BL      @getStringWidth
  MOV     r12, r1

  ADD     R0, r5, #0x3B000
  MOV     R1, #0x12
  MUL     R3, r7, R1


;; Split the text in different lines
.org 0x0208D60C
  MOV     R11, #0x20            ; Bytes per line

.org 0x0208D61C
  MOV     R0, R7                ; Output
  MOV     R2, R11               ; Max size
  ADD     R1, R8, R9,LSL#5      ; Subindex in the string in each iteration
  BL      @copyArray            ; Before it was copying 2-byte per char

.org 0x0208D650
  CMP     R9, #2                ; Number of lines
