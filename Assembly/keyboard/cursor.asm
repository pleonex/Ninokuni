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
.area 3Ch
@getStringWidthCursor:
; Update the cursor OAM coordinates
;
; ARGUMENTS:
;   R0: Nothing
;   R1: Cursor position
;   R3: Base X coordinate
; RETURNS:

  @font_getStringWidth equ 020DF610h

  STMFD   SP!, {R0,R2,R5,LR}

  ; Add 0 pixels for char-separation
  MOV     R0, #0x00
  MLA     R5, R1, R0, R3

  ; Call to font_getStringWidth to get the pixel width
  LDR     R1, [R4, 0x3D0]       ; Name pointer
  ADD     R0, R4, #0xC          ; Font object
  BLX     @font_getStringWidth

  ; Add it
  ADD     R1, R0, R5

  LDMFD   SP!, {R0,R2,R5,PC}
.endarea


;;----------------------------------------------------------------------------;;
;; Patch for kb_updateCursor function
;;----------------------------------------------------------------------------;;
; # Mode: Variable separation
.org 020C66D4h
.area 0x24
STR     R1, [R4,#0x3D8] ; Set cursor position

LDR     R2, [R4,#0x3EC] ; Load Box Y Position
ADD     R2, R2, #0x11

LDR     R3, [R4,#0x3E8] ; Load Box X Position
ADD     R3, R3, #0x4

BL      @getStringWidthCursor

NOP
LDR     R0, [R4,#0x180] ; Load Pointer OAM Cursor
.endarea


; # Mode: Constante separation between chars
;.org 020C66E0h
;.area 4h
;  MOV     R0, #0xE
;.endarea
