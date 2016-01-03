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

; TODO: Fenix spell
;.thumb
;.org 0x0211C360
;LDR     R1, =dword_2141660              ; Format
;MOVS    R2, R0                          ; Spell pointer
;LDR     R1, [R1,#0x38]                  ; Format pointer
;ADD     R0, SP, #0x1B4                  ; Output pointer
;BLX 0x0202159C
;ADD     R0, SP, #0x134
;ADD     R1, SP, #0x1B4
;BL      sub_20DEF40
;LDR     R0, =0x2159E64
;LDR     R1, [SP,#0x10]
; STRB    R5, [R0,#0x10]
;RAM:0211C37A STR     R1, [R0,#0x14]
;RAM:0211C37C LDR     R1, =0x548
;RAM:0211C37E STR     R4, [R0,#0x18]
;RAM:0211C380 ADD     R1, SP
;RAM:0211C382 LDR     R1, [R1]
;RAM:0211C384 LDR     R2, =0x211C6B1
;RAM:0211C386 STR     R1, [R0,#0x1C]
;RAM:0211C388 MOVS    R0, #0
;RAM:0211C38A STR     R0, [SP]
;RAM:0211C38C STR     R0, [SP,#4]
;RAM:0211C38E LDR     R0, [SP,#0x10]
;RAM:0211C390 LDR     R3, =0x2159E74

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
