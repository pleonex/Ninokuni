;; Code extracted from game. Some instruction has been sorted for good reading
;; Copyright (C) Nintendo and others
;; Use only for learning purpouse
;;
;; Function: sadl_getData
;; Arguments:
;;  + R0: audio_struct

  ; "Save" variables
  STMFD   SP!, {R3-R9,LR}
  MOV     R6, R0

  ; Useful constants
  MOV     R4, #1
  MOV     R5, #0

  ; Check if we have to do something
  LDRSB   R1, [R6,#0x10]    ; Read at 0x10
  CMP     R1, #0            ; ... and if 0
  LDMEQFD SP!, {R3-R9,PC}   ; ... returns

  ; Check if it's the end
  LDRSB   R1, [R6,#5]
  CMP     R1, #1
  BNE     switch_status

  ; It's the end, closiiiing
  LDR     R1, [R6,#0x210]
  STRB    R5, [R6,#0x2F]    ; State 0
  STRB    R5, [R6,#5]       ; It is not the end anymore
  BLX     R1                ; close
  STRB    R4, [R6,#7]
  LDMFD   SP!, {R3-R9,PC}

switch_status:
  LDRB    R1, [R6,#0x2F]    ; Get state
  CMP     R1, #6            ; switch 7 cases by state
  ADDLS   PC, PC, R1,LSL#2  ; ... switch jump
  B       read_nextBlock    ; default case
  B       read_nextBlock    ; case 0 -> default case
  B       initializate      ; case 1 -> cases 1,3,4
  B       read_nextBlock    ; case 2 -> default case
  B       initializate      ; case 3 -> cases 1,3,4
  B       initializate      ; case 4 -> cases 1,3,4
  B       unknown_state     ; case 5 -> case 5
  B       read_nextBlock    ; case 6 -> default case

initializate:
  ; Load the file
  LDR     R1, [R6,#0x20C]   ; Get subroutine to load file
  BLX     R1                ; ... call it
  CMP     R0, #0            ; On error
  STRBLT  R4, [R6,#5]       ; ... request to close
  STRBLT  R5, [R6,#0x2F]    ; ... set state closed
  BLT     read_nextBlock    ; ... skip

  ; Copy the header data
  MOV     R0, R6            ; audio_struct
  LDR     R7, =0x207968C    ; Get temp header data pointer
  LDR     R1, [R7,#0x1C]    ; ...
  MOV     R2, #0x100        ; Data to copy (header size)
  MOV     R3, R5            ; 0
  LDR     R8, [R6,#0x214]   ; Call the routine to get file data
  BLX     R8                ; ...
  CMP     R0, #0            ; On error
  STRLTB  R5, [R6,#0x2F]    ; ... set state closed
  BLT     read_nextBlock    ; ... skip

  ; Read header
  LDR     R1, [R7,#0x1C]    ; Header data
  MOV     R0, R6            ; audio_struct
  BL      readHeader        ; Call it
  CMP     R0, #0            ; On error
  STRNEB  R4, [R6,#5]       ; ... request to close
  STRNEB  R5, [R6,#0x2F]    ; ... set state 0
  BNE     read_nextBlock    ; ... skip

  ; Read channel info
  MOV     R0, R6            ; audio_struct
  LDR     R1, [R7,#0x1C]    ; Channel info is at 0x80
  ADD     R1, R1, #0x80     ; ... from file
  BL      readChannelInfo   ; Call it

  ; Set status to unknown_state
  MOV     R8, #5            ; Status unknown_state
  STRB    R8, [R6,#0x2F]    ; ... write it

  ; Call the unknown function
  LDR     R0, [R6]
  MOV     R1, #3
  MOV     R2, R5
  LDR     R3, [R6,#0x1F8]
  LDR     R7, [R6,#0x1F4]
  BLX     R7
  B       read_nextBlock

unknown_state:
  LDRSB   R0, [R6,#0x12]
  CMP     R0, #0
  LDREQSB R0, [R6,#0xA]
  CMPEQ   R0, #1
  LDREQSB R0, [R6,#0x11]
  CMPEQ   R0, #0
  BNE     read_nextBlock
  LDRH    R1, [R6,#0x2C]
  CMP     R1, #0
  MOVEQ   R7, R5
  BEQ     loc_2054A28
  MOV     R0, #0x3E8
  MUL     R0, R1, R0
  LDR     R1, =0x20774E0
  LDRSH   R1, [R1,#0x28]
  BL      sub_2026910
  MOV     R0, R0,LSL#16
  MOVS    R7, R0,LSR#16
  MOVEQ   R7, R4

  loc_2054A28
  LDRSB   R0, [R6,#0x2E]
  CMP     R7, #0
  MOV     R1, R0,LSL#16
  STR     R1, [R6,#0x38]
  STREQ   R1, [R6,#0x30]
  BEQ     loc_2054A5C
  LDR     R0, [R6,#0x30]
  SUBS    R0, R1, R0
  MOVEQ   R7, #0
  BEQ     loc_2054A5C
  MOV     R1, R7
  BL      sub_2026704
  STR     R0, [R6,#0x34]

  loc_2054A5C
  MOV     R0, R6
  STRH    R7, [R6,#0x3C]
  BL      sub_2055820
  MOV     R0, #6
  STRB    R4, [R6,#0xB]
  STRB    R0, [R6,#0x2F]

read_nextBlock:
  ; Check some condition to know if we can read data
  LDRSB   R0, [R6,#9]
  CMP     R0, #0
  LDRSBNE R0, [R6,#6]
  CMPNE   R0, #1
  LDMFDEQ SP!, {R3-R9,PC}

  ; Get remaining data size
  LDR     R0, [R6,#0x5C]    ; Get remaining data size
  SUB     R9, R0, R3        ; If we have read more than possible
  CMP     R9, #0            ; ...
  BLE     read_tooMuch      ; ... jump

  ; Disable all the IRQ (saving the value)
  LDR     R8, =0x4000208    ; Master IRQ pointer
  LDRH    R7, [R8]          ; Get current value for later
  STRH    R5, [R8]          ; Disable all
  LDRH    R1, [R8]          ; Read... who knows..

  ; Get the data block size to read
  LDR     R4, [R6,#0xE8]
  LDR     R2, [R6,#0xEC]
  SUB     R1, R4, R2
  SUB     R0, R5, #0x200    ; Pad to 32 bytes
  AND     R4, R1, R0        ; ...

  ; Enable again IRQ
  STRH    R7, [R8]

  ; If it's less than 512 bytes.. bah... exit
  CMP     R4, #0x200
  LDMLTFD SP!, {R3-R9,PC}

  ; Check for maximum limits
  LDR     R0, =0x207968C    ; Get maximum bytes to read
  LDR     R0, [R0,#0x14]    ; ... it's 0x2000
  CMP     R4, R9            ; If it's bigger than data remaining
  MOVGT   R4, R9            ; ... set it
  CMP     R4, R0            ; If it's bigger than maximum allowed
  MOVGT   R4, R0            ; ... set it

  ; Read next block of data
  MOV     R0, R6            ; audio_struct
  LDR     R7, =0x207968C    ; Get temp header data pointer
  LDR     R1, [R7,#0x1C]    ; ...
  MOV     R2, R4            ; Data block size
  LDR     R3, [R6,#0x50]    ; Get offset
  LDR     R8, [R6,#0x214]   ; Get file data function
  BLX     R8                ; ... call it
  CMP     R0, #0            ; On error
  LDMLEFD SP!, {R3-R9,PC}   ; ... quit

  ; Safe copy to memory disabling IRQ
  LDR     R9, =0x4000208    ; Disable IRQ
  LDRH    R8, [R9]          ; ... get current value for later
  STRH    R5, [R9]          ; ... disable
  ADD     R0, R6, #0xE4     ; Where to write the output info
  LDR     R1, [R7,#0x1C]    ; Input pointer
  MOV     R2, R4            ; Data to copy
  BL      copyAudioData     ; Copy!
  LDRH    R0, [R9]          ; Read IRQ... who knows...
  STRH    R8, [R9]          ; Restore IRQ

  ; Update offset and quit
  LDR     R0, [R6,#0x50]    ; Get offset
  ADD     R0, R0, R4        ; Add the block size
  STR     R0, [R6,#0x50]    ; Update value
  LDMFD   SP!, {R3-R9,PC}   ; Quit :)

read_tooMuch:
  MOV     R2, #0
  LDRSB   R0, [R6,#0xC]
  CMP     R0, #1
  BNE     read_toMuchWithoutSense

  ; Read to much, but it's looped, allowed
  LDR     R5, [R6,#0x58]    ; Get audio loop offset
  STR     R5, [R6,#0x50]    ; ... and write into next offset

  LDR     R0, [R6]
  MOV     R1, #0xF
  LDR     R3, [R6,#0x1F8]
  LDR     R4, [R6,#0x1F4]
  BLX     R4
  LDMFD   SP!, {R3-R9,PC}

read_toMuchWithoutSense:
  STRB    R4, [R6,#0xE]     ; Set error flag?
  STRB    R2, [R6,#9]       ; Stop reading!

  LDR     R0, [R6]
  MOV     R1, #0x10
  LDR     R3, [R6,#0x1F8]
  LDR     R5, [R6,#0x1F4]
  BLX     R5
  LDMFD   SP!, {R3-R9,PC}
