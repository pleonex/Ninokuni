;;----------------------------------------------------------------------------;;
;;  Align the position of the numbers in the imagen manhole menu
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

;; Deposited
.arm
.org 0x0207E6CC
  RSB     R1, R0, #0x67  ; Original 0x52


;; Total space
;.arm
;.org 0x0207E714
;  RSB     R1, R0, #0xA5  ; Original 0x9A
