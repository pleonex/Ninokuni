;;----------------------------------------------------------------------------;;
;;  Align the char keys
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

; Alphabet keys
.org 0x020C6568
  NOP  ;MOV     R2, R0,LSL#8        ; No need to swap bytes for the char
  ADD     R1, R1, #0x16 + 3         ; X offset
  MLA     R1, R8, R4, R1
  LDR     R3, [R10,#0x3F4]
  NOP  ;ORR     R0, R2, R0,ASR#8    ; More swaping

; Interrogation and exclamations keys
.org 0x020C6604
  ADD     R1, R1, #0xD4 + 3         ; X offset

.org 0x020C65F0
  MOV     R0, R1  ;,LSL#8           ; No need to swap bytes for the char
  NOP  ;ORR     R0, R0, R1,ASR#8    ; More swaping

; Number keys
.org 0x020C6644
  ADD     R0, R0, #0x16 + 3         ; X offset

.org 0x020C6650
  MOV     R0, R2  ;,LSL#8           ; No need to swap bytes for the char
  NOP  ; ORR     R0, R0, R2,ASR#8   ; More swaping
