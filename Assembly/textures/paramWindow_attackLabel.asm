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

@Ystart  equ -0x58
@Xend    equ -0x54
@Yend    equ -0x50
@Xout    equ -0x4C
@Yout    equ -0x48
@Width   equ -0x44
@Height  equ -0x40
@Palette equ -0x3C
@v3d_setSubImage equ 0x020FCD7C

.arm

; # Common constants
.org 0x020A0DB4
  MOV     R8, R9        ; R9 is 0
  MOV     R4, #1

; # Spells blink 1 (0/0): [78, 56] -> [108 + 4, 68]
.org 0x020A0E64
  MOV     R0, #56
  MOV     R9, #68
  MOV     R1, #108 + 4
  STMEA   SP, {r0,r1,R9}
  SUB     R7, R9, #83 + 4
  STR     R7, [SP,#0x58+@Xout]
  SUB     R6, R9, #74
  STR     R6, [SP,#0x58+@Yout]
  MOV     R0, #30 + 4
  STR     R0, [SP,#0x58+@Width]
  MOV     R11, #12
  STR     R11, [SP,#0x58+@Height]
  MOV     R0, #9
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x3C]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, #78
  BL      @v3d_setSubImage

 ; # Skills blink 1 (1/0): [78, 68] -> [115, 80]
  STR     R9, [SP,#0x58+@Ystart]
  MOV     R0, #115
  STR     R0, [SP,#0x58+@Xend]
  MOV     R0, #80
  STR     R0, [SP,#0x58+@Yend]
  SUB     R5, R0, #97
  STR     R5, [SP,#0x58+@Xout]
  SUB     r0, r6, #1
  STR     r0, [SP,#0x58+@Yout]
  MOV     R0, #37
  STR     R0, [SP,#0x58+@Width]
  STR     R11, [SP,#0x58+@Height]
  MOV     R0, #9
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x3C]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, #78
  BL      @v3d_setSubImage

; Spells blink 2 (0/0): [78, 56] -> [108 + 4, 68]
  MOV     R0, #56
  MOV     r1, #108 + 4
  STMEA   SP, {r0,r1,R9}
  STR     R7, [SP,#0x58+@Xout]
  STR     R6, [SP,#0x58+@Yout]
  MOV     R0, #30 + 4
  STR     R0, [SP,#0x58+@Width]
  STR     R11, [SP,#0x18]
  MOV     R7, #7
  STR     R7, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x40]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, #78
  BL      @v3d_setSubImage

; Skills blink 2 (1/0): [78, 68] -> [115, 80]
  STR     R9, [SP,#0x58+@Ystart]
  MOV     R0, #115
  STR     R0, [SP,#0x58+@Xend]
  MOV     R0, #80
  STR     R0, [SP,#0x58+@Yend]
  STR     R5, [SP,#0x58+@Xout]
  SUB     r0, r6, #1
  STR     r0, [SP,#0x58+@Yout]
  MOV     R0, #37
  STR     R0, [SP,#0x58+@Width]
  STR     R11, [SP,#0x58+@Height]
  STR     R7, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x40]
  MOV     R1, R4
  MOV     R3, #78
  MOV     R2, R8
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage
