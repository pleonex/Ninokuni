;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in equip menu
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

;; Item name
.arm
.org 0x020821B8
  MOV r1, #0x83     ; X pos, originally 0x84


;; Item quantity
.arm
.org 0x02082228
  MOV r1, #0xDB     ; X pos, originally 0xDD


;; Level
.arm
.org 0x2080544
  MOV r1, #0x79 + 2 ; X poss
