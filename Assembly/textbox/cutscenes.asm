;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in cutscenes
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
.org 0x020FDCE4
  LSL    r0, r4, #0x12    ; Original 0x11

;.org 0x020FDCD2
;MOV     R4, #0x02         ; NO CHANGE IT. It's used to enable BG1 too
;.org 0x020FDCAC
;MOV     r3, ...
;.org 0x020FDDB0
;DBW 0x0400000A
