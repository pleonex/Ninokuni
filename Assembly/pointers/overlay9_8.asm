;;----------------------------------------------------------------------------;;
;;  Pointer hack (increase text size) in overlay 8 for arm9
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

;; Puerto Bikini
PuertoBikini_ptr	equ 0x02079F80 + 0x01F290
Kagoshima_ptr  	equ 0x02079F80 + 0x01F284

.org 0x02079F80 + 0x020084
.word PuertoBikini_ptr

.org 0x02079F80 + 0x020070
.word Kagoshima_ptr
