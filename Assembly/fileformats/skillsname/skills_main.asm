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

@OriginalFieldSize equ 0x3C
@LongNameOffset    equ 0x3C
@LongNameSize      equ 0x20
@NewFieldSize      equ @OriginalFieldSize + @LongNameSize


;; Load "SkillParams" file
.arm
.org 0x0210C9A0
  MOV r0, @NewFieldSize

.org 0x0210C9C4
  MOV r7, @NewFieldSize


;; We don't have to edit the "skills_getPtr" function since, when a new skill
;; is load, its pointers is stored in a table.


;; Prints skill name in the top screen after select it
.arm
.org 0x0213108C
  ADD r11, r0, @LongNameOffset


;; Familiar skill name in the top screen list in "member" menu
.arm
.org 0x02130DD8
  ADD r3, r0, @LongNameOffset
