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

.thumb

; # Small Down Arrow Palette 1 (0/0): [74, 3] -> [85, 14]
.org 0x02083F2A
  MOV     R7, #3
  MOV     R6, #14
  STR     R7, [SP,@Ystart]
  MOV     R0, #85
  STR     R0, [SP,@Xend]
  MOV     R0, #14
  STR     R0, [SP,@Yend]
  SUB     R6, #19
  STR     R6, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #11
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LSL     R4, R1, #2
  MOV     R0, #0x55
  LDR     R1, [R5,R4]
  ADD     R0, #0xD3
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
  MOV     R3, #74
  BLX     @v3d_setSubImage

; # Small Down Arrow Palette 2 (1/0): [74, 3] -> [85, 14]
  STR     R7, [SP,@Ystart]
  MOV     R0, #85
  STR     R0, [SP,@Xend]
  MOV     R0, #14
  STR     R0, [SP,@Yend]
  STR     R6, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #11
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  MOV     R0, #0x4A
  LDR     R1, [R5,R4]
  ADD     R0, #0xDE
  ADD     R0, R1, R0
  MOV     R1, #1
  MOV     R2, #0
  MOV     R3, #74
  BLX     @v3d_setSubImage

; # Small Down Arrow Palette 3 (2/0): [74, 3] -> [85, 14]
  STR     R7, [SP,@Ystart]
  MOV     R0, #85
  STR     R0, [SP,@Xend]
  MOV     R0, #14
  STR     R0, [SP,@Yend]
  STR     R6, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #11
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]
  STR     R7, [SP,@Palette]
  MOV     R0, #0x4A
  LDR     R1, [R5,R4]
  ADD     R0, #0xDE
  ADD     R0, R1, R0
  MOV     R1, #2
  MOV     R2, #0
  MOV     R3, #74
  BLX     @v3d_setSubImage

; # Small Down Arrow Palette 4 (3/0): [74, 3] -> [85, 14]
  STR     R7, [SP,@Ystart]
  MOV     R0, #85
  STR     R0, [SP,@Xend]
  MOV     R0, #14
  STR     R0, [SP,@Yend]
  STR     R6, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #11
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  MOV     R0, #0x4A
  LDR     R1, [R5,R4]
  ADD     R0, #0xDE
  ADD     R0, R1, R0
  MOV     R1, #3
  MOV     R2, #0
  MOV     R3, #74
  BLX     @v3d_setSubImage
