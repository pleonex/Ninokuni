;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the main manu
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
; Selected characters name
.org 0x020D9384
  ADD r2, #0x16 - 6     ; X position, centered

; Characters name in the team
.org 0x020D96E0
  ADD r1, #0x14        ; X position, centered
