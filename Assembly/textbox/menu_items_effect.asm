;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the effect of items
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

.thumb
;; Item effect
.org 0x02117D4E
  MOV    R1, #0x60 ; X POS -> Original 0x62

;; Slot color
.org 0x021170DE
  MOV    R1, #0x9E - 4 ; X POS


.thumb
;; Increase the size of the item name textbox
.org 0x02116E90
  MOV     R0, #0x14 + 2     ; Width / 8
