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

.org 0x0209A21C
; ------------------------------------------------- ;
; Status
; ------------------------------------------------- ;
; # Poison (0/0): [0, 36] -> [20 + 21, 48]
  MOV     R0, #36
  STR     R0, [SP,@YStart]
  MOV     R0, #20 + 21
  MOV     R8, #48
  STR     R0, [SP,@XEnd]
  STR     R8, [SP,@YEnd]
  SUB     R0, R8, #58
  STR     R0, [SP,@XOut]
  SUB     R6, R8, #54
  STR     R6, [SP,@YOut]
  MOV     R0, #20 + 21
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  STR     R10, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Rock (1/0): [82 - 28, 36 + 28] -> [111 - 20, 48 + 29]
  MOV     R0, #36 + 28
  MOV     r1, #111 - 20
  MOV     r2, #48 + 29
  STMIA   sp, {r0,r1,r2}
  SUB     R0, r1, #125 - 20
  STR     R0, [SP,@XOut]
  STR     R0, [SP,#0x20]
  STR     R6, [SP,@YOut]
  MOV     R0, #29 + 8
  STR     R0, [SP,@Width]
  ADD     r5, #1
  STR     R5, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, R10
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #82 - 28
  BL      @v3d_setSubImage

; # Sleepy (2/0): [0, 48] -> [28 + 6, 60 + 1]
  STR     R8, [SP,@YStart]
  MOV     R0, #28 + 6
  STR     R0, [SP,@XEnd]
  MOV     R0, #60 + 1
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,#0x20]
  MOV     R1, #2
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #28 + 6
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R2, R4
  ADD     R0, R0, #0x128
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Dizzy (3/0): [49 - 49, 36] -> [82 - 29, 48 + 29]
  MOV     R0, #36 + 28
  STR     R0, [SP,@YStart]
  MOV     r1, #82 - 29
  MOV     r2, #48 + 29
  STMFA   SP, {r1,r2}
  MOV     R0, #2
  SUB     R0, R0, #18
  STR     R0, [SP,@XOut]
  STR     R0, [SP,#0x24]
  STR     R6, [SP,@YOut]
  STR     r1, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #49 - 49
  BL      @v3d_setSubImage

; # Curse (4/0): [20 + 22, 36 - 1] -> [49 + 44, 48]
  MOV     R0, #36 - 1
  STR     R0, [SP,@YStart]
  MOV     R0, #49 + 44
  STMFA   SP, {R0,R8}
  LDR     R0, [SP,#0x20]
  MOV     R3, #20 + 22
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #29 + 22
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  BL      @v3d_setSubImage

; # Blindness (5/0): [55 + 8, 48 + 1] -> [88 + 21, 60 + 3]
  ADD     r0, r8, #1
  MOV     r1, #88 + 21
  MOV     r2, #60 + 3
  STMIA   sp, {r0,r1,r2}
  LDR     R0, [SP,#0x24]
  MOV     R1, #5
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #33 + 13
  STR     R0, [SP,@Width]
  ADD     r2, r5, #3
  STR     r2, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R2, R4
  ADD     R0, R0, #0x128
  MOV     R3, #55 + 8
  BL      @v3d_setSubImage

; # Veto (6/0): [28 + 7, 48] -> [55 + 7, 60 + 1]
  STR     R8, [SP,@YStart]
  MOV     R0, #55 + 7
  STR     R0, [SP,@XEnd]
  MOV     R0, #60 + 1
  STR     R0, [SP,@YEnd]
  MOV     R0, #55
  SUB     R0, R0, #68
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #27
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, #6
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #28 + 7
  BL      @v3d_setSubImage

; # Annul (7/0): [88 - 88, 48 + 31] -> [127 - 82, 60 + 32]
  ADD     r0, r8, #31
  STR     r0, [SP,@YStart]
  MOV     r1, #45
  STR     r1, [SP,@XEnd]
  MOV     R0, #60 + 32
  STR     R0, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     r1, [SP,@Width]
  STR     R5, [SP,@Height]
  STR     R5, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R3, #88 - 88
  MOV     R1, #7
  ADD     R0, R0, #0x128
  MOV     R2, R4
  BL      @v3d_setSubImage
