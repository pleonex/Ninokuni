;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the casino menus
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


; Slot color when exchanging
.arm
;.org 0x0207BCF0
;  MOV     R1, #0x8D     ; X pos, original 0xA2

; Object name
.org 0x0207C608
  RSB     R1, R0, #0x88 ; Text is centered, original 0x80
  ADD     R0, R4, #0x44
  MOV     R2, #0x2D     ; Y pos, original 0x2C

; Needed casino coins top screen
.org 0x0207C700
  RSB     R1, R0, #0x54 ; Aligned to the right, orignial 0x4C

; Needed casino coins bottom screen
.org 0x0207C72C
  RSB     R1, R0, #0x5B ; Align to the right, original 0x4D
  MOV     R2, #5        ; Y pos, original 0x06

; Item description
.org 0x0207C6B0
  MOV     R1, #0x60     ; X pos, original 0x6D
  MOV     R2, #0x42     ; Y pos, original 0x42
