;;----------------------------------------------------------------------------;;
;;  Fix the 'Integer to String' to work with ASCII chars
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

;; Subroutine1
.thumb
.org 0x020D5F1A
  LDRH    r2, [r0]
  MOV     r0, r1
  ADD     R1, R2, R0
  MOV     R0, R4
  STRB    r1, [r6, r0]

.org 0x020D5F3A
  MOV     r0, r4
  STRB    r7, [r6, r0]

.org 0x020D5F46
  NOP

;; Subroutine2
.thumb
.org 0x020D5EDC
  LDRH    r2, [r0]
  MOV     r0, r1
  ADD     R1, R2, R0
  MOV     R0, R4
  STRB    r1, [r7, r0]

.org 0x020D5EF6
  MOV     r0, r6
  STRB    r1, [r7, r0]

;; Base char
.org 0x0213EFD4
  .halfword 0x0030
