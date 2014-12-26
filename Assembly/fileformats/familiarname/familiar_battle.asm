;;----------------------------------------------------------------------------;;
;;  Use the new "long name" field.
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

@FamiliarGetStructPtr   equ 0x0210DCA4
@FamiliarGetEntryPtr    equ 0x021028DC
@LongNameOffset         equ 0xB4


; Function that prints the text in "select target enemy" texboxes: 0x0207DBD0
;   - It does not need changes since I read it manually for the top screen


; Function that copy at some point the short name with hardcode size: 0x02083B74
;   - It does not need changes since I read it manually for the top screen
;   - It was not possible to increase size since there are data after the name


; Load name pointer for the enemy name in the top screen
; Instead of uses the internal copy short name, read again from the file.
.thumb
.org 0x0207D728
.area 0x16
  BL   @FamiliarGetStructPtr ; Get the ptr to the struct for FamiliarGetEntryPtr
  ADD  r6, 0xFF              ; Familiar ID is in r6+0x228
  ADD  r6, 0xFF              ; 0x228 = 0xFF + 0xFF + 0x3C
  LDRH r1, [r6, 0x3C]        ; Get the ID of the current familiar
  BL   @FamiliarGetEntryPtr  ; Get the pointer to the ImagenParam entry
  ADD  r0, @LongNameOffset   ; Go to long name
  STR  r0, [sp, #0x4]        ; Store to print it
  MOV  r0, #0xB              ; Original code: written because I have sorted them
  STR  r0, [sp,#0x0]         ; ""
.endarea
