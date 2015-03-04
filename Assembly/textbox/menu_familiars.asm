;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in familiars menu
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

.arm

;; # FAMILIAR DESCRIPTION #
.org 020B6770h
MOV     r4, #0x9A       ; Y Position: original 0x97
.org 020B677Ch
MOV     r1, #8          ; X Position: original 0x08

;; # FAMILIAR OBJECTS #
.org 020B6604h
MOV     r1, #0x73       ; X Position: Original 0x74
ADD     r2, r2, #0x6B   ; Y Position: Original 0x6B

;; # MONEY GIVEN #
.org 020B671Ch
MOV R1, #0xCD + 9       ; X Position

.org 020B69D8h
MOV R1, #0xCD + 9       ; X position when no familiar is select (------)
