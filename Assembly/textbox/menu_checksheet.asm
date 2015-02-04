;;----------------------------------------------------------------------------;;
;;  Align the position of the numbers in the check sheet menu.
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

;; Remove the extra space between chars
.arm
.org 0x02095DFC
  MOV r1, #0        ; Originally 0x3


;; Position of numbers
.arm
.org 0x02095E64
  MOV R8, #0xC1     ; Common constant, used for thrid column number X pos
.org 0x02095E7C
  MOV R6, #0x40     ; Common constant, used for second text line Y pos

;; Player name
.org 0x02095E50
  MOV R1, #0x76     ; X pos, original 0x76
  MOV R2, #0x17     ; Y pos, original 0x17

;; Number of familiar catched
.org 0x02095E6C
  MOV R1, R8        ; X pos, original 0xC1 (r8)
  MOV R3, R7
  MOV R2, #0x2D     ; Y pos, original 0x2E

;; Number of battles
.org 0x02095E84
  MOV r1, #0x82     ; X pos, original 0x63
  MOV r2, r6        ; Y pos, original 0x3F (r6)

;; Battles won
.org 0x02095E98
  MOV r1, #0xB1     ; X pos, original 0x63
  MOV r2, r6        ; Y pos, original 0x3F (r6)

;; Battles lose
.org 0x02095EAC
  MOV r1, #0xE0     ; X pos, original 0xC1 (r8)
  MOV r2, r6        ; Y pos, original 0x3F (r6)

;; Victory ratio
.org 0x02095EC0
  MOV R1, R8        ; X pos, original 0xC1 (r8)
  MOV R2, #0x52     ; Y pos, original 0x52

;; Number of exchanged familiars
.org 0x02095ED0
  MOV R1, R8        ; X pos, original 0xC1 (r8)
  MOV R2, R6        ; Y pos, original 0x3F (r6)

;; Number of familiar classes
.org 0x02095F1C
  ADD r1, r1, #0x46 ; X Table offset, original 0x3D


;; In "register" menu
;; Number of battles
.arm
.org 0x0208E8DC
  MOV r1, #0x71     ; X pos, original 0x57

;; Battles won
.org 0x0208E8F0
  MOV r1, #0xAA     ; X pos, original 0x90

;; Battles lose
.org 0x0208E904
  MOV r1, #0xD9     ; X pos, original 0xBF
