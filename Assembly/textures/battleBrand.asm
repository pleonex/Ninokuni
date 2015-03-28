;;  Modify the subimages position of the texture battles images.
;;  This contnues the function in battle_battleIcon.asm
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

; # 1 row, 1 column (0/0): [0, 0] -> [15, 15]
.org 0x020A5600
  MOV     R8, #15
  MOV     R0, #0
  STMEA   SP, {R0,R8}
  STR     R8, [SP,#0x48+@Yend]
  SUB     R7, R8, #0x16
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R1, #0
  STR     R9, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, R1
  BL      @v3d_setSubImage

; # 1 row, 3 column (1/0): [30, 0] -> [45, 15]
  MOV     R0, #0
  STR     R0, [SP,#0x48+@Ystart]
  MOV     R11, #45
  STR     R11, [SP,#0x48+@Xend]
  STR     R8, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  MOV     R5, #30
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #3
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R5
  BL      @v3d_setSubImage

; # 1 row, 2 column (2/0): [15, 0] -> [30, 15]
  MOV     R0, #0
  STMEA   SP, {R0,R5,R8}
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R4, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R8
  BL      @v3d_setSubImage

; # 1 row, 4 column (3/0): [45, 0] -> [60, 15]
  MOV     R0, #0
  STR     R0, [SP,#0x48+@Ystart]
  MOV     R0, #60
  STMFA   SP, {R0,R8}
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R6, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R11
  BL      @v3d_setSubImage

; # 2 row, 1 column (4/0): [0, 15] -> [15, 30]
  STR     R8, [SP,#0x48+@Ystart]
  STR     R8, [SP,#0x48+@Xend]
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R9, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R2, #0
  MOV     R1, R6
  ADD     R0, R0, #0x128
  MOV     R3, R2
  BL      @v3d_setSubImage

; # 2 row, 3 column (5/0): [30, 15] -> [45, 30]
  STMEA   SP, {R8,R11}
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  MOV     R0, #3
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R5
  BL      @v3d_setSubImage

; # 2 row, 2 column (6/0): [15, 15] -> [30, 30]
  STR     R8, [SP,#0x48+@Ystart]
  STR     R5, [SP,#0x48+@Xend]
  STR     R5, [SP,#0x48+@Yend]
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R4, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, #6
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, R8
  BL      @v3d_setSubImage

; # 2 row, 4 column (7/0): [45, 15] -> [60, 30]
  STR     R8, [SP,#0x48+@Ystart]
  MOV     R0, #60
  STMFA   SP, {R0,R5}
  STR     R7, [SP,#0x48+@Xout]
  STR     R7, [SP,#0x48+@Yout]
  STR     R8, [SP,#0x48+@Width]
  STR     R8, [SP,#0x48+@Height]
  STR     R6, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R1, #7
  MOV     R3, R11
  MOV     R2, #0
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage

; # 3 row, 1 column (8/0): [0, 30] -> [13, 43]
  STR     R5, [SP,#0x48+@Ystart]
  MOV     R1, #13
  MOV     R0, #43
  STR     R1, [SP,#0x48+@Xend]
  STR     R0, [SP,#0x48+@Yend]
  SUB     R0, R0, #0x31
  STR     R0, [SP,#0x48+@Xout]
  STR     R0, [SP,#0x48+@Yout]
  STR     R1, [SP,#0x48+@Width]
  STR     R1, [SP,#0x48+@Height]
  MOV     R0, #5
  STR     R0, [SP,#0x48+@Palette]
  LDR     R0, [R10,#0x14]
  MOV     R2, #0
  MOV     R3, R2
  ADD     R0, R0, #0x128
  MOV     R1, #8
  BL      @v3d_setSubImage
