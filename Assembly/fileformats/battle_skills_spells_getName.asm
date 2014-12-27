;;----------------------------------------------------------------------------;;
;;  Fix the function that gets skills or magic names with new fields in battles.
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

@SkillLongNameOffset equ 0x3C
@SpellExtraNameSize  equ 0x8
@skill_getPtrInit    equ 0x0210DC9C
@magic_getPtrInit    equ 0x0210DCC4
@skills_getPtr_wr    equ 0x0210CBD4
@magic_getPtr_wr     equ 0x021062D0


.thumb
.org 0x02086308
.area 0x02086380-.

  PUSH    {R4,r5,LR}
  MOV     R2, #0
  MVN     R2, R2
  MOV     R4, R0
  CMP     R1, R2
  BNE     @@switch
  BL      0x2087320
  ADD     R1, R0, #0

@@switch:
  CMP     R1, #5
  BHI     @@error
  ADD     r5, R1, R1
  ADD     r5, PC
  LDRH    r5, [r5,#2]
  ADD     PC, R5

@@table:
  .halfword @@error -   @@table - 2  ; case0 / default: error
  .halfword @@case1 -   @@table - 2  ; case1: attack button
  .halfword @@case2 -   @@table - 2  ; case2
  .halfword @@isSkill - @@table - 2  ; case3: isSkill
  .halfword @@isMagic - @@table - 2  ; case4: isMagic
  .halfword @@case5 -   @@table - 2  ; case5

@@case1:
  LDR     R0, =0x206BF44
  LDR     R0, [R0,#4]
  POP     {R4,r5,PC}

@@case2:
  LDR     R0, =0x206BF44
  LDR     R0, [R0,#0x14]
  POP     {R4,r5,PC}

@@isSkill:
  BL      @skill_getPtrInit
  LDR     R1, =0x2BE
  LDRSH   R1, [R4,R1]
  BLX     @skills_getPtr_wr
  ADD     r0, @SkillLongNameOffset
  CMP     r5, (@@isSkill - @@table - 2)
  POP     {R4,r5,PC}

@@isMagic:
  BL      @magic_getPtrInit
  LDR     R1, =0x2BE
  LDRSH   R1, [R4,R1]
  BLX     @magic_getPtr_wr
  SUB     r0, @SpellExtraNameSize
  CMP     r5, (@@isSkill - @@table - 2)
  POP     {R4,r5,PC}

@@case5:
  BL      0x0210DCAC
  MOV     R1, 0xB
  LSL     R1, 0x6
  LDR     R2, [R0]
  LDRSH   R1, [R4,R1]
  LDR     R2, [R2,#0xC]
  BLX     R2
  POP     {R4,r5,PC}

@@error:
  MOV     R0, #0
  POP     {R4,r5,PC}

.pool
.endarea
