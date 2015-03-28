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

@Ystart  equ -0x20
@Xend    equ -0x1C
@Yend    equ -0x18
@Xout    equ -0x14
@Yout    equ -0x10
@Width   equ -0x0C
@Height  equ -0x08
@Palette equ -0x04
@v3d_setSubImage equ 0x020FCD7C

.arm

; # Constants
.org 0x020A7300
  MOV     R7, #10

; # Small Up Arrow (0/0): [29, 28] -> [39, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R11, #39
  MOV     R6, #40
  STR     R11, [SP,#0x20+@Xend]
  STR     R6, [SP,#0x20+@Yend]
  SUB     R5, R6, #0x2D
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  MOV     R1, #0
  STR     R7, [SP,#0x20+@Width]
  MOV     R4, #12
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #1
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, #29
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (1/0): [29, 28] -> [39, 40]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,#0x20+@Yend]
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #2
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #29
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (2/0): [29, 28] -> [39, 40]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,#0x20+@Yend]
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #3
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #29
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (3/0): [29, 28] -> [39, 40]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,#0x20+@Yend]
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #4
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #29
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (4/0): [29, 28] -> [39, 40]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,#0x20+@Yend]
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #5
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R3, #29
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, #0
  BL      @v3d_setSubImage

; # Small Down Arrow (5/0): [39, 28] -> [49, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R0, #49
  STMFA   SP, {R0,R6}
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #1
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R11
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (6/0): [39, 28] -> [49, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R0, #49
  STMFA   SP, {R0,R6}
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #2
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #6
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, R11
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (7/0): [39, 28] -> [49, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R0, #49
  STMFA   SP, {R0,R6}
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #3
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #7
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, R11
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (8/0): [39, 28] -> [49, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R0, #49
  STMFA   SP, {R0,R6}
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #4
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R1, #8
  MOV     R3, R11
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (9/0): [39, 28] -> [49, 40]
  STR     R9, [SP,#0x20+@Ystart]
  MOV     R0, #49
  STMFA   SP, {R0,R6}
  STR     R5, [SP,#0x20+@Xout]
  STR     R8, [SP,#0x20+@Yout]
  STR     R7, [SP,#0x20+@Width]
  STR     R4, [SP,#0x20+@Height]
  MOV     R0, #5
  STR     R0, [SP,#0x20+@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #9
  MOV     R2, #0
  MOV     R3, R11
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage
