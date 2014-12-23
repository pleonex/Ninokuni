;;----------------------------------------------------------------------------;;
;;  Keyboard keys
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
; * Notes:
;    '·' represents the null char 8140h (sjis space) that means "no char".
;    '¬' represents a space that will be overwrite with ASM code.

.org 020CBD90h              ; 4 chars in the last column
.area 10h
    dcw 4881h, 3F00h, 4981h, 2100h                              ;  ¿  ?  ¡  !
.endarea

.org 020CBD9Ah              ; Numbers
.area 14h
    dcw 3000h, 3100h, 3200h, 3300h, 3400h, 3500h, 3600h, 3700h  ;  0  1  2  3  4  5  6  7
    dcw 3800h, 3900h                                            ;  8  9
.endarea

.org 020CBDB0h              ; Alphabet 1 (hiragana)
.area 64h
    dcw 4100h,  4200h, 4300h, 4400h, 4500h, 4600h, 4700h, 4800h  ;  A  B  C  D  E  F  G  H
    dcw 4900h,  4A00h, 4B00h, 4C00h, 4D00h, 4E00h, 6D82h, 4F00h  ;  I  J  K  L  M  N  Ñ  O
    dcw 5000h,  5100h, 5200h, 5300h, 5400h, 5500h, 5600h, 5700h  ;  P  Q  R  S  T  U  V  W
    dcw 5800h,  5900h, 5A00h, 2000h, 6082h, 6482h, 6882h, 6E82h  ;  X  Y  Z     Á  É  Í  Ó
    dcw 7482h, 0DE81h, 2C00h, 2E00h, 6781h, 6881h, 3C00h, 3E00h  ;  Ú  Ü  ,  .  "  "  <  >
    dcw 2300h,  2400h, 2500h, 2600h, 2B00h, 2D00h, 2A00h, 2F00h  ;  #  $  %  &  +  -  *  /
    dcw 2800h,  2900h                                            ;  (  )
.endarea

.org 020CBE14h              ; Alphabet 1 (hiragana) with nigori 1
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h                                            ;  ·  ·
.endarea

.org 020CBE78h              ; Alphabet 1 (hiragana) with nigori 2
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h                                            ;  ¬  ¬
.endarea

.org 020CBEDCh              ; Alphabet 1 (hiragana) capital
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h                                            ;  ¬  ¬
.endarea

.org 020CBF42h              ; Alphabet 2 (katakana)
.area 64h
    dcw 6100h,  6200h, 6300h, 6400h, 6500h, 6600h, 6700h, 6800h  ;  a  b  c  d  e  f  g  h
    dcw 6900h,  6A00h, 6B00h, 6C00h, 6D00h, 6E00h, 8E82h, 6F00h  ;  i  j  k  l  m  n  ñ  o
    dcw 7000h,  7100h, 7200h, 7300h, 7400h, 7500h, 7600h, 7700h  ;  p  q  r  s  t  u  v  w
    dcw 7800h,  7900h, 7A00h, 2000h, 8182h, 8582h, 8982h, 8F82h  ;  x  y  z     á  é  í  ó
    dcw 9582h, 0DD81h, 2C00h, 2E00h, 6781h, 6881h, 3C00h, 3E00h  ;  ú  ü  ,  .  "  "  <  >
    dcw 2300h,  2400h, 2500h, 2600h, 2B00h, 2D00h, 2A00h, 2F00h  ;  #  $  %  &  +  -  *  /
    dcw 2800h,  2900h                                            ;  (  )
.endarea

.org 020CBFA6h              ; Alphabet 2 (katakana) with nigori 1
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h                                            ;  ¬  ¬
.endarea

.org 020CC00Ah              ; Alphabet 2 (katakana) with nigori 2
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h                                            ;  ¬  ¬
.endarea

.org 020CC06Eh              ; Alphabet 2 (katakana) capital
.area 64h
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ·  ·  ·
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ·  ·  ·  ·  ·  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h, 4081h  ;  ¬  ¬  ¬  ¬  ¬  ¬  ¬  ¬
    dcw 4081h, 4081h                                            ;  ¬  ¬
.endarea
