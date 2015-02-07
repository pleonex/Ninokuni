;;----------------------------------------------------------------------------;;
;;  Hacks for overlay 8 for arm9
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
.open overlay9_8.bin, 0x02079F80

.relativeinclude on
.erroronwarning on

.include pointers\overlay9_8.asm
.include textbox\menu_checksheet.asm
.include textbox\menu_adhoc_battles.asm
.include textbox\menu_adhoc_exchange.asm

.close
; EOF ;
