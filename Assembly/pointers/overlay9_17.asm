;;----------------------------------------------------------------------------;;
;;  Pointer hack (increase text size) in overlay 14 for arm9
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

;; Amarilla
Amarilla	equ 0x020D0A00 + 0x6E644
Nymphae  	equ 0x020D0A00 + 0x6E63C

.org 0x020D0A00 + 0x70EEC
.word Amarilla

.org 0x020D0A00 + 0x7106C
.word Nymphae

;; El menu principal
Elmenuprincipal equ 0x020D0A00 + 0x6EBDC
Obtienessellos  equ 0x020D0A00 + 0x6EA74

.org 0x020D0A00 + 0x70E24
.word Elmenuprincipal

.org 0x020D0A00 + 0x6EBDC ; Write the bytes before the sentece
.halfword 0x0008
.halfword 0x0096
.halfword 0x0000
.byte 0x01

.org 0x020D0A00 + 0x70F1C
.word Obtienessellos

;; Las piedras runicas
Laspiedrasrunicas equ 0x020D0A00 + 0x6EBF8
Haaumentado       equ 0x020D0A00 + 0x6EB34

.org 0x020D0A00 + 0x70E5C
.word Laspiedrasrunicas

.org 0x020D0A00 + 0x6EBF8 ; Write the bytes before the sentece
.halfword 0x0016
.halfword 0x00A3
.halfword 0x0000
.byte 0x01

.org 0x020D0A00 + 0x70DC8
.word Haaumentado

;; Las perlas de la felicidad
Lasperlasdelafelicidad equ 0x020D0A00 + 0x6F1C8
Parecetenerhambre      equ 0x020D0A00 + 0x6F148

.org 0x020D0A00 + 0x70E78
.word Lasperlasdelafelicidad

.org 0x020D0A00 + 0x6F1C8 ; Write the bytes before the sentece
.halfword 0x001D
.halfword 0x00BE
.halfword 0x0000
.byte 0x01

.org 0x020D0A00 + 0x70D8C
.word Parecetenerhambre
