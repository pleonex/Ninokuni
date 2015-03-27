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

@Ystart  equ -0x38
@Xend    equ -0x34
@Yend    equ -0x30
@Xout    equ -0x2C
@Yout    equ -0x28
@Width   equ -0x24
@Height  equ -0x20
@Palette equ -0x1C

.thumb

; # Super Skill (0/0): [56 + 4, 104] -> [112 + 4, 128]
.org 0x02084050
  MOV     R0, #104
  STR     R0, [SP,#0x38+@Ystart]
  MOV     R0, #112 + 4
  STR     R0, [SP,#0x38+@Xend]
  MOV     R1, #128
  STR     R1, [SP,#0x38+@Yend]
  SUB     r1, #156
  STR     r1, [SP,#0x38+@Xout]
  ADD     r1, #16
  STR     R1, [SP,#0x38+@Yout]
  MOV     r3, #56 + 4
  MOV     r0, #56
  STR     r0, [SP,#0x38+@Width]
  MOV     R0, #24
  STR     R0, [SP,#0x38+@Height]
  MOV     R0, #14
  STR     R0, [SP,#0x38+@Palette]
  MOV     R0, #0x38
  LDR     R1, [R5,R4]
  ADD     R0, #0xF0
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
