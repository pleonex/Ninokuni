;;----------------------------------------------------------------------------;;
;;  Use "long name" field in battles
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

@LongNameOffset    equ 0x3C


;; Select skill textbox
.thumb
.org 0x0207E06E
  MOV     r1, r5                        ; Just to get some space
  LDR     R0, [SP, 0xE8 - 0xD0]         ; ""
  BLX     0x0209832C                    ; ""
  MOV     R1, R0                        ; ""
  ADD     r1, @LongNameOffset


;; Small green box in the bottom screen after selecting skill and waiting to
;; select target enemy.
.arm
.org 0x020A075C
.area 0x020A0794-.
  SUBEQ   r2, r0, @LongNameOffset   ; If it's a skill name, use short field
  MOVNE   r2, r0                    ; If it's a spell name, just use it

  ; Code below: Just to get some space
  LDR     R1, =0x20C03E8
  ADD     R0, SP, 0
  BL      0x0202159C ; string copy
  MOV     R0, R6
  BLX     0x209047C
  AND     r1, r0, #1
  MOV     R0, R5

@jump1:
  BL      0x209FA1C
  B       0x20A0818

  NOP
  NOP
  NOP
.endarea

.org 0x020A07FC
  B       @jump1

.org 0x020A0838
.area 4
  .pool
.endarea
