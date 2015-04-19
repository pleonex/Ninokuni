;;----------------------------------------------------------------------------;;
;;  Align the position of the numbers in slot machines of casino.
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


; # Position of total round number and (shared) won round number
.arm
.org 0x0207E9F4
  MOV     R1, #0x40 + 20        ; X pos
  MOV     R2, #0xAD             ; Y pos

; # Separation between chars
.org 0x0207EA20
  MOV     R1, #1


; # Relative position for won round number
.arm
.org 0x0207D444
  MOV     R1, #0x4E + 1

; # Format strings
.org 0x0207D470
  .word 0x2092DE8               ; "%03d" (total rounds >= 999)
  .word 0x2092DF0 - 8           ; "%3d"  (total rounds < 999)
  .word 0x2092DF4               ; "%03d" (won rounds >= 999)
  .word 0x2092DFC - 8           ; "%3d"  (won rounds < 999)
