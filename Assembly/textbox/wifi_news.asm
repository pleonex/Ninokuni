;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox magic news menu.
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

; # Title news (top screen)
.org 0x0209F574
  RSB     R1, R0, #0x80 - 1     ; X pos (centered)
  ADD     R0, R9, #0x68
  MOV     R2, #0x21             ; Y pos


; # Body news
.org 0x0209F5A8
  MOV     R1, #0x3C - 36    ; X pos
  MOV     R2, #0x40         ; Y pos


; # Title date
.org 0x0209F5F8
  MOV     R7, #0xA          ; Y pos for the three numbers

; Year
.org 0x0209F604
  MOV     R1, #0xCD + 5      ; X pos

; Month
.org 0x0209F62C
  MOV     R1, #0xE1 + 5     ; X pos

; Day
.org 0x0209F658
  MOV     R1, #0xED + 5     ; X pos

; # Date again but just after download
; Year
.org 0x0209EEAC
  MOV     R1, #0xCD + 5     ; X pos

; Month
.org 0x0209EED4
  MOV     R1, #0xE1 + 5     ; X pos

; Day
.org 0x0209EF00
  MOV     R1, #0xED + 5     ; X pos 


; # Title news (bottom screen)
.org 0x0209F710
  MOV     R2, #0x16         ; Y separation

.org 0x0209F728
  MOV     R1, #0x35         ; X pos
  ADD     R2, R2, #0x1C     ; Y base
