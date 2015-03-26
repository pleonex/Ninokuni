;;----------------------------------------------------------------------------;;
;;  Force to use HTTP (without SSL encryption layer) easier to capture packets
;;  Copyright 2015 Benito Palacios (aka pleonex)
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

; WARNING: THIS DISABLE THE SECURE MECHANISM. EVERYONE WILL BE ABLE
; TO VIEW THE COMMUNICATION LIKE USERNAME, BIRTHDAY AND ROUTER IP.

.org 0x020D0A00 + 0x00024E5C
  .db "http://nas.nintendowifi.net/a", 0x00
