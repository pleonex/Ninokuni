;;----------------------------------------------------------------------------;;
;;  Keyboard shift align in print
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

KEY_SHIFT		equ #0x19		

.arm
.org 020C656Ch				; Alphabet keys
	ADD		R1, R1, KEY_SHIFT
.org 020C6644h				; Number keys
	ADD		R0, R0, KEY_SHIFT
