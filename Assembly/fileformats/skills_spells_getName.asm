;;----------------------------------------------------------------------------;;
;;  Fix the function that gets skills or magic names with new fields.
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


;; ARGUMENTS:
;;  R0: Struct pointer with spell / skill info
;;  R1: Spell / Skill ID
;; RETURNS:
;;  R0: Pointer to the name of the spell / skill
.thumb
.org 0x02121008
.area 0x02121048-.

  ; "Save" registers
  PUSH    {R4-R6,LR}
  MOV     R5, R0
  MOV     R6, R1

  ; Get spell / skill ID
  LSL     R1, R6, #1
  ADD     R1, R5, R1
  LDR     R4, =0x4E23C+0x8
  LDRSH   R1, [R1,R4]

  ; Check if it's spell or skill
  SUB     R4, #8
  LDR     R4, [R5,R4]
  CMP     R4, #0
  BEQ     @@isSkill
  CMP     R4, #1
  BEQ     @@isSpell
  MOV     R0, #0
  POP     {R4-R6,PC}

@@isSkill:
  BL      @skill_getPtrInit
  BLX     @skills_getPtr_wr
  ADD     R0, @SkillLongNameOffset  ; Hack
  POP     {R4-R6,PC}

@@isSpell:
  BL      @magic_getPtrInit
  BLX     @magic_getPtr_wr
  SUB     R0, @SpellExtraNameSize   ; Hack
  POP     {R4-R6,PC}

.pool

.endarea
