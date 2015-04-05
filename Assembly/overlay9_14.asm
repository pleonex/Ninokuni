;;----------------------------------------------------------------------------;;
;;  Hacks for overlay 14 for arm9
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
.open overlay9_14.bin, 020C18E0h

.relativeinclude on
.erroronwarning on

.include textbox\script_top.asm
.include keyboard\keys.asm          ; MUST be first since it's overwritten later
.include keyboard\keyboard.asm
.include keyboard\cursor.asm
.include keyboard\font_space.asm
.include keyboard\print_keys.asm
.include pointers\overlay9_14.asm
.include textbox\menu_request.asm
.include password\alphabet.asm

.close
; EOF ;
