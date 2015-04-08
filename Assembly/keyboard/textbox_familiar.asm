;;----------------------------------------------------------------------------;;
;;  Fix the position of the textboxes
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

; Textbox Box X Position
.org 0x0207AD18
  MOV     R1, #88 + 15

@fixed_oam_initXYZ equ 0x02043BD0
@nanr__loadBank    equ 0x020DA000

; L/R Cursor
.org 0x0207AC60
  ADD     R8, R10, R9,LSL#2
  ADD     r8, R8, #0x3A000      ; Edited
  STR     R0, [r8,#0xC90]       ; Edited
  LDR     R2, [R0]
  ADD     R1, R4, #0x3A800
  LDR     R2, [R2,#0x5C]
  BLX     R2
;  ADD     R0, R8, #0x3A000     ; Removed
  LDR     R0, [r8,#0xC90]       ; Edited
;  MOV     R1, #0x80
  MOV     r1, #-30              ; Difference: 2*extra_x
  MOV     r2, #0x8F             ; X base: 0x80 + extra_x (15)
  MLA     r1, r9, r1, r2        ; Substract for the second case (R button)
  MOV     R2, #0x60
  MOV     R3, R7
  BL      @fixed_oam_initXYZ
;  ADD     R0, R8, #0x3A000     ; Removed
  LDR     R0, [r8,#0xC90]       ; Edited
  MOV     R1, R6
  LDR     R2, [R0]
  LDR     R2, [R2,#0x3C]
  BLX     R2
  MOV     R0, R8                ; Edited
  LDR     R0, [R0,#0xC90]
  MOV     R1, R6
  BL      0x20D9FF0
  MOV     R0, R8                ; Edited
  ADD     R1, R9, R9,LSL#1
  MOV     R1, R1,LSL#16
  LDR     R0, [R0,#0xC90]
  MOV     R1, R1,LSR#16
  BL      @nanr__loadBank
  MOV     R0, R8                ; Edited
  LDR     R0, [R0,#0xC90]
  MOV     R1, R7
  BL      0x20DA190
  ADD     R9, R9, #1
  CMP     R9, #2
  BLT     0x207AC38
