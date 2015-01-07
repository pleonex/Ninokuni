;;----------------------------------------------------------------------------;;
;;  Move images in rupe (zoom) menu.
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


; Familiar brand image
.thumb
.org 0x0215A810
  MOV r1, #0x52     ; X pos, originally 0x52
  MOV r2, #0x4C     ; Y pos, originally 0x4C
