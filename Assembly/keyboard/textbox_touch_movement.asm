;;----------------------------------------------------------------------------;;
;;  Disable change the position of the cursor touching the char.
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

; Since all chars in japanese have the same width, it's easy to know
; what char are touching. In Spanish and other language, letters like the
; 'i' has a different width. It's very small (an unknown) feature, so we
; disable it.
.org 0x020C6000
  NOP       ; This was a call to update_cursor for that event.
