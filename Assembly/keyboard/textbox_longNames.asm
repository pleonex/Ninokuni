;;----------------------------------------------------------------------------;;
;;  Fix the position of the textboxes
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


; # L / R X Position
; The following values are the relative position as the screen width would be
; 258. Exactly, X_L = Z and X_R = 258 - Z, where Z are the next numbers.
; So, if you change it, you are moving L to the right the same value as
; R to the left.
.org 0x02139E32
  .dcb 0x44 + 66        ; Questions
  .dcb 0x6D + 34        ; Player name


; # Textboxes X Position
; Position of the text inside the textbox and the char cursor
.org 0x02139E36
  .dcb 0x1D + 66        ; Questions
  .dcb 0x45 + 35        ; Player name
