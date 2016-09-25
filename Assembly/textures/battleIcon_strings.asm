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
; # Poison (0/0): [0, 36] -> [20 + 17, 48]
  MOV     R0, #36
  STR     R0, [SP,@YStart]
  MOV     R0, #20 + 17
  MOV     R8, #48
  STR     R0, [SP,@XEnd]
  STR     R8, [SP,@YEnd]
  SUB     R0, R8, #58
  STR     R0, [SP,@XOut]
  SUB     R6, R8, #54
  STR     R6, [SP,@YOut]
  MOV     R0, #20 + 17
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  STR     R10, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Line (1/0): [82 - 27, 36 + 26] -> [111 - 31, 48 + 27]
  MOV     R0, #36 + 26
  MOV     r1, #111 - 31
  MOV     r2, #48 + 27
  STMIA   sp, {r0,r1,r2}
  SUB     R0, r1, #125 - 20
  STR     R0, [SP,@XOut]
  STR     R0, [SP,#0x20]
  STR     R6, [SP,@YOut]
  MOV     R0, #29 - 4
  STR     R0, [SP,@Width]
  ADD     r5, #1
  STR     R5, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, R10
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #82 - 27
  BL      @v3d_setSubImage

; # Sleep (2/0): [0, 48] -> [28 + 3, 60 + 1]
  STR     R8, [SP,@YStart]
  MOV     R0, #28 + 3
  STR     R0, [SP,@XEnd]
  MOV     R0, #60 + 1
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,#0x20]
  MOV     R1, #2
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #28 + 3
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R2, R4
  ADD     R0, R0, #0x128
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Confusion (3/0): [49 - 49, 36 + 26] -> [82 - 29, 48 + 27]
  MOV     R0, #36 + 26
  STR     R0, [SP,@YStart]
  MOV     r1, #82 - 29
  MOV     r2, #48 + 27
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

; # Curse (4/0): [20 + 19, 36 - 1] -> [49 + 23, 48]
  MOV     R0, #36 - 1
  STR     R0, [SP,@YStart]
  MOV     R0, #49 + 23
  STMFA   SP, {R0,R8}
  LDR     R0, [SP,#0x20]
  MOV     R3, #20 + 19
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #29 + 4
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  BL      @v3d_setSubImage

; # Blind (5/0): [55 + 21, 48] -> [88 + 21, 61]
  ADD     r0, r8, #0
  MOV     r1, #88 + 21
  MOV     r2, #60 + 1
  STMIA   sp, {r0,r1,r2}
  LDR     R0, [SP,#0x24]
  MOV     R1, #5
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #33 + 0
  STR     R0, [SP,@Width]
  ADD     r2, r5, #0
  STR     r2, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R2, R4
  ADD     R0, R0, #0x128
  MOV     R3, #55 + 21
  BL      @v3d_setSubImage

; # Disable (6/0): [28 + 5, 48] -> [55 + 19, 60 + 1]
  STR     R8, [SP,@YStart]
  MOV     R0, #55 + 19
  STR     R0, [SP,@XEnd]
  MOV     R0, #60 + 1
  STR     R0, [SP,@YEnd]
  MOV     R0, #55
  SUB     R0, R0, #68
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #41
  STR     R0, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B0]
  MOV     R1, #6
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #28 + 5
  BL      @v3d_setSubImage

; # Cancel (7/0): [88 - 88, 48 + 29] -> [127 - 90, 60 + 30]
  ADD     r0, r8, #29
  STR     r0, [SP,@YStart]
  MOV     r1, #37
  STR     r1, [SP,@XEnd]
  MOV     R0, #60 + 30
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
