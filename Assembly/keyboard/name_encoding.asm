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

;; Save name encoding routing
; R0 -> current decoded char
; R6 -> Output buffer ptr
; R5 -> Max size

.arm
.org 020F7EBCh
.area 14h
    STRB    R0, [R6], #1
    SUB     R5, R5, #2
	NOP
	NOP
	NOP
.endarea

.arm
.org 020F7E60h
.area 14h
	LDRB    R1, [R3]
	SUB     R0, R0, R2
	ADD     R0, R1, R0
	MOV     R0, R0,LSL #24
	MOV     R0, R0,LSR #24
.endarea

.org 02138F68h
.area 6Ch       ; 9 entries
;        1º dec char  1º enc char  Num chars
    dcd  00000020h,   00000001h,   00000001h        ; From ' ' to ' '  / Space
    dcd  00000030h,   00000002h,   0000000Ah        ; From '0' to '9'  / Numbers
    dcd  00000041h,   0000000Ch,   0000003Ah        ; From 'A' to 'z'  / Chars and Punctuation
    dcd  00000021h,   00000046h,   0000000Fh        ; From '!' to '/'  / Punctuation
    dcd  0000003Ah,   00000055h,   00000007h        ; From ':' to '@'  / Punctuation
    dcd  0000007Bh,   0000005Ch,   00000004h        ; From '{' to '~'  / Punctuation
    dcd  00004881h,   00000060h,   00000002h        ; From '¿' to '¡'  / Spanish char
    dcd  0000DD81h,   00000062h,   00000002h        ; From 'ü' to 'Ü'  / Spanish char
    dcd  00006082h,   00000064h,   00000036h        ; From 'Á' to 'ú'  / Spanish char
.endarea

; EOF
