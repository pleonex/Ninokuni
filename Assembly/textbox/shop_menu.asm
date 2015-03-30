;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the shop menu
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

;; Object name in top screen
.arm
.org 0x0207F240
  RSB     R1, R0, #0x80 + 2 ; X pos, centered
.org 0x0207F24C
  MOV     R2, #0x2D         ; Y pos, original 0x02C


;; Object description in top screen
.org 0x0207F32C
  MOV     R1, #0x66 - 6     ; X pos
  MOV     R2, #0x42         ; Y pos


;; Object effect in top screen
.org 0x0207F548
  MOV     R1, #0x68 - 8     ; X pos
  MOV     R2, #0x9C         ; Y pos

;; Slot color in top screen
.arm
.org 0x0207BD08
  MOV     R1, #0x9C    ; X pos, original 0xA2


;; Buy coins number
.arm
.org 0x0207F594
  RSB     R1, R0, #0x49     ; Right aligned, original 0x45

;; Sell coins number
.org 0x0207F5E8
  RSB     R1, R0, #0x49     ; Right aligned, original 0x45
