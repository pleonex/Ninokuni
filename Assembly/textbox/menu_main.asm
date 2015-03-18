;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the main manu
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

.thumb
;; Main team characters name
.org 0x020D9384
  ADD r2, #0x16 - 3     ; X position, centered

;; Main team character level
.org 0x020D9440
  ADD r4, #0x38 + 3     ; X position

;; Main team character level image
.org 0x020D93CC
  ADD r1, #0x2C + 3     ; X position
  MOV R2, #0x29         ; Y position

;; Characters name in the team
;.org 0x020D96E0
;  ADD r1, #0x14        ; X position, centered
