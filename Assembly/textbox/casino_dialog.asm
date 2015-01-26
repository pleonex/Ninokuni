;;----------------------------------------------------------------------------;;
;;  Align the position of the textbox in the casino dialogs
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

; Money number
.arm
.org 0x02134F78
  MOV     R1, #0x16     ; X pos, original 0x8

; Number of casino coins
.org 0x02134FB0
  MOV     R1, #0x6E     ; X pos, original 0x60


; Number of casino coins in exchange menu
.arm
.org 0x020D6C6C
  MOV     R1, #0x11        ; X pos, original 0x7
