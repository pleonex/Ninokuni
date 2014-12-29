;; Code extracted from game. Some instruction has been sorted for good reading
;; Copyright (C) Nintendo and others
;; Use only for learning purpouse
;;
;; Function: update_internal: do something don't want to know after a quick view
;; Arguments:
;;  + R0: 8
;; Stack variables:
;;  + var_40= -0x40
;;  + var_3C= -0x3C
;;  + var_38= -0x38

  ; "Save" variables
  STMFD   SP!, {R4,R5,LR}
  SUB     SP, SP, #0x34
  MOV     R5, R0

  ; Set to 0 var_38 and var_40
  ADD     R4, SP, 8             ; Pointer to the vars
  MOV     R0, R4                ; ...
  BL      sub_200857C           ; Set [R0]=0, [R0+8]=0

  ; Store some pointer in var_3C
  LDR     R0, =0x206C684
  LDR     R0, [R0,#8]
  LDR     R0, [R0]
  STR     R0, [SP,#0x40+var_3C]

  ; Disable IRQ
  BL      sub_2008D20
  MOV     R1, R0                ; Save old value
  MOV     R0, R5                ; ...
  MOV     R5, R1                ; ...

  ; Write the pointer to the other stack variables in that some pointer
  LDR     R2, [SP,#0x40+var_3C] ; Get that some pointer
  STR     R4, [R2,#0xB0]        ; Write the pointer to the stack variables

  ; Store the pointer to that some pointer in var_40
  ADD     R2, SP, #0x40+var_3C  ;
  STR     R2, [SP,#0x40+var_40] ;

  ; Something with current played time
  MOV     R0, R4
  LDR     R1, =0x82EA           ; R1 = (arg0 * 0x82EA) / 0x40
  UMULL   R1, R12, R0, R1       ; ...
  MOV     R1, R1,LSR#6          ; ...
  ORR     R1, R1, R12,LSL#26    ; ...
  MOV     R2, R12,LSR#6         ; ...
  LDR     R3, =0x20070E4
  BL      sub_20086B4


  LDR     R0, [SP,#0x40+var_3C]
  CMP     R0, #0
  BEQ     quit
  MOV     R4, #0

  ; Really, don't try to understand what it does here, it's really...
  ; don't look... it's all IRQ, timers and reading pointers and more pointers
  loc_20070B4
  MOV     R0, R4
  BL      sub_2006DA0
  LDR     R0, [SP,#0x40+var_3C]
  CMP     R0, #0
  BNE     loc_20070B4

quit:
  MOV     R0, R5                ; Restore IRQ
  BL      sub_2008D34           ; ...
  ADD     SP, SP, #0x34         ; Quit
  LDMFD   SP!, {R4,R5,PC}       ; ...
