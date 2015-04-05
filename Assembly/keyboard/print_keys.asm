;;----------------------------------------------------------------------------;;
;;  Align the char keys
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

; Alphabet keys
.org 0x020C656C
  ADD     R1, R1, #0x16 + 3

; Interrogation and exclamations keys
.org 0x020C65E4
  ADD     R0, R0, #0x04 + 3

; Number keys
.org 0x020C6644
  ADD     R0, R0, #0x16 + 3
