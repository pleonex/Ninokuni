;;----------------------------------------------------------------------------;;
;;  Fix the length of the player names (PlayerParams).
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

;; This is used to calculate the position of the small arrows (up or down)
;; when some stats is increased or decreased. For familiars it calculates
;; automatically. The X position of the arrow will be
;; X_arrow = X_name + K*10 + 5
;; Where K is the following constants for each player.

.arm
.org 0x02108B84
; Oliver
  MOV     R0, #3
  BX      LR

; Maru
  MOV     R0, #3
  BX      LR

; Jairo
  MOV     R0, #3
  BX      LR

; Shizuku
  MOV     R0, #4
  BX      LR
