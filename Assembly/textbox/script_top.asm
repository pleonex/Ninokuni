;;----------------------------------------------------------------------------;;
;;  Align the position and increase size of the textbox in map name and scenario
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

;; # MAP NAME #
.arm
.org 020C3174h
MOV     R0, #0x10       ; Width:  Value * 8 [original #0xC]
STR     R0, [SP]
MOV     R0, #0x2        ; Height: Value * 8 [original #0x2]
STR     R0, [SP,#4]

.org 020C31A8h
MOV     R0, #0x89000	  ; X position: Value >> 12 [original #0x98000]
STR     R0, [R1,#0x14]
MOV     R0, #0x4000		  ; Y position: Value >> 12 [original #0x4000]
STR     R0, [R1,#0x18]

.org 020C4238h
RSB     R1, R1, #0x38     ; Textbox width / 2 [original #0x30]

;; # SCENARIO #
.org 020C3104h
MOV     R0, #0x4000       ; X position: Value >> 12 [original #0x4000]
STR     R0, [R1,#0x14]
MOV     R0, #0xAB000      ; Y position: Value >> 12 [original #0xAA000]
STR     R0, [R1,#0x18]
