;;  Modify the subimages position of the texture battles images.
;;  This continues paramWindow_tabs
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

; # Constants
.org 0x020A7300
  MOV     R7, #10

; # Small Up Arrow (0/0): [29 - 29, 28 + 74] -> [39 - 29, 40 + 74]
.org 0x020A7318
  MOV     R9, #102
  STR     R9, [SP,@Ystart]
  MOV     R11, #10
  MOV     R6, #40 + 74
  STR     R11, [SP,@Xend]
  STR     R6, [SP,@Yend]
  SUB     R5, R6, #45 + 74
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  MOV     R1, #0
  STR     R7, [SP,@Width]
  MOV     R4, #12
  STR     R4, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, #0
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (1/0): [29 - 29, 28 + 74] -> [39 - 29, 40 + 74]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #0
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (2/0): [29 - 29, 28 + 74] -> [39 - 29, 40 + 74]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #0
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (3/0): [29 - 29, 28 + 74] -> [39 - 29, 40 + 74]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #0
  BL      @v3d_setSubImage

; # Small Up Arrow Other Palette (4/0): [29 - 29, 28 + 74] -> [39 - 29, 40 + 74]
  STMEA   SP, {R9,R11}
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R3, #0
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, #0
  BL      @v3d_setSubImage

; # Small Down Arrow (5/0): [39 - 29, 28 + 74] -> [49 - 29, 40 + 74]
  STR     R9, [SP,@Ystart]
  MOV     r11, r6
  MOV     r6, #20
  STMFA   SP, {r6,r11}
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #10
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (6/0): [39 - 29, 28 + 74] -> [49 - 29, 40 + 74]
  STR     R9, [SP,@Ystart]
  STMFA   SP, {r6,r11}
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #6
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, #10
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (7/0): [39 - 29, 28 + 74] -> [49 - 29, 40 + 74]
  STR     R9, [SP,@Ystart]
  STMFA   SP, {r6,r11}
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #7
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, #10
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (8/0): [39 - 29, 28 + 74] -> [49 - 29, 40 + 74]
  STR     R9, [SP,@Ystart]
  MOV     R0, #20
  STMFA   SP, {R0,r11}
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R1, #8
  MOV     R3, #10
  BL      @v3d_setSubImage

; # Small Down Arrow Other Palette (9/0): [39 - 29, 28 + 74] -> [49 - 29, 40 + 74]
  STR     R9, [SP,@Ystart]
  MOV     R0, #20
  STMFA   SP, {R0,r11}
  STR     R5, [SP,@Xout]
  STR     R8, [SP,@Yout]
  STR     R7, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x6C]
  MOV     R1, #9
  MOV     R2, #0
  MOV     R3, #10
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage


; # Small arrow position: X_arrow = X_name + Len_in_char_name * 10 + 5
.arm
.org 0x020A800C
  MOV     R6, #4        ; Originally R0 with the number of chars.

.org 0x020A8044
  ADD     R0, R2, #0x7000   ; Shift to the position, originally 0x5000 (5)
