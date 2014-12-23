;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in subtitles
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

;; The game creates a MAP image for subtitles that shift using the BG1VOFS
;; register from the Engine A.

.arm
.org 0x0207D89C
  MOV     R1, #0x1640000    ; Original 0x1600000
