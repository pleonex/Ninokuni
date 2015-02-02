;;----------------------------------------------------------------------------;;
;;  Fix a bug when starting a DLC download.
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

;; They forgot to set a value to 0 (a counter) after calling 'malloc'
;; assuming it will be set by the file downloaded.
;; The problem happens when the download fails, this value is never set to the
;; correct value and it has random data.
;; In the japanese version it won't never fail because of NCGR file from
;; "Wifi_MenuButton.n2d" that by hazard it's the return address of 'malloc'
;; and in that image in that position there is 4 zeros, but it's hazard, luck.

;; Get free space
.arm
.org 0x0209D670
;  MOV     R6, #7
;  MOV     R5, #0x1A8
  ADD     R0, R0, #0x800
  MOV     R1, #7            ; Edited (MOV R1, R6)
  MOV     R2, #0x1A8        ; Edited (MOV R2, R5)
  MOV     R3, R4
  STR     R7, [SP]
  BL      0x20293E4
  ADD     R0, R8, #0x244
  ADD     R0, R0, #0x1400
  BL      0x20F8FE8
  ADD     R0, R8, #0x364
  ADD     R0, R0, #0x1400
  ; FIX: Set to 0 at 0x26D4
  MOV r1, #0
  STR r1, [r0, #3952]

.org 0x0209D6C4
  MOV     R1, #7            ; Edited (MOV R1, R6)
  MOV     R2, #0x1A8        ; Edited (MOV R2, R5)
