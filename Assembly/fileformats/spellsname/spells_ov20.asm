;;----------------------------------------------------------------------------;;
;;  Increase spell name size - Code in overlay 20 from arm9
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

; In 'zoom' menu
.thumb
.org 0x0215BAF4
  SUB     r0, #0x08
  STR     R0, [SP,#0x18]
  MOV     R0, R7
  NOP
  ;LSLS    R1, R1, #0x18
  ;ASRS    R1, R1, #0x18
