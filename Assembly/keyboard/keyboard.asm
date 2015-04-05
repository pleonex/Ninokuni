;;----------------------------------------------------------------------------;;
;;  Keyboard hack to support 1-byte chars
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
;;      New functions
;;----------------------------------------------------------------------------;;

.org 020CC06Eh+2Ah
.arm
.area 38h
get_postIndex:
; Get the index of an array from the number of chars
;  before it.
;
; ARGUMENTS:
;	R0 -> Array pointer.
;	R1 -> Number of characters before it.
; RETURN:
;	R2 -> Char index.
;	R3 -> Test wih last char.

	STMFD   SP!, {R3,R4,LR}
  MOV		  r2, #0x00
	MOV		  r4, #0x00						; Chars read

	CMP		  r1, #0x00						; No char to search -> return
	LDMEQFD SP!, {R3,R4,PC}

	@@loop:
	LDRB  	r3, [r0, r2]					; Read a char

	TST 	  r3, #0x80						; If it's a jap char, increment the index by 2
	ADDEQ	  r2, r2, #0x01
	ADDNE	  r2, r2, #0x02

	ADD		  r4, r4, #0x01
	CMP		  r1, r4
	BNE		  @@loop

	LDMFD   SP!, {R3,R4,PC}
.endarea

.org 020CC00Ah+2Ah
.area 38h
get_preIndex:
; Gets the index of the last char.
; There MUST be char written.
;
; ARGUMENTS:
;   R0: Array pointer
; RETURNS:
;   R1: Index of last char

  STMFD   SP!, {R2,R3,LR}

  MOV     R1, #0x00
	LDRB    R2, [R0, R1]

  @@loop:
  TST     R2, #0x80
  ADDEQ   R3, R1, #0x01
  ADDNE   R3, R1, #0x02

  LDRB    R2, [R0, R3]
  CMP     R2, #0x00
  LDMEQFD SP!, {R2,R3,PC}

  MOVNE   R1, R3

  B       @@loop

.endarea

.org 020CBFA6h+2Ah
.area 3Ah

read_char:
; Read a one or two bytes char from an array.
;
; ARGUMENTS:
;   R0/R1: Array pointer.
;   R0/R1: Char index.
; RETURNS:
;   R0: Char

  ADD     R1, R0, R1
  LDRB    R0, [R1]
  TST     R0, #080h
  LDRNEB  R3, [R1,#0x1]
  EORNE   R0, R3, LSL#0x8

  BX      LR

read_charIndex:
; Read a two bytes char from an array.
; It gets the index of the char.
;
; ARGUMENTS:
;	R0 -> Array pointer.
;	R1 -> Number of characters before it.
; RETURNS:

  STMFD   SP!, {LR}

  BL      get_preIndex
  BL      read_char
  MOVEQ   R0, R0, LSL#0x8

  LDMFD   SP!, {PC}

read_charSP:
; It will read a char taking the arguments from the stack.
; continues in read_temp
;
; ARGUMENTS
;  SP: Name ptr
;  SP: Char index
; RETURNS
;  R0: Char read

  LDR     R0, [SP,#0x04] 	; Name offset
  LDR     R1, [SP,#0x00]  ; Char index (already fixed)
	B       read_char

.endarea

.org 020CBE78h+38h
.area 2Ch

write_char:
; It will write the char in R3 into a vector
;
; ARGUMENTS:
;  R0: Name pointer
;  R1: Fixed char index
;  R3: Char to write

	; Check if it's a double-byte char or not
	TST     R3, #0FFh
		; Double-byte, write the first byte
		STRNEB  R3, [R0,R1]
		ADDNE	  R1, R1, #0x01
		; Else, write the second byte (in a single-byte the first one is 00h)
		MOV		  R3, R3,LSR#0x08
		STRB	  R3, [R0, R1]
		ADD		  R1, R1, #0x01

    ; Add end-null char
	MOVGE   R3, #0							; Write the end-null-char
	STRGEB  R3, [R0,R1]

	BX  LR

.endarea

.org 020CBEDCh+38h
.area 2Ch
shiftL_vector:
; Shift a vector to the left (it will overwrite).
;
; ARGUMENTS:
;   R0: Vector pointer
;   R1: End index
;   R2: Start index

  STMFD   SP!, {R3,LR}

  @@loop:
  ADD     R12, R0, R2                     ; Char pointer to remove
  LDRB    R3, [R12,#1]                    ; Read the next char
  ADD     R2, R2, #1                      ; Increment index
  STRB    R3, [R12]                       ; Store in the actual pos.
  CMP     R2, R1                          ; Check with the util
  BLT     @@loop                          ; |

  LDMFD   SP!, {R3,PC}

.endarea

.org 020CBE14h
.area 28h
update_util:
; Update the util comparing two chars.
;
; ARGUMENTS:
;   R0: New char
;   R1: Old char
;   R11: Table

  MOVEQ   R0, R0, LSL#0x8     ; <-- DANGER!

  LDR     R2, [R11, #0x3D4]

  TST     R0, #0xFF
  ADDEQ   R2, R2, #0x1
  ADDNE   R2, R2, #0x2

  TST     R1, #0xFF
  SUBEQ   R2, R2, #0x1
  SUBNE   R2, R2, #0x2

  STR     R2, [R11, #0x3D4]
  BX      LR
.endarea



;;----------------------------------------------------------------------------;;
;; ## KEYBOARD DELETE BUTTON ##
;;----------------------------------------------------------------------------;;
UpdateCursor   equ  020C66B0h

.org 020C6400h
.area 64h
  STMFD   SP!, {R3,R5,LR}
  LDR     R5, [R0,#0x3D4]                 ; Check there are chars written
  CMP     R5, #0                          ; |
  LDMLEFD SP!, {R3,R5,PC}                 ; | Quit

  MOV     R3, R0
  LDR     R0, [R3,#0x3D0]                 ; Pointer

  ; Substract index
  BL      get_preIndex
  MOV     R5, R1
  STR     R5, [R3,#0x3D4]

  ; Get index
  LDR     R1, [R3,#0x3D8]
  BL      get_postIndex

  ; Compare index with util if it's lower (need to shift the vector)
  CMP     R2, R5
  BGE     @@set_nullchar

  ; shift vector
  MOV     R1, R5
  BL      shiftL_vector

  @@set_nullchar:
  MOV     R2, #0                          ; Set the null char to the last char
  STRB    R2, [R0,R5]                     ; |

  LDR     R0, [R3,#0x3CC]                 ; Get max chars
  SUB     R0, R0, #0x1                    ; |
  LDR     R1, [R3,#0x3D8]                 ; Get index
  CMP     R1, R0
  SUBLT   R1, R1, #0x1
  MOV     R0, R3
  BL      UpdateCursor
  LDMFD   SP!, {R3,R5,PC}
.endarea

;;----------------------------------------------------------------------------;;
;; ## SUPPORT 1-BYTE ##
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;;      Disable left buttons (nigori/accent)
;;----------------------------------------------------------------------------;;

.org 020C6810h
.area 4h
  BEQ     020C69F4h                       ; Jump to the end
.endarea

;;----------------------------------------------------------------------------;;
;;      Fix add new char.
;;----------------------------------------------------------------------------;;
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
