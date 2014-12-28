;;----------------------------------------------------------------------------;;
;;  Use "long name" field when upgrading a familiar
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

@LongNameOffset equ 0xB4 ; At the end of the old entry


;; Upgrading a familiar
.arm
.org 0x020ADCDC
  ADD r3, r5, @LongNameOffset

.org 0x020ADCBC
  ADD r2, r5, @LongNameOffset

.arm
.org 0x020AD3FC
  ADD r6, r0, @LongNameOffset


;; Ask dialog
.arm
.org 0x020AE37C
  ADD r2, r0, @LongNameOffset

.org 0x020AE3A4
  ADD r2, r0, @LongNameOffset


;; After upgrading, confirm dialog
.arm
.org 0x020ACEB8
  ADD r3, r0, @LongNameOffset
