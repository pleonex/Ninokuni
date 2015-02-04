;;----------------------------------------------------------------------------;;
;;  Align the position of the numbers in the info menu of multi battles.
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

.arm
;; YOU
;; ... Number of battles
.org 0x02084AE8
  RSB r1, r0, #0xEC         ; Right aligned, originally 0xE2

;; ... Battles won
.org 0x02084B28
  RSB r1, r0, #0xB6         ; Right aligned, originally 0xAE

;; ... Battles lose
.org 0x02084B64
  RSB r1, r0, #0xEC         ; Right aligned, originally 0xE4

;; ENEMY
;; ... Number of battles
.org 0x02084CF8
  RSB     R1, R0, #0xEC     ; Right aligned, originally 0xE2

;; ... Battles won
.org 0x02084D38
  RSB r1, r0, #0xB6         ; Right aligned, originally 0xAE

;; ... Battles lose
.org 0x02084D74
  RSB r1, r0, #0xEC         ; Right aligned, originally 0xE4
