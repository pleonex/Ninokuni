;;----------------------------------------------------------------------------;;
;;  Update the cursor coordinates
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

;;----------------------------------------------------------------------------;;
;; New code located at unused keyboard keys
;;----------------------------------------------------------------------------;;
.org 0x020CBE14
.area 0x64
@getStringWidth:
; Get the width in pixel of a string.
; ARGUMENTS:
;   R0: Skipped chars
;   R1: String length
;   R2: Width to add
;   R4: Keyboard struct
; RETURNS:

  @font_getGlyphIdx  equ 0x0202FE00
  @font_getGlyphSize equ 0x0202FE48

  STMFD   SP!, {R5,R6,R7,LR}

  MOV     R7, R1                ; String length
  MOV     R5, R2                ; Length
  LDR     R6, [R4, 0x3D0]       ; Name pointer
  ADD     R6, R0                ; Skip some chars
  B       @checkIfNextIsNull

  @addWidthChar:
  ; Substract size
  SUB     R7, R7, #1

  ; Get the index of the char
  LDR     R0, [R4,#0xC+0x20]    ; Font object
  BL      @font_getGlyphIdx

  ; Get the CWDH section for the char
  MOV     R1, R0                ; Char index
  LDR     R0, [R4,#0xC+0x20]    ; Font object
  BL      @font_getGlyphSize

  ; Read the "Advance" field and add it
  LDRB    R0, [R0,#2]           ; Advance
  ADD     R5, R0                ; Add to current length

  @checkIfNextIsNull:
  LDRB    R1, [R6], #1          ; Read next char
  CMP     R1, #0                ; Check if it's not null
  CMPNE   R7, #0                ; Check there are chars to read
  BNE     @addWidthChar

  MOV     R1, R5

  LDMFD   SP!, {R5,R6,R7,PC}
.endarea


;;----------------------------------------------------------------------------;;
;; Patch for kb_updateCursor function
;;----------------------------------------------------------------------------;;
; # Mode: Variable separation
.org 020C66D4h
.area 0x24
STR     R1, [R4,#0x3D8] ; Set cursor position

LDR     R2, [R4,#0x3E8] ; Load Box X Position
ADD     R2, R2, #0x4

MOV     R0, #0
BL      @getStringWidth

LDR     R2, [R4,#0x3EC] ; Load Box Y Position
ADD     R2, R2, #0x11

LDR     R0, [R4,#0x180] ; Load Pointer OAM Cursor
.endarea


; # Mode: Constante separation between chars
;.org 020C66E0h
;.area 4h
;  MOV     R0, #0xE
;.endarea
