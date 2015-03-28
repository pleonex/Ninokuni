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

; # Common constants
.org 0x020A53EC
  MOV     R9, #1

; # 1 row, 1 column icon (0/0): [0, 0] -> [18, 18]
.org 0x020A5420
  MOV     R8, #18
  MOV     R0, #0
  STMEA   SP, {R0,R8}
  MOV     R1, #0
  STR     R8, [SP,#0x48+@Yend]
  SUB     R7, R8, #27
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R9, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, R1
  BL      @v3d_setSubImage

; # 1 row, 4 column icon (1/0): [54, 0] -> [72, 18]
  MOV     R0, #0
  STR     R0, [SP,#0x48+@Ystart]
  MOV     R0, #72
  STMFA   SP, {R0,R8}
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  MOV     R11, #54
  STR     R8, [SP,#0x48+@Height]
  MOV     R6, #4
  STR     R6, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R11
  BL      @v3d_setSubImage

; # 2 row, 1 column icon (2/0): [0, 18] -> [18, 36]
  STR     R8, [SP,#0x48+@Ystart]
  MOV     R4, #2
  MOV     R2, #0
  STR     R8, [SP,#0x48+@Xend]
  MOV     R5, #36
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #5
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R3, R2
  BL      @v3d_setSubImage

; # 1 row, 3 column icon (3/0): [36, 0] -> [54, 18]
  MOV     R0, #0
  STMEA   SP, {R0,R11}
  STR     R8, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #3
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R5
  BL      @v3d_setSubImage

; # 1 row, 2 column icon (4/0): [18, 0] -> [36, 18]
  MOV     R0, #0
  STMEA   SP, {R0,R5,R8}
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R4, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, R6
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R8
  BL      @v3d_setSubImage

; # 2 row, 3 column icon (5/0): [36, 18] -> [54, 36]
  STMEA   SP, {R8,R11}
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #7
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R5
  BL      @v3d_setSubImage

; # 2 row, 2 column icon (6/0): [18, 18] -> [36, 36]
  STR     R8, [SP,#0x48+@Ystart]
  STR     R5, [SP,#0x48+@Xend]
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #6
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, R8
  MOV     R1, #6
  ADD     R0, R0, #0x128
  MOV     R2, #0
  BL      @v3d_setSubImage
