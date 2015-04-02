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

.org 0x020AD538
; # L Button (0/0): [29, 0] -> [43, 14]
  STR     R6, [SP,@YStart]
  MOV     R9, #43
  MOV     R8, #14
  STR     R9, [SP,@XEnd]
  STR     R8, [SP,@YEnd]
  SUB     R7, R8, #0x15
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  STR     R4, [SP,@Palette]
  LDR     R0, [R10,#0x48]
  MOV     R1, R6
  MOV     R2, R6
  ADD     R0, R0, #0x1A8
  MOV     R3, #29
  BL      @v3d_setSubImage

; # L Button (1/0): [29, 0] -> [43, 14]
  STMEA   SP, {R6,R9}
  STR     R8, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x48]
  MOV     R1, R4
  ADD     R0, R0, #0x1A8
  MOV     R2, R6
  MOV     R3, #29
  BL      @v3d_setSubImage

; # L Button (2/0): [29, 0] -> [43, 14]
  STMEA   SP, {R6,R9}
  STR     R8, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  STR     R5, [SP,@Palette]
  LDR     R0, [R10,#0x48]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, R6
  MOV     R3, #29
  BL      @v3d_setSubImage

; # R Button (0/0): [29, 15] -> [43, 29]
  MOV     R11, #15
  STR     R11, [SP,@YStart]
  STR     R9, [SP,@XEnd]
  MOV     R0, #29
  STR     R0, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  STR     R4, [SP,@Palette]
  LDR     R0, [R10,#0x4C]
  MOV     R1, R6
  ADD     R0, R0, #0x1A8
  MOV     R2, R6
  MOV     R3, #29
  BL      @v3d_setSubImage

; # R Button (1/0): [29, 15] -> [43, 29]
  STR     R11, [SP,@YStart]
  STR     R9, [SP,@XEnd]
  MOV     R0, #29
  STR     R0, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x4C]
  MOV     R1, R4
  ADD     R0, R0, #0x1A8
  MOV     R2, R6
  MOV     R3, #29
  BL      @v3d_setSubImage

; # R Button (2/0): [29, 15] -> [43, 29]
  STR     R11, [SP,@YStart]
  MOV     R0, #29
  STR     R9, [SP,@XEnd]
  STR     R0, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R7, [SP,@YOut]
  STR     R8, [SP,@Width]
  STR     R8, [SP,@Height]
  STR     R5, [SP,@Palette]
  MOV     R3, R0
  LDR     R0, [R10,#0x4C]
  MOV     R1, #2
  MOV     R2, R6
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage
