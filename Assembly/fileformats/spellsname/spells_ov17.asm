;;----------------------------------------------------------------------------;;
;;  Increase spell name size - Code in overlay 17 from arm9
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

; Spell load routine
.arm
.org 0x02105DC0
  ADD     R0, R5, #0x200
  LDRH    R1, [R0,#0x38]
  CMP     R1, #0x46
  MOVHI   R1, #0x46
  STRHIH  R1, [R0,#0x38]
  CMN     R9, #1
  MOVEQ   R4, #0
  LDREQSH R9, [R0,#0x38]
  CMP     R4, #0
  BEQ     0x2105DFC
  ADD     R0, SP, #0x00
  MOV     r7, #0x48
  MUL     r1, r4, r7

.org 0x02105E0C
  MOV     r7, #0x48  ; Tamaño del bloque

; In 'zoom' menu
.thumb
.org 0x0212103C
  DCB 0xE5 ; Õ
  DCB 0xF7 ; ¸
  DCB 0x48 ; F
  DCB 0xE9 ; Ú
  SUB     r0, #0x08
  NOP
  POP     {R4-R6,PC}

; In Team->Techniques menu
.arm
.org 0x02131124
  SUB     r11, r0, #0x08

; Learning a new spell
.thumb
.org 0x0211C082
.halfword 0x4E81        ; MOV R6, 0x434
TST     R4, R7           ; To save memory

.org 0x0211C0A8
  MOV r2, r0            ; Replaced 'MOV R6, 0x434'
  .halfword 0x4976      ; MOV R1, #0x2141660
  ADD R6, SP
  SUB r2, #0x8          ; New, decrease pointer to spell name


.arm
.org 0x2106034
.area 80
;; Get Spell Pointer
;; ARGUMENTS:
;;   R0: Address table
;;   R1: Spell number
  STMFD   SP!, {R3-R5,LR}
  MOV     R5, R0
  MOV     R4, R1
  ADD     R1, R5, R4,LSL#2
  LDR     R1, [R1,#0x120]
  CMP     R1, #0
  BNE     0x210605C

  MOV     R1, R4
  MOV     R2, #1
  BL      0x2105D8C     ; Load Spell Block

  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#0x120]
  ADD     R0, R0, #0x08
  LDMFD   SP!, {R3-R5,PC}
.endarea
