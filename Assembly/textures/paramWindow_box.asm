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

@Ystart  equ -0x48
@Xend    equ -0x44
@Yend    equ -0x40
@Xout    equ -0x3C
@Yout    equ -0x38
@Width   equ -0x34
@Height  equ -0x30
@Palette equ -0x2C
@v3d_setSubImage equ 0x020FCD7C

.arm

; # Common constant
.org 0x020A8A94
  MOV     R6, 0xFFFFFFF8
  MOV     R9, #0
  SUB     R5, R6, #1
  MOV     R8, #34
  MOV     R7, #94
  MOV     R11, #52
  MOV     R4, #77

; # Big Down Arrow (i/0): [77, 34] -> [94, 52]
@arrow:
  STR     R8, [SP,#0x48+@Ystart]
  STMFA   SP, {R7,R11}
  STR     R6, [SP,#0x48+@Xout]
  ADD     R1, R9, #1
  STR     R5, [SP,#0x48+@Yout]
  MOV     R0, #17
  STR     R0, [SP,#0x48+@Width]
  MOV     R0, #18
  MOV     R1, R1,LSL#16
  STR     R0, [SP,#0x48+@Height]
  MOV     R0, R1,ASR#16
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x2F4]
  MOV     R1, R9
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, R4
  BL      @v3d_setSubImage

  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #4
  BCC     @arrow

; # Big empty box (0/0): [0, 16] -> [77, 58]
.org 0x020A8B1C
  MOV     R0, #16
  STMEA   SP, {R0,R4}
  MOV     R1, #58
  STR     R1, [SP,#0x48+@Yend]
  SUB     R0, R1, #96
  STR     R0, [SP,#0x48+@Xout]
  SUB     R0, R1, #79
  STR     R0, [SP,#0x48+@Yout]
  MOV     R1, #0
  STR     R4, [SP,#0x48+@Width]
  MOV     R0, #42
  STR     R0, [SP,#0x48+@Height]
  MOV     R0, #7
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x2F8]
  MOV     R2, R1
  MOV     R3, R1
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage
