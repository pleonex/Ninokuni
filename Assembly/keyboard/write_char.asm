;;----------------------------------------------------------------------------;;
;;  Fix the write char code.
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

.org 020C68ACh
.area 44h
  ; Write char at the end of the buffer
  LDR     R0, [R11,#0x3D8]				; Cursor position
  LDR     R1, [R11,#0x3D0]				; Name pointer
  NOP     ;MOV     R0, R0,LSL#1			; No need to *2 to get index
  STRH    R7, [R1,R0]					; Write char

  ; Check if the cursor is at the end of the buffer to increment it
  LDR     R1, [R11,#0x3D8]				; Cursor position
  LDR     R0, [R11,#0x3D4]				; Current size
  CMP     R1, R0						; If pos >= size ...
  BLT     @@update_cursor    			; ... skip, else if pos <= size

  ; Update current size
  ADD     R0, R0, 1						; Increment szie by 1
  STR     R0, [R11,#0x3D4]				; Write new size

  ; Write null char at the end
  LDR     R2, [R11,#0x3D0]				; Name pointer
  NOP     ;MOV     R1, R0,LSL#1	        ; No need to *2 to get index
  MOV     R0, #0						; Write a null char at the end
  STRH    R0, [R2,R1]                   ; ...

@@update_cursor:
  LDR     R1, [R11,#0x3D8]				; Cursor position
  MOV     R0, R11						; Struct
  ADD     R1, R1, #1					; Increment it and call update_Cursor

.endarea
