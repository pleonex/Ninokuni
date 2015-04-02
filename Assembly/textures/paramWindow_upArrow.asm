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

.org 0x020ADB70
; # Up (in game down) arrow to select target (0/0): [95, 0] -> [112, 17]
  STR     R4, [SP,@YStart]
  MOV     R0, #112
  STR     R0, [SP,@XEnd]
  MOV     R1, #17
  STR     R1, [SP,@YEnd]
  SUB     R0, R1, #25
  STR     R0, [SP,@XOut]
  STR     R0, [SP,@YOut]
  STR     R1, [SP,@Width]
  STR     R1, [SP,@Height]
  MOV     R0, #10
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0x60]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #95
  BL      @v3d_setSubImage

.org 0x020ADC5C
; # Up (in game down) arrow to select target (0/0): [95, 0] -> [112, 17]
  STR     R4, [SP,@YStart]
  MOV     R0, #112
  STR     R0, [SP,@XEnd]
  MOV     R1, #17
  STR     R1, [SP,@YEnd]
  SUB     R0, R1, #25
  STR     R0, [SP,@XOut]
  STR     R0, [SP,@YOut]
  STR     R1, [SP,@Width]
  STR     R1, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0x64]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #95
  BL      @v3d_setSubImage
