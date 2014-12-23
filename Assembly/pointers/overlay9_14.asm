;;----------------------------------------------------------------------------;;
;;  Pointer hack (increase text size) in overlay 14 for arm9
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

Frigoria	equ 0x020C18E0 + 0xB1D8 ; -> Xanadú
Xanadu  	equ 0x020C18E0 + 0xB1D0 ; -> Frigoria

.org 0x020C18E0 + 0xA9D0
.word Xanadu

.org 0x020C18E0 + 0xA9E0
.word Frigoria


;; Puerto Bikini
;; Increase space moving next text
Jangol_ptr equ 0x020C18E0 + 0xB1F4

.org 0x020C18E0 + 0xA9C0
.word Jangol_ptr
