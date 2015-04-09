;;----------------------------------------------------------------------------;;
;;  Change filter ATTR1 to select the correct files from server by language.
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

; Filter with base64 encoding in ascii. Write it inversed due to low-endiannes.
@langBase64     equ "U1BB"        ; inv(base64("SPA")) = inv("U1BB") = "BB1U"
@wifiStringCopy equ 0x0208A780

.arm

; # Originally, here it frees the string allocated. Since we are not
; allocating, it's hard-coded, we don't need to free. I have try to
; allocate a string using the same function as other parameters like
; MAC, token and so, but I don't know why, the game takes other path
; and ends with an error 31020. I have debug that many many hours
; (7 hours at least) and I haven't found any solution. That would be the
; best way, but this works too if and only if, the game does not use
; filters by itself (like in this case), sice we wouldn't be freeing the mem.
.org 0x0208A468
  NOP

.org 0x0208A7CC
.area 0x198
  STMFD   SP!, {R3-R9,LR}
  LDR     R6, =0x20ABA84
  MOV     R5, R0
  MOV     R4, R1
  STR     R5, [R6,#4]
  LDR     R0, [SP,#0x28]
  STR     R0, [R6]

  @load_filter:
  ADD     r0, PC, (@filter - @load_filter) - 8  ; Filter ATTR1 = base64("SPA")
  ;BL      @wifiStringCopy                      ; [old] Copy ATTR1 filter
  ;STR     r8, [r0]                             ; [old] Write ATTR1
  MOV     r8, #0                                ;
  ;STRB    r8, [r0,#4]                          ; [old] Write null char
  MOV     R9, #0                                ; Null pointers for everyone

  ADD     r7, r6, #0x3C                         ; Saving space, batch writing!
  STMIA   r7, {r0,r8,r9}                        ; ...
  ;STR     R9, [R6,#0x3C]                       ; ATTR1
  ;STR     R9, [R6,#0x40]                       ; ATTR2
  ;STR     R9, [R6,#0x44]                       ; ATTR3

  ADD     r7, r6, #0xC                          ; More saving with batching
  STMIA   r7!, {r8,r9}                          ; ...
  ;STR     R9, [R6,#0xC]
  ;STR     R9, [R6,#0x10]
  STMIA   r7, {r4,r8,r9}                        ; And even more!
  ;STR     R4, [R6,#0x14]
  ;STR     R9, [R6,#0x18]

  LDR     R0, =0x20ABACC
  MOV     R8, R2
  MOV     R7, R3
  ;STR     R9, [R6,#0x1C]

  BL      0x208BDE8
  LDR     R0, =0x20ABB51
  BL      0x208AC84
  MOV     R0, R8
  BL      0x208A780
  STR     R0, [R6,#0x1C]
  CMP     R0, #0
  BEQ     @loc_208A904
  MOV     R0, R7
  BL      0x208A780
  STR     R0, [R6,#0x18]
  CMP     R0, #0
  BEQ     @loc_208A904
  LDR     R8, =0x20ABAB5
  LDR     R1, [SP,#0x20]
  MOV     R0, R8
  MOV     R2, #4
  BL      0x208A54C
  LDR     R7, =0x20ABB38
  STRB    R9, [R8,R0]
  LDR     R1, [SP,#0x24]
  MOV     R0, R7
  MOV     R2, #0x10
  BL      0x208A54C
  STRB    R9, [R7,R0]
  BL      0x208BD30
  CMP     R0, #0
  BEQ     @loc_208A8D0
  BL      0x208BCEC
  CMP     R0, #0
  BEQ     @loc_208A8D0
  MOV     R7, #0x11
  MOV     R0, R5
  MOV     R1, R4
  MOV     R2, R7
  BL      0x209095C
  SUB     R1, R7, #0x12
  CMP     R0, R1
  BEQ     @loc_208A8D0
  LDR     R0, =0x20ABADD
  BL      0x208AAF0
  STR     R0, [R6,#0xC]
  MOV     R0, #1
  STR     R0, [R6,#8]
  LDMFD   SP!, {R3-R9,PC}

  @loc_208A8D0:
  LDR     R4, =0x20ABA84
  LDR     R0, [R4,#0x18]
  LDR     R1, [R4,#0x14]
  BLX     R1
  LDR     R0, [R4,#0x1C]
  LDR     R1, [R4,#0x14]
  BLX     R1
  MOV     R4, #0
  MOV     R1, R4
  MOV     R0, #8
  BL      0x208AA20
  MOV     R0, R4
  LDMFD   SP!, {R3-R9,PC}

  @loc_208A904:
  LDR     R1, =0x20ABA84
  LDR     R0, [R1,#0x18]
  CMP     R0, #0
  BEQ     @loc_208A91C
  LDR     R1, [R1,#0x14]
  BLX     R1

  @loc_208A91C:
  LDR     R1, =0x20ABA84
  LDR     R0, [R1,#0x1C]
  CMP     R0, #0
  BEQ     @loc_208A934
  LDR     R1, [R1,#0x14]
  BLX     R1

  @loc_208A934:
  MOV     R4, #0
  MOV     R1, R4
  MOV     R0, #1
  BL      0x208AA20
  MOV     R0, R4
  LDMFD   SP!, {R3-R9,PC}

  @filter:
  .db @langBase64, 0x00

.pool

.endarea
