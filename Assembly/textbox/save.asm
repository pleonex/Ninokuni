;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in save menus
;;  Copyright 2015 Benito Palacios (aka pleonex)
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

;; Progress star
.org 0x02063096
  MOV r1, #0x48 + 4     ; X position


;; Time display (make hours 3 digits)
.org 0x020632B8
  MOV r2, #3            ; Number to pad (3 digits)
