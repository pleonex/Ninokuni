;;----------------------------------------------------------------------------;;
;;  Fix delete button
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

@UpdateCursor   equ  020C66B0h

.org 0x020C6400
.area 0x64
  STMFD   SP!, {R3,LR}

  ; Check that size is bigger than 0.
  LDR     R1, [R0,#0x3D4]
  CMP     R1, #0
  LDMLEFD SP!, {R3,PC}

  ; Decrease size
  SUB     R1, R1, #1
  STR     R1, [R0,#0x3D4]

  ; Check if cursor is not at the end (not removing last char)
  LDR     R12, [R0,#0x3D8]
  CMP     R12, R1
  BGE     @setNullChar

  ; In that case we shift the name to the left from that position
  @shiftName:
  LDR     R3, [R0,0x3D0]
  ADD     R1, R3, R12  ;,LSL#1              ; No need to *2 to get index
  LDRB    R1, [R1,#1]
  MOV     R2, R12  ;,LSL#1                  ; No need to *2 to get index
  STRB    R1, [R3,R2]

  ; Increase the cursor (iteration var) until the end of the buffer
  ADD     R12, R12, #1
  LDR     R1, [R0,#0x3D4]
  CMP     R12, R1
  BLT     @shiftName

  @setNullChar:
  ; Write a null char at the end
  LDR     R2, [R0,#0x3D0]                   ; Get name pointer
  NOP  ;MOV     R1, R1,LSL#1                    ; No need to *2 to get index
  MOV     R3, #0                            ; Write null char
  STRB    R3, [R2,R1]                       ; ...

  ; Update the cursor
  LDR     R1, [R0,#0x3D8]
  BL      @UpdateCursor

  LDMFD   SP!, {R3,PC}
.endarea
