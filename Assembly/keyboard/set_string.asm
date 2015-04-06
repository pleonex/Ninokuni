;;----------------------------------------------------------------------------;;
;;  Fix the initialization of the keyboard string.
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

.org 0x020C62E4
  STMFD   SP!, {R3,LR}

  ; Initial size to 0
  MOV     R2, #0
  B       @readChar

  @writeChar:
  LDR     R3, [R0,#0x3D0]       ; Name ptr
  MOV     R2, LR   ;,LSL#1      ; Get index
  STRB    R12, [R3,R2]          ; Write char into the name pointer
  LDR     R2, [R0,#0x3D4]       ; Update current size...
  ADD     R2, R2, #1            ; ... adding one

  @readChar:
  STR     R2, [R0,#0x3D4]       ; Store the current size
  LDR     LR, [R0,#0x3D4]       ; Get the it again -.-'
  MOV     R2, LR   ;,LSL#1      ; And use it as index to get next char
  LDRB    R12, [R1,R2]          ; ...
  CMP     R12, #0               ; ... so we check it is not null
  BEQ     @writeNull

  LDR     R2, [R0,#0x3CC]       ; Check if we can copy more bytes...
  CMP     LR, R2                ; ...
  BLT     @writeChar            ; ...

  @writeNull:
  LDR     R2, [R0,#0x3D0]       ; Get the name pointer
  MOV     R1, LR  ;,LSL#1       ; ... and use the size as index
  MOV     R3, #0                ; ... to write a null char
  STRB    R3, [R2,R1]           ; ... at the end
  LDR     R1, [R0,#0x3D4]       ; Get the size to call now update_cursor
