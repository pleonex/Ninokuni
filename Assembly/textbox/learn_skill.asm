;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the select skill menu.
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

;; Enemies strings
.org 0x020B03D4
  MOV r1, #0xBB + 3     ; X position
  ADD r2, r2, #0x66 + 7 ; Y position

.org 0x020B03C8
  ADD r2, r11, r9,LSL#2 ; Y separation (R9 is the index) (ori: r9+r9<<4)


;; Eria images
.org 0x020AFC24
  MOV r1, #0xE9         ; X position
  ADD r2, r2, #0x70 + 4 ; Y position

.org 0x020AFBCC
  MOV r4, #0x12 - 6     ; Y separation
