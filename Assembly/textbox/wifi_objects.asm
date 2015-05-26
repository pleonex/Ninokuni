;;----------------------------------------------------------------------------;;
;;  Fix the position of the textbox in the DLC.
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

; # Recipes item number
.org 0x020A0270
  MOV     R1, #0x28             ; X pos
  ADD     R0, R4, #0x68
  MOV     R2, #0x28 - 2         ; Y pos, originally R1


; # Recipes needed objects quantity
.org 0x020A03B8
  MOV     R1, #0xB5 + 6         ; X pos


; # Slot color
.org 0x020A2F50
  MOV     R1, #162 - 16;        ; X pos
