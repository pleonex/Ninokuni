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

.org 0x020AA444
  MOV     R8, #2

; # Go Button (0/0): [63, 2] -> [103 + 18, 29]
.org 0x020AA464
  MOV     R6, #29
  STR     R8, [SP,@Ystart]
  MOV     R7, #103 + 8
  STR     R7, [SP,@Xend]
  STR     R6, [SP,@Yend]
  SUB     R5, R6, #49 + 8
  STR     R5, [SP,@Xout]
  SUB     R4, R6, #42
  STR     R4, [SP,@Yout]
  MOV     R11, #40 + 8
  STR     R11, [SP,@Width]
  MOV     R0, #27
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#8]
  MOV     R1, R9
  ADD     R0, R0, #0x1A8
  MOV     R2, R9
  MOV     R3, #63
  BL      @v3d_setSubImage

; # Go Button Pressed (1/0): [63, 2] -> [103 + 18, 29]
  STR     R8, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  MOV     R0, #63
  STR     R6, [SP,@Yend]
  SUB     R0, R0, #81 + 8
  STR     R0, [SP,@Xout]
  MOV     R0, 0xFFFFFFF5
  STR     R0, [SP,@Yout]
  STR     R11, [SP,@Width]
  MOV     R0, #27
  STR     R0, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#8]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, R9
  MOV     R3, #63
  BL      @v3d_setSubImage

; # Go Button (2/0): [63, 2] -> [103 + 18, 29]
  STR     R8, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R4, [SP,@Yout]
  STR     R11, [SP,@Width]
  MOV     R0, #27
  STR     R0, [SP,@Height]
  MOV     R0, #14
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#8]
  MOV     R1, R8
  MOV     R2, R9
  MOV     R3, #63
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # Constants for the Y Button
  MOV     R8, R9
  MOV     R7, #63
  MOV     R6, #10
  MOV     R5, #13
  MOV     R4, #7
  MOV     R11, #12

@buttonY:
  CMP     R9, #1
  MOV     R2, #1
  MOV     R3, #53
  BNE     @buttonY1_2

; # Button Y First Case (0/1): [53, 0] -> [63, 10]
  STR     R8, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R4, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  B       @setButton

@buttonY1_2:
  CMP     R9, #2
  BNE     @buttonY2

; # Button Y Second Case (1/1): [53, 10] -> [63, 20]
  MOV     R0, #10
  STR     R0, [SP,@Ystart]
  MOV     R0, #63
  STR     R0, [SP,@Xend]
  MOV     R0, #20
  B       @buttonYCommon1_2

@buttonY2:
; # Button Y Third Case (2/1): [53, 0] -> [63, 10]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #63
  STR     R0, [SP,@Xend]
  MOV     R0, #10

@buttonYCommon1_2:
  STR     R0, [SP,@Yend]
  MOV     R0, #11
  STR     R0, [SP,@Xout]
  MOV     R0, #5
  STR     R0, [SP,@Yout]
  MOV     R0, #10
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]

@setButton:
  LDR     R0, [R10,#8]
  MOV     R1, R9
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #3
  BCC     @buttonY
