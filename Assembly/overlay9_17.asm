;;----------------------------------------------------------------------------;;
;;  Hacks for overlay 17 for arm9
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
.open overlay9_17.bin, 020D0A00h

.relativeinclude on
.erroronwarning on

.include fileformats\subtitles.asm
.include fileformats\spellsname\spells_ov17.asm
.include fileformats\familiarname\familiar_main.asm
.include fileformats\skillsname\skills_main.asm
.include fileformats\skillsname\skills_train.asm
.include fileformats\skills_spells_getName.asm
.include textbox\cutscenes.asm
.include textbox\script_dialog.asm
.include textbox\lilli_motel.asm
.include textbox\menu_items_effect.asm
.include textbox\menu_hero.asm
.include textbox\menu_team.asm
.include textbox\casino_dialog.asm
.include textbox\menu_main.asm
.include textbox\save_time_limit.asm
.include textbox\dialog_tutorial.asm
.include textures\playerNames.asm
.include keyboard\name_encoding.asm
.include keyboard\textbox_longNames.asm
.include pointers\overlay9_17.asm
.include font\space_objects_title.asm
;.include font\int2str_ov17.asm

.close
; EOF ;
