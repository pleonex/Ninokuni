;; Code extracted from game. Some instruction has been sorted for good reading
;; Copyright (C) Nintendo and others
;; Use only for learning purpouse
;;
;; Function: readChannelInfo
;; Arguments:
;;  + R0: audio_struct
;;  + R1: File pointer + 0x80

  ; "Save" registers
  STMFD   SP!, {R3-R5,LR}
  MOV     LR, R0
  MOV     R12, R1

  ; Useful constant
  MOV     R2, #0

  ; Jump by encoding
  LDRB    R0, [LR,#0x22]    ; Get encoding flag
  AND     R0, R0, #0xF0     ; ... doing the mask
  CMP     R0, #0x70         ; It's IMA ADPCM
  BEQ     ima_adpcm         ; ... jump
  CMP     R0, #0xB0         ; It's Procyon
  CMPNE   R0, #0xE0         ; ... or ??
  BEQ     procyon           ; ... jump
  B       other             ; Oh, there are others...

ima_adpcm:
  ; If there is no audio channels, quit
  MOV     R5, #0            ; Iteration var (i) = 0
  LDRB    R1, [LR,#0x23]    ; Get number of channels
  CMP     R1, #0            ; ... if it's negative
  BLE     quit              ; ... quit

  MOV     R0, #0x2C

  adpcm_copyInfo:
  LDRH    R4, [R12,#2]      ; Read halfword from file at 0x02
  LDRH    R2, [R12],#4      ; Read halfword from file at 0x00 and increment 4
  ADD     R1, LR, R5,LSL#4  ; Write values at 0x278 + i*0x10
  ADD     R1, R1, #0x200    ; ... Get output pointer
  STRH    R2, [R1,#0x78]    ; ... Write first value
  STRH    R4, [R1,#0x7A]    ; ... Write second value
  MLA     R3, R5, R0, LR    ; Write values at 0x220 + i*0x2C
  ADD     R1, R3, #0x200    ; ... Get output pointer
  STRH    R2, [R1,#0x20]    ; ... Write first value
  STRH    R4, [R1,#0x22]    ; ... Write second value
  ADD     R5, R5, #1        ; Check if copied all channel info values
  LDRB    R1, [LR,#0x23]    ; ...
  CMP     R5, R1            ; ...
  BLT     adpcm_copyInfo    ; ...

  ; If there is not audio channels quit
  MOV     R3, #0            ; Iteration var
  CMP     R1, #0            ; Compare numbers of channels
  BLE     quit              ; Quit

  adpcm_copyInfo2:
  LDRH    R2, [R12]         ; Read halfword from file
  LDRH    R1, [R12,#2]      ; Read halfword from file
  ADD     R12, R12, #4      ; Increment file pointer
  ADD     R0, LR, R3,LSL#4  ; Get output pointer 0x298 + i*0x10
  ADD     R0, R0, #0x200    ; ...
  STRH    R2, [R0,#0x98]    ; Write first value
  STRH    R1, [R0,#0x9A]    ; Write second value
  ADD     R3, R3, #1        ; Check if copied all channel info
  LDRB    R0, [LR,#0x23]    ; ... Get number of channels
  CMP     R3, R0            ; ... Compare!
  BLT     adpcm_copyInfo2   ; ... nop, loop again
  B       quit              ; ... yes, quit

procyon:
  ; If there is no audio channels, quit
  MOV     R5, #0            ; Iteration var (i) = 0
  LDRB    R0, [LR,#0x23]    ; Get number of channels
  CMP     R0, #0            ; ... if it's negative
  BLE     quit              ; ... quit

  procyon_copyInfo:
  ADD     R0, LR, R5,LSL#4  ; Get output pointer
  ADD     R4, R0, #0x298    ; ... 0x298 + i * 16
  LDMIA   R12, {R0-R3}      ; Read from file
  ADD     R12, R12, #0x10   ; ... and increment the pointer
  STMIA   R4, {R0-R3}       ; Write into audio_struct
  LDRB    R0, [LR,#0x23]    ; Check if we have copied all the channels
  ADD     R5, R5, #1        ; ... increment iteration var
  CMP     R5, R0            ; ... compare
  BLT     procyon_copyInfo  ; ... and loop again
  B       quit              ; ... or quit

other:
  MOV     R5, 0
  LDRB    R0, [LR,#0x23]
  CMP     R0, #0
  BLE     quit

  MOV     R0, #0x2C ; ','

  loc_2055104
  MLA     R4, R5, R0, LR
  MOV     R3, 0

  loc_205510C
  ADD     R1, R4, R3,LSL#2
  STR     0, [R1,#0x220]
  ADD     R3, R3, #1
  CMP     R3, #4
  BLT     loc_205510C

  LDRB    R1, [LR,#0x23]
  ADD     R5, R5, #1
  CMP     R5, R1
  BLT     loc_2055104

quit:
  MOV     R0, #1            ; Set to true, channel info read
  STRB    R0, [LR,#8]       ; ...
  MOV     R0, #0            ; Returns goood
  LDMFD   SP!, {R3-R5,PC}   ; ...
