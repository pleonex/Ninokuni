;;----------------------------------------------------------------------------;;
;;  Disable left buttons (nigori/accent)
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

.arm

; If somehow a nigori key is pressed, do nothing
.org 020C6810h
.area 4h
  BEQ     020C69F4h                       ; Jump to the end
.endarea


; Make impossible select the nigori keys
.org 0x020C6778
  MOVNE   R3, #0        ; Max number of rows in keyboard 1 (originally 6)
  MOVEQ   R3, #0        ; Max number of rows in keyboard 2 (originally 3)
