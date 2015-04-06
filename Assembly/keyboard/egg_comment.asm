;;----------------------------------------------------------------------------;;
;;  Update the cursor coordinates for the egg comments.
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

@getStringWidth equ 0x020CBE14

.arm

;; Calculate the X position of the cursor in this case
;; It was multiplying the current size by 0x0C
.org 0x0208C5E8
  MOV     R2, R3,ASR#3
  MOV     r0, r7
  LDR     r1, [r7,#0x3D8]
  ADD     r7, R3, R2,LSR#28
  MOV     r2, #0
  BL      @getStringWidth
  MOV     r12, r1

  ADD     R0, R4, #0x3B000
  MOV     R2, R7,ASR#4
