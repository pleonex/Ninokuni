;;----------------------------------------------------------------------------;;
;;  Align the position of the numbers in the info menu of multi exchange.
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
;; Money
.org 0x02080140
  RSB r1, r0, #0xDA+20       ; Right aligned
  STR R9, [SP]
  ADD R0, R7, #0xA0
  MOV R2, #0x51+1           ; Y pos

;; Last familiar catched
.org 0x0208017C
  RSB r1, r0, #0xDA+20      ; Right aligned, originally 0xDA
  STR R9, [SP]
  ADD R0, R7, #0xA0
  MOV R2, #0x61+1           ; Y pos

;; Battles won
.org 0x020801B8
  MOV R8, #0x73+1           ; Line Y pos
  RSB r1, r0, #0xA4+18      ; Right aligned, originally 0xA4

;; Battles lose
.org 0x020801F8
  RSB r1, r0, #0xDC+18      ; Right aligned, originally 0xDC

;; Exchanged familiar
.org 0x02080234
  RSB r1, r0, #0xDA+20      ; Right aligned, originally 0xDA
  STR R9, [SP]
  ADD R0, R7, #0xA0
  MOV R2, #0x83+1           ; Y pos

;; Number of players
.org 0x02080270
  RSB r1, r0, #0xDA+20      ; Right aligned, originally 0xDA
  MOV R3, R4
  ADD R0, R7, #0xA0
  MOV R2, #0x93+1           ; Y pos
