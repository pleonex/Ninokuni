;;----------------------------------------------------------------------------;;
;;  Table to encode names
;;  Copyright 2014 Francesco Bozzo (aka Superfranci99)
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

;; Save name string decoding
; R0 -> Current decoded char
; R6 -> Output buffer ptr
; R5 -> Max size
.arm
.org 020F7EBCh
.area 14h
    STRB    R0, [R6], #1        ; Write decoded char
    SUB     R5, R5, #2          ; Decrease the max size
	NOP
	NOP
	NOP
.endarea

;; Save name char decoding
; R0 -> Current encoded char
; R2 -> First encoded char
; R3 -> Input buffer ptr
.arm
.org 020F7E60h
.area 14h
	LDRB    R1, [R3]           ; Get first decoded char
	SUB     R0, R0, R2         ; Get relative index
	ADD     R0, R1, R0         ; Get decoded char (first decoded + index)
	MOV     R0, R0,LSL #24     ; Casting...
	MOV     R0, R0,LSR #24     ; ...
.endarea

.org 02138F68h
.area 6Ch       ; 9 entries
;        1º dec char  1º enc char  Num chars
	dcd  00000001h,   00000001h,   0000007Fh     ; range: 0x00-0x80
	dcd  000000A1h,   00000080h,   0000003Eh     ; range: 0xA1-0xDF
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
	dcd  00000000h,   00000000h,   00000000h
.endarea

;; Original table
;        1º dec char  1º enc char  Num chars
    ;dcd  00004081h,   00000001h,   00000001h        ; From ' ' to ' '   / Space
    ;dcd  00004F82h,   00000002h,   0000000Ah        ; From '０' to '９'  / Numbers
    ;dcd  00009F82h,   0000000Ch,   00000053h        ; From 'ぁ' to 'ん'  / Hiragana
    ;dcd  00004083h,   0000005Fh,   00000057h        ; From 'ァ' to 'ヶ'  / Katakana
    ;dcd  00005B81h,   000000B6h,   00000001h        ; From 'ー' to 'ー'  / Katakana long sound
    ;dcd  00006081h,   000000B7h,   00000001h        ; From '～' to '～'  /
    ;dcd  00004881h,   000000B8h,   00000002h        ; From '？' to '！'  /
    ;dcd  00004181h,   000000BAh,   00000001h        ; From '、' to '、'  / Comma
    ;dcd  00004281h,   000000BBh,   00000001h        ; From '。' to '。'  / Point

; EOF
