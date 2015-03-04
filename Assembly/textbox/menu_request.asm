;;----------------------------------------------------------------------------;;
;;  Increase textbox size in request menu
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

;; # REQUEST TITLE #
.arm
.org 020C5804h
MOV     r1, #0x49   ; X Position: original 0x50
MOV     r2, #4      ; Y Position: original 0x03


;; # STAMP GIVEN #
.org 020C5950h
MOV     r1, #0xCD + 10  ; X position
