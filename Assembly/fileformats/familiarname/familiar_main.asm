;;----------------------------------------------------------------------------;;
;;  Create a new "long name" field.
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

@OriginalFieldSize equ 0xB4
@LongNameSize      equ 0x20
@NewFieldSize      equ @OriginalFieldSize + @LongNameSize


;; ImagenParam get familiar pointer
.thumb
.org 0x021028E8
  MOV    R0, @NewFieldSize


;; ImagenParam decode
.thumb
.org 0x0210461A
  CMP     R2, @NewFieldSize


;; ImagenParam load file
.thumb
.org 0x021022D6
  MOV    R4, @NewFieldSize

.org 0x021022F4
  MOV    R6, @NewFieldSize

.org 0x0210231A
  MOV    R1, @NewFieldSize

.org 0x02102332
  MOV    R0, @NewFieldSize

.org 0x0210233E
  MOV    R2, @NewFieldSize


; Function that copy familiar params like name (with hardcode size): 0x02107E54
;   - It does not need changes since I read it manually for the top screen
;   - It was not possible to increase size since there are data after the name
;   - Used for battles


; Function that copy the short name from the file with hardcode size: 0x02104282
;   - I don't know its meaning since it only copy the first 0x9 chars...?
