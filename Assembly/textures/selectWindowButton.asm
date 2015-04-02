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

.org 0x020AB7FC
; # Common constants
  MOV     R9, #0
  ADD     R0, R0, #0x15
  STR     R0, [SP,#0x5C]
  LDR     R0, [SP,#0x64]
  MOV     R4, #8
  ADD     R5, R0, #0x33
  ADD     R0, R0, #0x1B
  STR     R0, [SP,#0x60]
  MOV     R8, R9
  MOV     R7, #6
  MOV     R6, #26
  MOV     R11, #14

.org 0x020AB8B8
; ------------------------------------------------- ;
; Text box palette 1, pos from 0x5C
; ------------------------------------------------- ;
; # First part (0/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R8
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (0/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R8
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (0/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R8
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 2, pos from 0x5C
; ------------------------------------------------- ;
; # First part (1/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (1/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  MOV     R1, #1
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (1/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x5C
; ------------------------------------------------- ;
; # First part (2/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (2/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (2/2): [14, 0] -> [20, 26]
  MOV     R1, #2
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 1, pos from 0x64
; ------------------------------------------------- ;
; # First part (3/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #3
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (3/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (3/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 2, pos from 0x64
; ------------------------------------------------- ;
; # First part (4/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #4
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (4/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (4/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x64
; ------------------------------------------------- ;
; # First part (5/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #5
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (5/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (5/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 5, pos from 0x64
; ------------------------------------------------- ;
; # First part (6/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, R7
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (6/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R7
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (6/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R7
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 6, pos from 0x64
; ------------------------------------------------- ;
; # First part (7/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #7
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R7, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (7/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R7, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #7
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (7/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R7, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #7
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x64
; ------------------------------------------------- ;
; # First part (8/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, R4
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (8/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R4
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (8/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R4
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 8, pos from 0x64
; ------------------------------------------------- ;
; # First part (9/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #9
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R4, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (9/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R4, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #9
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (9/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R4, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #9
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 9, pos from 0x64
; ------------------------------------------------- ;
; # First part (10/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #10
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (10/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #10
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (10/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #10
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x64
; ------------------------------------------------- ;
; # First part (11/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #11
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (11/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #11
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (11/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #11
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 11, pos from 0x64
; ------------------------------------------------- ;
; # First part (12/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #12
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (12/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #12
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (12/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #12
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R1
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 12, pos from 0x64
; ------------------------------------------------- ;
; # First part (13/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #13
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (13/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #13
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (10/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #13
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x64
; ------------------------------------------------- ;
; # First part (14/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, R11
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (14/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R11
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (14/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, R11
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 14, pos from 0x64
; ------------------------------------------------- ;
; # First part (15/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #15
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (15/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #15
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (15/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #15
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 15, pos from 0x64
; ------------------------------------------------- ;
; # First part (16/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #16
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #15
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (16/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #15
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #16
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (16/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #15
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #16
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x64
; ------------------------------------------------- ;
; # First part (17/0): [0, 0] -> [8, 26]
  STR     R8, [SP,@YStart]
  STMFA   SP, {R4,R6}
  LDR     R0, [SP,#0x64]
  MOV     R1, #17
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R2, R8
  ADD     R0, R0, #0x1A8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 112 (17/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x68]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #17
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (17/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R4, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #17
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 17, pos from 0x5C
; ------------------------------------------------- ;
; # First part (18/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #18
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (18/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #18
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (18/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #18
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 18, pos from 0x5C
; ------------------------------------------------- ;
; # First part (19/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #18
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #19
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (19/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #0x12
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #19
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (19/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #18
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #19
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x5C
; ------------------------------------------------- ;
; # First part (20/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #20
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (20/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #20
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (20/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #20
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 20, pos from 0x5C
; ------------------------------------------------- ;
; # First part (21/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #20
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #21
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (21/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #20
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #21
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (21/2): [12, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #20
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #21
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 17, pos from 0x5C
; ------------------------------------------------- ;
; # First part (22/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #22
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (22/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #22
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (20/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #17
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #22
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 4, pos from 0x5C
; ------------------------------------------------- ;
; # First part (23/0): [0, 0] -> [6, 26]
  STR     R8, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x5C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #23
  ADD     R0, R0, #0x1A8
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage

; # Second part, width 74 (23/1): [6, 0] -> [14, 26]
  STMEA   SP, {R8,R11}
  LDR     R0, [SP,#0x60]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #74
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #23
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (23/2): [14, 0] -> [20, 26]
  STR     R8, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #37
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R9,LSL#2
  LDR     R0, [R0,#0x14]
  MOV     R1, #23
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, R11
  BL      @v3d_setSubImage

; So... you have just reach to here, right? SO LET'S START AGAIN
  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #6
  BCC     0x020AB82C

; # Common constants for next part
  MOV     R4, 0xFFFFFFC0
  ADD     R0, R4, #8
  STR     R0, [SP,#0x74]
  ADD     R0, R4, #22
  STR     R0, [SP,#0x6C]
  ADD     R0, R4, #28
  ADD     R5, R4, #51
  STR     R0, [SP,#0x70]
  MOV     R11, #3
  MOV     R9, #0
  MOV     R7, #6
  MOV     R6, #26

.org 0x020ACBFC
; ------------------------------------------------- ;
; Text box palette 3, pos from 0x6C
; ------------------------------------------------- ;
; # First part (0/0): [0, 0] -> [6, 26]
  STR     R9, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x6C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 72 (0/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x70]
  MOV     R1, R9
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #72
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (0/2): [14, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #36
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #14
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 3
; ------------------------------------------------- ;
; # First part (1/0): [0, 0] -> [8, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #8
  STMFA   SP, {R0,R6}
  STR     R4, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 112 (1/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x74]
  MOV     R1, #1
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (1/2): [12, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,#0x14]
  STR     R6, [SP,@Height]
  STR     R11, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 7
; ------------------------------------------------- ;
; # First part (2/0): [0, 0] -> [8, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #8
  STMFA   SP, {R0,R6}
  STR     R4, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 112 (2/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x74]
  MOV     R1, #2
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (20/2): [12, 0] -> [20, 26]
  MOV     R1, #2
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 10
; ------------------------------------------------- ;
; # First part (3/0): [0, 0] -> [8, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #8
  STMFA   SP, {R0,R6}
  STR     R4, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #10
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R11
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 112 (3/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x74]
  MOV     R1, R11
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #10
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (3/2): [12, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #10
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R11
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 13
; ------------------------------------------------- ;
; # First part (4/0): [0, 0] -> [8, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #8
  STMFA   SP, {R0,R6}
  STR     R4, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #13
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 112 (4/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x74]
  MOV     R1, #4
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #13
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (4/2): [12, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #13
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #4
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 16
; ------------------------------------------------- ;
; # First part (5/0): [0, 0] -> [8, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #8
  STMFA   SP, {R0,R6}
  STR     R4, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #16
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 112 (5/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x74]
  MOV     R1, #5
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #112
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #16
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (5/2): [12, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #56
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #16
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, #5
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #12
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Text box palette 19, pos from 0x64
; ------------------------------------------------- ;
; # First part (6/0): [0, 0] -> [6, 26]
  STR     R9, [SP,@YStart]
  STR     R7, [SP,@XEnd]
  LDR     R0, [SP,#0x6C]
  STR     R6, [SP,@YEnd]
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #19
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R7
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Second part, width 72 (6/1): [6, 0] -> [14, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #14
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x70]
  MOV     R1, R7
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #72
  STR     R0, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #19
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, R7
  BL      @v3d_setSubImage

; # Third part (6/2): [14, 0] -> [20, 26]
  STR     R9, [SP,@YStart]
  MOV     R0, #20
  STMFA   SP, {R0,R6}
  MOV     R0, #36
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  STR     R7, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #19
  STR     R0, [SP,@Palette]
  ADD     R0, R10, R8,LSL#2
  LDR     R0, [R0,#0x2C]
  MOV     R1, R7
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #14
  BL      @v3d_setSubImage

; Again 6 more times, yeah!
  ADD     R0, R8, #1
  AND     R8, R0, #0xFF
  CMP     R8, #6
  BCC     0x020ACBB8

; The f**cking end of file
