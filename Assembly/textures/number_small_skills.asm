;;  Modify the subimages position of the texture battles images.
;
; Arguments of v3d_setSubImage function:
;   + R0: Sprite struct
;   + R1: Frame index
;   + R2: Layer index
;   + R3: X Start
;   + SP+00: Y Start
;   + SP+04: X End
;   + SP+08: Y End
;   + SP+0C: X Output
;   + SP+10: Y Output
;   + SP+14: Width
;   + SP+18: Height
;   + SP+1C: Palette index

@Ystart  equ 0x00
@Xend    equ 0x04
@Yend    equ 0x08
@Xout    equ 0x0C
@Yout    equ 0x10
@Width   equ 0x14
@Height  equ 0x18
@Palette equ 0x1C
@v3d_setSubImage equ 0x020FCD7C

.arm

.org 0x020AD9D8
  CMP     R9, #5
  BCS     @row2

; # Numbers of the first row
  MUL     R0, R9, R4
  MOV     R0, R0,LSL#16
  MOV     R6, R0,ASR#16
  MOV     R5, #26
  MOV     R7, #34
  ADD     R0, R9, #1
  B       @setNumber

@row2:
; # Numbers of the second row
  SUB     R0, R9, #5
  MUL     R1, R0, R4
  MOV     R0, R1,LSL#16
  MOV     R6, R0,ASR#16
  MOV     R5, #35
  MOV     R7, #43
  SUB     R0, R9, #4

@setNumber:
; # Set it
  MUL     R1, R0, R4
  MOV     R0, R1,LSL#16
  MOV     R8, R0,ASR#16
  STMEA   SP, {R6-R8}
  LDR     R0, [SP,0x20]
  STR     R11, [SP,@XOut]
  STR     R0, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x50]
  MOV     R1, R9
  ADD     R0, R0, #0x14C
  MOV     R2, #0
  MOV     R3, R5
  BL      @v3d_setSubImage

; # Set again into another place
  STMEA   SP, {R6-R8}
  LDR     R0, [SP,0x20]
  STR     R11, [SP,@XOut]
  STR     R0, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x54]
  MOV     R3, R5
  MOV     R1, R9
  ADD     R0, R0, #0x14C
  MOV     R2, #0
  BL      @v3d_setSubImage

; # Loop condition
  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #10
  ; Loop jump
