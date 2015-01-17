;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in moya menu
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

.definelabel NO_PADDING,1

;; Recipe summary
.arm
.org 0x0207C0E4
  MOV r2, #0x4          ; Y pos, original R5 (2)
  ADD R0, R10, #0xA4
  MOV r1, #0x9C         ; X pos, original 0x8F

.org 0x0207C08C
  MOV r2, #2            ; Digits of first number in floor, original R7 (3)


.if NO_PADDING
;; Without number padding
.org 0x207C070 ; 18 instr to override
.area 0x48
  ADD R0, R10, #0x3E000
  LDR R0, [R0,#0x214]
  ADD r4, r0, #1
  ADD r6, r0, #5

  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
.endarea
.endif
