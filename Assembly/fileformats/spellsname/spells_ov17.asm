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

; Phoenix spell
.thumb
.org 0x0211C340
  LDR     r6, [SP,#0x1C]  ; Replace R0 with R6 to save instructions later
  CMP     r6, #0

.org 0x0211C34C
  CMP     r6, #0          ; Now we don't need to load R0 again
  BNE     0x211C40C
  LDR     R0, [SP,#0x10]
  CMP     R0, #0
  BEQ     0x211C40C
  LDR     R0, [SP,#0x2C]
  ADD     R1, R5, #0
  .halfword 0xF7E9
  .halfword 0xEFB9  ; Jump to some function
  MOV    R2, R0     ; Spell pointer ...
  .halfword 0x495A  ; LDR R1, =dword_2141660 ; Format
  SUB    r2, #8     ; ... after our changes it starts 8 bytes before

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
