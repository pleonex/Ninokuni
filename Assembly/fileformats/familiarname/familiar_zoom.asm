;;----------------------------------------------------------------------------;;
;;  Use the familiar long name in Zoom menu
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

@LongNameOffset equ 0xB4

.thumb
.org 0x0215B628
  ADD r5, 0x68
  ADD r0, r5, 0x4
  LDR r1, [r5,#0]
  BL  0x020DE2A8
  ADD r0, r5, 0x4
  ADD r4, @LongNameOffset ; All that code just to get a space for this line...
  MOV R1, #1
  BL  0x020DE2AC
  ADD r0, r5, 0x4
  MOV R6, #5
  SUB r5, 0x68
