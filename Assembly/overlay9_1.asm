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
.include textbox\battle_cmdMenuBtn.asm
.include textbox\battle_cmdMenuBtn_panels.asm
.include textbox\battle_paramWindow.asm
.include fileformats\spellsname\spells_ov1.asm
.include fileformats\familiarname\familiar_battle.asm
.include fileformats\skillsname\skills_battle.asm
.include fileformats\battle_skills_spells_getName.asm

.close
; EOF ;
