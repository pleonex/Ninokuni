;;----------------------------------------------------------------------------;;
;;  Table to encode names
;;  Copyright 2014 Benito Palacios (aka pleonex)
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
.org 020F7EBCh
.arm
.area 14h
    STRB    R0, [R6],#1
    TST     r3, #0x80
    MOVNE   r0, r0,ASR#8
    STRNEB  r0, [R6],#1
    ;ADD    R6, R6, #2
    SUB     R5, R5, #2
.endarea

;RAM:020F7E60 LDRH    R1, [R3]
;RAM:020F7E64 SUB     R0, R0, R2                      ; Get relative index
;RAM:020F7E68 ADD     R0, R1, R0,LSL#8
;RAM:020F7E6C MOV     R0, R0,LSL#16
;RAM:020F7E70 MOV     R0, R0,LSR#16

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
