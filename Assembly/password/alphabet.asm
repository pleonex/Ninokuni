;;----------------------------------------------------------------------------;;
;;  Hiragana alphabet for the password generator
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

;; Hiragana
.org 0x020C18E0 + 0xB044
.area 0x74

  ; Random generated
  .ascii "!", "#", "$", "%", "&", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2"
  .ascii "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B"
  .ascii "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R"
  .ascii "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "_", "a", "b", "c", "d"
  .ascii "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t"
  .ascii "u", "v", "w", "x", "y", "z", "{", "|", "}", "~",
  dcw 0x9981, 0x9A81, 0x9B81, 0x9C81, 0x9D81, 0x9E81, 0x9F81, 0xA081,
  dcw 0xA181, 0xA281, 0xA381, 0xA481, 0xA581

.endarea
