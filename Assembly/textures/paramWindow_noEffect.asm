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

.org 0x0209A4A8
; # Without effect (0/0): [0, 104 + 1] -> [56 + 3, 118 + 1]
  MOV     R1, #118 + 1
  MOV     R2, #56 + 3
  ADD     r0, r11, #1
  STMIA   sp, {r0,r2}
  STR     R1, [SP,@YEnd]
  SUB     R0, R1, #146 + 1
  STR     R0, [SP,@XOut]
  SUB     R8, R1, #125 + 1
  STR     R8, [SP,@YOut]
  STR     R2, [SP,@Width]
  MOV     R0, #14
  STR     R0, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B4]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage
