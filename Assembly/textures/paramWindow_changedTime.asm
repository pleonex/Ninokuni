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

; # Changed times box (0/0): [78, 81] -> [127, 103]
.org 0x0209F5D4
  MOV     R0, #81
  STR     R0, [SP,@Ystart]
  MOV     R0, #127
  STR     R0, [SP,@Xend]
  MOV     R1, #103
  STR     R1, [SP,@Yend]
  SUB     R0, R1, #127
  STR     R0, [SP,@Xout]
  SUB     R0, R1, #114
  STR     R0, [SP,@Yout]
  MOV     R0, #49
  STR     R0, [SP,@Width]
  MOV     R0, #22
  STR     R0, [SP,@Height]
  MOV     R0, #15
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x2C]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, #78
  BL      @v3d_setSubImage
