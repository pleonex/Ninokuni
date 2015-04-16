;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in battles
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

;; # OBJECT AND ATTACK NAMES #
.thumb
.org 0207E168h
MOV     r1, #9
LSL     r1, r1, #0xC

;; # SPELL | SP ATTACKS STRING #
.thumb
.org 020809C4h
MOV     r0, #4  ; Original 5
LSL     r0, r0, #0xF

;; # CHAR NAME AT TOP SCREEN #
.thumb
.org 020809D4h
MOV     r0, #4  ; Original 5
LSL     r0, r0, #0xF
