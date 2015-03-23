;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the select skill menu.
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

;; Enemies strings
.org 0x020B0148
  STMFD   SP!, {R4-r12,LR}

.org 0x020B0394
  MOVS    r12, r9
  MOVNE   r12, #0x0C             ; Y separation
  BNE     loc_20B03A8

  LDRB    R0, [R8,#2]
  BLX     0x020D6408
  B       loc_20B03B0

loc_20B03A8:
  LDRB    R0, [R8,#6]
  BLX     0x020D6414

loc_20B03B0:
  MOV     R4, R0
  LDR     R0, =0x02141660
  ADD     R0, R0, R4,LSL#2
  LDR     R1, [R0,#0xFC]
  MOV     R0, R6
  BLX     0x020DEF40

  STR     R11, [SP]
  ADD     R0, R10, #0x44
  MOV     r1, #0xBB + 3         ; X position
  ADD     r2, r12, #0x66 + 6    ; Y position
  MOV     R3, R6

.org 0x020B063C
  LDMFD   SP!, {R4-r12,PC}

.org 0x020B0650
  .pool


;; Eria images
.org 0x020AFC24
  MOV r1, #0xE9         ; X position
  ADD r2, r2, #0x70 + 4 ; Y position

.org 0x020AFBCC
  MOV r4, #0x12 - 6     ; Y separation
