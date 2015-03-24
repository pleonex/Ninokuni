;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in script dialogs
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
.org 0x020E3344
  MOV r1, #0x03
  NEG r1, r1

;; Dialog questions answers
;; Relative positions to OAM position, don't change
.thumb
.org 0x020E0788  ; No-selected text
  MOV    r2, #0  ; Original #0

.org 0x020E07B8  ; Selected text
  MOV    r2, #0  ; Original #0


;; Absolute Dialog Question Answers OAM position
.thumb
.org 0x020E08F8
  ADD    R2, #0x7 + 3       ; With furigana

.org 0x020E0886
  ADD    R2, #0x14 + 3      ; Without furigana
