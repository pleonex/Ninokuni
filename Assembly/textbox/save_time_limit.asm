;;----------------------------------------------------------------------------;;
;;  Increase the time limit to 995:26:35
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

.org 0x0210A530
.area 40
  LDR     R3, [R0]
  LDMIA   R3, {R2,R1}       ; Loads current ticks time

  ; Check the lower part
  LDR     R0, =0xEC6CEFA0
  CMP     R1, R0

  ; Check the higher part
  MOV     R2, #0x1B4
  ADD     R2, #0x2
  CMPEQ   R1, R2

  ; Set limit values if either of the comparaison is greater
  STMHIIA R3, {R0,R2}

  BX      LR
.pool
.endarea

.org 0x0210A4D8
  ; Remove one instruction
  SUBS    R2, R0, R5
  SBC     R0, R1, R6
  LDR     R12, [R3]
  LDR     R1, [R3,#4]
  ADDS    R6, R12, R2
  ADC     R2, R1, R0
  CMP     R1, R2
  CMPEQ   R12, R6
  MOVCS   R2, #0x1B4    ; New instruction
  ; Skip the relative-pc load because I am too lazy to add the pool
.org 0x0210A500
  ADDCS R2, #0x2

; Hard-coded pool
.org 0x0210A518
  .word 0xEC6CEFA0
