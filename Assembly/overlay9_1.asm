;;----------------------------------------------------------------------------;;
;;  Hacks for overlay 1 from arm9
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
.nds
.open overlay9_1.bin, 02079F80h

.relativeinclude on
.erroronwarning on

.include textbox\battle.asm
.include textures\paramWindow_superSkill.asm
.include textures\cmdMenuBtn_default.asm
.include textures\cmdMenuBtn.asm
.include textures\paramWindow_attackLabel.asm
.include textures\battleIcon_status.asm
.include textures\battleBrand.asm
.include textures\paramWindow_tabs.asm
.include textures\systemImage_smallArrows.asm
.include textures\number_small_stats.asm
.include textures\paramWindow_box.asm
.include textures\actInfo.asm
.include textures\paramWindow_changedTime.asm
.include textures\number_small_changedTime.asm
.include fileformats\spellsname\spells_ov1.asm
.include fileformats\familiarname\familiar_battle.asm
.include fileformats\skillsname\skills_battle.asm
.include fileformats\battle_skills_spells_getName.asm

.close
; EOF ;
