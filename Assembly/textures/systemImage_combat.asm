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

.org 0x0209A534
; # Attack string (0/0): [0, 0] -> [31, 13]
  STR     R4, [SP,@YStart]
  MOV     R0, #31
  STR     R0, [SP,@XEnd]
  MOV     R0, #13
  STR     R0, [SP,@YEnd]
  SUB     R11, R0, #34
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #31
  STR     R0, [SP,@Width]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  STR     R10, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Defense string (1/0): [0, 13] -> [29, 26]
  MOV     R0, #13
  STR     R0, [SP,@YStart]
  MOV     R0, #29
  STR     R0, [SP,@XEnd]
  MOV     R0, #26
  STR     R0, [SP,@YEnd]
  MOV     R0, #13
  SUB     R7, R0, #33
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #29
  STR     R0, [SP,@Width]
  MOV     r7, #13
  STR     r7, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R1, R10
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Magic Attack string (2/0): [0, 26] -> [29 + 11, 39]
  MOV     R0, #26
  STR     R0, [SP,@YStart]
  MOV     R0, #29 + 11
  STR     R0, [SP,@XEnd]
  STR     R0, [SP,@Width]
  MOV     R0, #39
  STR     R0, [SP,@YEnd]
  SUB     r0, r7, #33 + 11
  STR     r0, [SP,@XOut]
  STR     R6, [SP,@YOut]
;  MOV     R0, #13
  STR     r7, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Magic Defense string (3/0): [0, 39] -> [31 + 7, 52]
  MOV     R0, #39
  STR     R0, [SP,@YStart]
  MOV     R0, #31 + 7
  STR     R0, [SP,@XEnd]
  STR     R0, [SP,@Width]
  MOV     R0, #52
  STR     R0, [SP,@YEnd]
  SUB     r0, r11, #4
  STR     r0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Agility string (4/0): [29, 15] -> [60, 28]
  MOV     R7, #15
  STR     R7, [SP,@YStart]
  MOV     R0, #60
  STR     R0, [SP,@XEnd]
  MOV     R0, #31
  STR     R0, [SP,@Width]
  MOV     R0, #28
  STR     R0, [SP,@YEnd]
;  SUB     r0, r11, #5
  STR     r11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R3, #29
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  BL      @v3d_setSubImage

; # Without Changes string (5/0): [0, 52] -> [46, 64]
  MOV     R0, #52
  STR     R0, [SP,@YStart]
  MOV     R1, #46
  STR     R1, [SP,@XEnd]
  MOV     R0, #64
  STR     R0, [SP,@YEnd]
  SUB     R0, R1, #75
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R1, [SP,@Width]
  MOV     R5, 12
  STR     R5, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1B8]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

.org 0x0209A764
; # Big Up Arrow Palette 1 (0/0): [31, 0] -> [43, 15]
  MOV     r5, #43
  MOV     r4, #0
  MOV     r7, r6
  MOV     r6, #15
  MOV     r11, #15
  MOV     r10, #12
  STMIA   sp, {r4,r5,r6,r7,r8,r10}
  STR     r11, [SP,@Height]
  MOV     r0, #1
  STR     r0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #0
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #31
  BL      @v3d_setSubImage

; # Big Up Arrow Palette 2 (1/0): [31, 0] -> [43, 15]
  STMEA   SP, {r4,r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #31
  BL      @v3d_setSubImage

; # Big Up Arrow Palette 3 (2/0): [31, 0] -> [43, 15]
  STMEA   SP, {r4,r5}
  STR     r6, [SP,@YEnd]
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #31
  BL      @v3d_setSubImage

; # Big Up Arrow Palette 4 (3/0): [31, 0] -> [43, 15]
  STMEA   SP, {r4,r5}
  STR     r6, [SP,@YEnd]
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #3
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #31
  BL      @v3d_setSubImage

; # Big Up Arrow Palette 5 (4/0): [31, 0] -> [43, 15]
  STMEA   SP, {r4,r5}
  STR     r6, [SP,@YEnd]
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R3, #31
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, #0
  BL      @v3d_setSubImage

; # Big Down Arrow Palette 1 (5/0): [43, 0] -> [55, 15]
  MOV     r5, #55
  STMIA   SP, {r4,r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     r0, #1
  STR     r0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #43
  BL      @v3d_setSubImage

; # Big Down Arrow Palette 2 (6/0): [43, 0] -> [55, 15]
  STR     R4, [SP,@YStart]
  NOP
  STMFA   SP, {r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #6
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, #43
  BL      @v3d_setSubImage

; # Big Down Arrow Palette 3 (7/0): [43, 0 ] -> [55, 15]
  STR     R4, [SP,@YStart]
  NOP
  STMFA   SP, {r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #7
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, #43
  BL      @v3d_setSubImage

; # Big Down Arrow Palette 4 (8/0): [43, 0] -> [55, 15]
  STR     R4, [SP,@YStart]
  NOP
  STMFA   SP, {r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R1, #8
  MOV     R2, #0
  ADD     R0, R0, #0x128
  MOV     R3, #43
  BL      @v3d_setSubImage

; # Big Down Arrow Palette 5 (9/0): [43, 0] -> [55, 15]
  STR     R4, [SP,@YStart]
  NOP
  STMFA   SP, {r5,r6}
  STR     r7, [SP,@XOut]
  STR     R8, [SP,@YOut]
  STR     r10, [SP,@Width]
  STR     r11, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1BC]
  MOV     R3, #43
  MOV     R2, #0
  MOV     R1, #9
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage
