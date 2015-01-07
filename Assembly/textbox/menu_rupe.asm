;;----------------------------------------------------------------------------;;
;;  Move images in rupe (zoom) menu.
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


; Familiar brand image
.thumb
.org 0x0215A810
  MOV r1, #0x42     ; X pos, originally 0x52
  MOV r2, #0x4C     ; Y pos, originally 0x4C

; Familiar type image
.org 0x0215A87C
  MOV r1, #0x5E     ; X pos, originally 0x70
  MOV r2, #0x4B     ; Y pos, originally 0x4B


; Familiar name
.thumb
.org 0x0215B608
  MOV r2, #0x1B     ; Y pos, originally 0x1A

; Original familiar name
@NameDiffX equ -6

.thumb
.org 0x0215B666
  MOV r1, #0xB + @NameDiffX
  MOV R2, #0x49

.org 0x0215B676
  MOV r1, #0xC + @NameDiffX
  MOV R2, #0x49

.org 0x0215B686
  MOV r1, #0xD + @NameDiffX
  MOV R2, #0x49

.org 0x0215B696
  MOV r1, #0xB + @NameDiffX
  MOV R2, #0x4A

.org 0x0215B6A6
  MOV r1, #0xD + @NameDiffX
  MOV R2, #0x4A

.org 0x0215B6B6
  MOV r1, #0xB + @NameDiffX
  MOV R2, #0x4B

.org 0x0215B6C6
  MOV r1, #0xC + @NameDiffX
  MOV R2, #0x4B

.org 0x0215B6D6
  MOV r1, #0xD + @NameDiffX
  MOV R2, #0x4B

.org 0x0215B6EA
  MOV r1, #0xC + @NameDiffX
  MOV R2, #0x4A


;; Increase size for "No equip" string, hardcode the size
; Originally 0xB but reserved 0xC bytes
.org 0x0215B93C
  MOV r1, #0xC

.org 0x0215BA38
  MOV r1, #0xC
