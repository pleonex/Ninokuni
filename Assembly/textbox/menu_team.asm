;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in team menu
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

;; Character face icon
.org 0x02130478
  ADD     R2, R2, #0x19 - 1     ; Y position


;; Health state
.org 0x02130A08
  MOV     R2, #0x2A + 1         ; Y position


;; Technique name
.org 0x021311AC
  MOV     R2, #7 - 3            ; Y position

;; Technique magic
.org 0x021311EC
  MOV     R2, #8 - 2            ; Y position


;; Move "Enemies targets" in the skill / magic description
.org 0x021312D0
  MOV     R1, #0x20 - 15        ; X position
  ADD     R2, R2, #0x54 + 4     ; Y position

.org 0x021312B4
  MOV     R2, #0x12 - 4         ; Separation between lines


;; Move "Enemies targets" square 'eria' image
.org 0x021305CC
  ADD     R0, R0, #0x5E + 2     ; Base Y position

.org 0x021305C0
  MOV     R7, #0x12 - 4         ; Separation between lines
