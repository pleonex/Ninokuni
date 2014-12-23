;;----------------------------------------------------------------------------;;
;;  Table to encode names
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

.org 02138F68h
.area 6Ch       ; 9 entries
;        1º dec char  1º enc char  Num chars
    dcd  00004081h,   00000001h,   00000001h        ; From ' ' to ' '   / Space
    dcd  00004F82h,   00000002h,   0000000Ah        ; From '０' to '９'  / Numbers
    dcd  00009F82h,   0000000Ch,   00000053h        ; From 'ぁ' to 'ん'  / Hiragana
    dcd  00004083h,   0000005Fh,   00000057h        ; From 'ァ' to 'ヶ'  / Katakana
    dcd  00005B81h,   000000B6h,   00000001h        ; From 'ー' to 'ー'  / Katakana long sound
    dcd  00006081h,   000000B7h,   00000001h        ; From '～' to '～'  /
    dcd  00004881h,   000000B8h,   00000002h        ; From '？' to '！'  /
    dcd  00004181h,   000000BAh,   00000001h        ; From '、' to '、'  / Comma
    dcd  00004281h,   000000BBh,   00000001h        ; From '。' to '。'  / Point
.endarea
