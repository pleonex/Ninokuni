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


; # Input length
; The number of characters the user can write
.org 0x02139E30
  .dcb 0x0A             ; Questions
  .dcb 0x06 + 1         ; Player name (warning: in the save only fits 8 bytes,
                        ; that is the player name + \0)


; # L / R X Position
; The following values are the relative position as the screen width would be
; 258. Exactly, X_L = Z and X_R = 258 - Z, where Z are the next numbers.
; So, if you change it, you are moving L to the right the same value as
; R to the left.
.org 0x02139E32
  .dcb 0x44 + 66        ; Questions
  .dcb 0x6D + 34        ; Player name


; # Number of buttons in the bottom
; Number of buttons below. Valid values are 3 and 4. The difference is if the
; button to change between upper and lower case chars is present. Other values
; make the game crash.
.org 0x02139E34
  .dcb 0x03             ; Questions
  .dcb 0x04             ; Player name

; # Textboxes X Position
; Position of the text inside the textbox and the char cursor
.org 0x02139E36
  .dcb 0x1D + 66        ; Questions
  .dcb 0x45 + 35        ; Player name
