;; Code extracted from game. Some instruction has been sorted for good reading
;; Copyright (C) Nintendo and others
;; Use only for learning purpouse
;;
;; Function: sadl_readHeader
;; Arguments:
;;  + R0: audio_struct
;;  + R1: file pointer
;; Returns:
;;  + R0: 0 -> good | -1 -> error
;; Stack variables:
;;  + var_28= -0x28
;;  + var_24= -0x24

  ; "Save" registers
  STMFD   SP!, {R3-R7,LR}
  SUB     SP, SP, #0x10
  MOV     R6, R0
  MOV     R5, R1

  ; Copy the first 0x80 bytes from the file
  MOV     R4, #0x80         ; Bytes to copy
  MOV     R2, R4            ; ...
  MOV     R0, R5            ; File (input) pointer
  ADD     R1, R6, #0x64     ; Output pointer
  BL      mem_copy

  ; Read and copy common header
  LDRB    R0, [R5,#0x32]    ; Read byte at 0x32
  STRB    R0, [R6,#0x23]    ; ... and write at 0x23
  LDRB    R3, [R5,#0x35]    ; Read byte at 0x35
  STRB    R3, [R6,#0x21]    ; ... and write at 0x21
  LDRB    R3, [R5,#0x62]    ; Read byte at 0x62
  STRB    R3, [R6,#0x25]    ; ... and write at 0x25
  LDR     R2, =0x2077528    ; Read signed byte from table
  LDRB    R3, [R5,#0x62]    ; -.-' Index at 0x62
  LDRSB   R2, [R2,R3]       ; ...
  STRB    R2, [R6,#0x26]    ; ... and write at 0x26
  LDR     R1, =0x7FD8       ; Store word 0x7FD8
  STR     R1, [R6,#0x40]    ; ... at 0x40
  LDRB    R1, [R5,#0x65]    ; Read byte at 0x65
  STRB    R1, [R6,#0x27]    ; ... and write at 0x27
  MOV     R0, #1            ; Store byte 0x01
  STRB    R0, [R6,#0x20]    ; ... at 0x20
  LDR     R1, [R5,#0x68]    ; Read word at 0x68

  ; Check and jump to audio type
  LDRB    R2, [R5,#0x33]    ; Read flags: encoding & sample rate
  STRB    R2, [R6,#0x22]    ; ... and write at 0x22
  CMP     R2, #0xB4
  BEQ     isProcyon_32KHz
  CMP     R2, #0xB2
  BGE     isProcyon_16KHz
  CMP     R2, #0x72
  BEQ     isIMA_16KHz
  CMP     R2, #0x74
  BEQ     isIMA_32KHz
  B       error

isIMA_32KHz:
  LDRSB   R0, [R6,#0x27]
  CMP     R0, #0
  BNE     loc_2054C6C
  LDR     R3, =sub_20520D0
  MOV     R2, #0x20 ; ' '
  MOV     R0, #0x40 ; '@'

  loc_2054C5C
  STR     R3, [R6,#0x204]
  STR     R2, [R6,#0x1DC]
  STR     R0, [R6,#0x1E0]
  B       after_flags

  loc_2054C6C
  LDR     R3, =sub_2052214
  MOV     R2, #0x1E
  MOV     R0, #0x3C ; '<'
  B       loc_2054C5C

isIMA_16KHz:
  LDRSB   R0, [R6,#0x27]
  CMP     R0, #0
  BNE     loc_2054CA0
  LDR     R2, =sub_2052374
  MOV     R0, #0x40 ; '@'
  STR     R2, [R6,#0x204]
  STR     R0, [R6,#0x1DC]
  STR     R4, [R6,#0x1E0]
  B       after_flags

  loc_2054CA0
  LDR     R3, =sub_2052508
  MOV     R2, #0x3C ; '<'
  MOV     R0, #0x78 ; 'x'
  B       loc_2054C5C

isProcyon_32KHz:
  MOV     R0, #0x3C             ; Write constant 0x3C
  STR     R0, [R6,#0x1E0]       ; ... at 0x1E0
  MOV     R1, #0x1E             ; Write constant 0x1E
  STR     R1, [R6,#0x1DC]       ; ... at 0x1DC
  LDR     R2, =sub_020526FC     ; Write function pointer
  STR     R2, [R6,#0x204]       ; ... at 0x204
  MOV     R1, 0                 ; Set to 0
  B       after_flags

isProcyon_16KHz:
  LDR     R2, =sub_20528C8
  MOV     R1, #0x3C ; '<'
  MOV     R0, #0x78 ; 'x'
  STR     R2, [R6,#0x204]
  STR     R1, [R6,#0x1DC]
  STR     R0, [R6,#0x1E0]
  LDR     R1, =0x1770
  B       after_flags

after_flags:
  MOV     R12, #0               ; Loop iteration var (i) set to 0
  LDR     R5, =0x207968C        ; Read number of entries in channel table
  LDRB    LR, [R5,#0xBE]        ; ...
  CMP     LR, #0                ; ... if there is no entry
  MOV     R0, 0xFFFFFFFF        ; Entry index not found
  BLE     found_channel_entry

search_channel_entry:
  ADD     R4, R5, R12,LSL#5     ; Read table entries of 0x20 bytes from 0x55
  LDRSB   R2, [R4,#0x55]        ; ... a signed byte
  CMP     R2, #0                ; If ID is 0...
  LDREQB  R3, [R6,#0x23]        ; ... check the number of channels from file
  LDREQB  R2, [R4,#0x56]        ; ... and the entries[1]
  CMPEQ   R3, R2                ; ... are equals
  MOVEQ   R0, R12               ; ...... and in that case, R0 = i
  BEQ     found_channel_entry   ; ...... and we found it, break
  ADD     R12, R12, #1          ; Increment loop interation
  CMP     R12, LR               ; ... until all entry has been processed
  BLT     search_channel_entry  ; ... and jump again

found_channel_entry:
  CMP     R0, #0                ; If we have not found the entry, error
  ADDLT   SP, SP, #0x10         ; ...
  MOVLT   R0, 0xFFFFFFFF        ; ...
  LDMLTFD SP!, {R3-R7,PC}       ; ...

  MOV     R4, #1                ; Store 1 in the channel entry
  LDR     R2, =0x20796E1        ; ... table + 0x55
  STRB    R4, [R2,R0,LSL#5]     ; ...
  STRB    R0, [R6,#0x1C4]       ; Store table index
  LDR     R3, [R6,#0xAC]        ; Read word at file 0x48
  STR     R3, [R6,#0x4C]        ; ... and write at 0x4C
  STR     R3, [R6,#0x50]        ; ... and write at 0x50
  STR     R3, [R6,#0x54]        ; ... and write at 0x54

  ; Set if it's looped
  LDRB    R2, [R6,#0x1E]        ; Read manual loop value
  CMP     R2, #0                ; Manual loop set to false
  STRBEQ  0, [R6,#0xC]          ; ... no loop
  BEQ     after_isLooped        ; ...
  CMP     R2, #1                ; Manual loop set to true
  STRBEQ  1, [R6,#0xC]          ; ... do loop
  BEQ     after_isLooped        ; ...
  CMP     R2, #2                ; Manual loop set to by file value
  LDRBEQ  R0, [R6,#0x95]        ; ... read from file at 0x31
  STRBEQ  R0, [R6,#0xC]         ; ... who knows?
  BEQ     after_isLooped        ; ...

after_isLooped:
  ; Check for unknown encoding
  LDRB    R0, [R6,#0x22]        ; Read encoding value
  AND     R0, R0, #0xF0         ; ... doing a mask
  CMP     R0, #0xC0             ; WHAT ENCODING IS THAT??
  BEQ     after_setConstantLoop ; ...

  ; Set constant if it's looped or not
  LDRSB   R0, [R6,#0xC]         ; Read is looped value
  CMP     R0, #1                ; If is looped write 0x02055140
  LDREQ   R0, =0x2055140        ; else write 0x02055308
  LDRNE   R0, =0x2055308        ; ...
  STR     R0, [R6,#0x1FC]       ; ...

after_setConstantLoop:
  ; Get start offset and size
  LDRB    R0, [R6,#0x95]        ; Check file loop flag at 0x31
  CMP     R0, #0                ; If it's not looped
  LDREQ   R0, [R6,#0xA4]        ; ... read word from 0x40 (file size)
  LDREQ   R2, [R6,#0xAC]        ; ... read word from 0x48  (offset)
  LDRNE   R0, [R6,#0xBC]        ; else read word from 0x58 (file size)
  LDRNE   R2, [R6,#0xB8]        ; ... read word from 0x54 (offset)
  STR     R0, [R6,#0x5C]        ; Write audio size at 0x5C
  STR     R2, [R6,#0x58]        ; Write audio offset at 0x58

  ; Update some file values
  LDRB    R0, [R6,#0xC4]        ; Set to 0x7F if file byte at 0x60 is 0
  CMP     R0, #0                ; ... if it's 0
  MOVEQ   R0, #0x7F             ; ... store byte 0x7F
  STRBEQ  R0, [R6,#0xC4]        ; ... at 0x60
  LDRB    R0, [R6,#0xC5]        ; Set to 0x40 if file byte at 0x61 is 0
  CMP     R0, #0                ; ... if it's 0
  MOVEQ   R0, #0x40             ; ... store byte 0x40
  STRBEQ  R0, [R6,#0xC5]        ; ... at 0x61

  ; Remember, R1 = [0x68] if IMA, 0x0 if Procyon32Khz or 0x1770 if Procyon16KHz
  CMP     R1, #0
  BEQ     loc_2054E34
  MOV     R4, #3
  ADD     R5, SP, #0x28+var_24
  LDR     R0, =0x7FD8
  MOV     R2, R4
  MOV     R3, #0
  STR     R5, [SP,#0x28+var_28]
  BL      sub_20545B8
  MOV     R0, R5
  MOV     R1, R4
  BL      sub_20547F8

  loc_2054E34
  LDR     R1, =0x20796AC
  MOV     R0, R6
  BL      sub_2054E8C       ; Set [0x1EC], [0x1F0], [0x14] word. Returns 0x00
  CMP     R0, #0            ; Quit with error or success code
  MOVLT   R0, 0xFFFFFFFF    ;
  MOVGE   R0, #0            ;
  ADD     SP, SP, #0x10     ;
  LDMFD   SP!, {R3-R7,PC}   ;

error:
  ADD     SP, SP, #0x10     ; Quit with error
  MOV     R0, 0xFFFFFFFF    ;
  LDMFD   SP!, {R3-R7,PC}   ;


;; Function: sub_2054E8C
;; Arguments:
;;  + R0: audio_struct
;;  + R1: Table = 0x021AF3A0
;; Returns:
;;  + R0: 0 -> good

  LDR     R3, [R1,#0xC]     ; Read word 0x0780 from table
  STR     R3, [R0,#0x1EC]   ; ... and write at 0x1EC
  LDR     R1, [R1,#0xC]     ; Read word 0x0780 again -.-'
  ADD     R1, R1, R1,LSR#31 ; ... and add sign bit
  MOV     R1, R1,ASR#1      ; ... and divide by 2
  STR     R1, [R0,#0x1F0]   ; ... and write at 0x1F0
  MOV     R2, #1            ; Set byte 0x01
  STRB    R2, [R0,#0x14]    ; ... at 0x14
  MOV     R0, #0            ; Returns goooood
  BX      LR                ; ...
