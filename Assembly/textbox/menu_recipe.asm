;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the recipe menu
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


;; Item name to craft
.arm
.org 0x020A2470
  MOV r6, #0x45     ; X pos, originally text is center in the screen

.org 0x020A2484
  MOV r2, #7        ; Y pos, original 0x05


;; Item name number to craft
.arm
.org 0x020A24F4
  MOV r2, 0x9       ; Y pos, original R9 (0xA)


;; slot_color image
.arm
.org 0x020A1868
  MOV r1, #0x42     ; X pos, original 0x55


;; Item description to craft
;; DISABLED: Too many space left and description must be 3 lines because they
;; are the same text as the items menu.
;.arm
;.org 0x020A26E4
;  MOV r1, #0x61     ; X pos, original 0x6D
