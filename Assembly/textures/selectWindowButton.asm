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
.org 0x020AA9C0
; ------------------------------------------------- ;
; Attack subtitle
; ------------------------------------------------- ;
; # Left arrow/box (0/0): [67, 14] -> [77, 32]
  MOV     R8, #32
  MOV     R9, #14
  MOV     R1, #0
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STR     R0, [SP,@XEnd]
  STR     R8, [SP,@YEnd]
  SUB     R7, R8, #72
  STR     R7, [SP,@XOut]
  SUB     R6, R8, #41
  STR     R6, [SP,@YOut]
  MOV     R5, #10
  STR     R5, [SP,@Width]
  MOV     R4, #18
  STR     R4, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (0/1): [77, 14] -> [83, 32]
  MOV     R0, #83
  STR     R9, [SP,@YStart]
  STMFA   SP, {R0,R8}
  SUB     R11, R0, #113
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #0
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (0/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #0
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Attack string (0/3): [20, 0] -> [67, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #67
  STMFA   SP, {R0,R9}
  MOV     R0, #2
  SUB     R0, R0, #24 + 2
  STR     R0, [SP,0x20]
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  SUB     R0, R0, #9
  STR     R0, [SP,0x24]
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #0
  ADD     R0, R0, #0x1A8
  MOV     R2, #3
  MOV     R3, #20
  BL      @v3d_setSubImage

; # X button (0/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #0
  ADD     R0, R0, #0x1A8
  MOV     R2, #4
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Attack subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (1/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (1/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  MOV     R1, #1
  STR     R4, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (1/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Attack string (1/3): [20, 0] -> [67, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #67
  STMFA   SP, {R0,R9}
  LDR     R0, [SP,#0x20]
  MOV     R1, #1
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #20
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (1/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,#0x10]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, #4
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Attack subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (2/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (2/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (2/2): [83, 14] -> [93, 32]
  MOV     R1, #2
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Attack string (2/3): [20, 0] -> [67, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #67
  STMFA   SP, {R0,R9}
  LDR     R0, [SP,0x20]
  MOV     R1, #2
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,0x24]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #20
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (2/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, #4
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Health subtitle
; ------------------------------------------------- ;
; # Left arrow/box (3/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #8
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (3/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #8
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (3/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #8
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Heath string (3/3): [20, 15] -> [67, 29]
  MOV     R0, #15
  MOV     r1, #67
  STMIA   sp, {r0,r1}
  MOV     R0, #29
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,#0x20]
  MOV     R1, #3
  ;SUB     r0, #5
  NOP
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R2, R1
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #8
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #20
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (3/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #3
  ADD     R0, R0, #0x1A8
  MOV     R2, #4
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Health subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (4/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (4/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (4/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Heath string (4/3): [20, 15] -> [67, 14]
  MOV     R0, #15
  MOV     r1, #67
  STMIA   sp, {r0,r1}
  MOV     R0, #29
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,0x20]
  MOV     R1, #4
  ;SUB     r0, #5
  NOP
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,0x24]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #20
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (4/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  MOV     R1, #4
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Health subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (5/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (5/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (5/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Heath string (5/3): [20, 15] -> [67, 14]
  MOV     R0, #15
  MOV     r1, #67
  STMIA   sp, {r0,r1}
  MOV     R0, #29
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,#0x20]
  MOV     R3, #20
  ;SUB     r0, #7
  NOP
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R1, #5
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, #3
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (5/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #5
  MOV     R2, #4
  ADD     R0, R0, #0x1A8
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Help subtitle
; ------------------------------------------------- ;
; # Left arrow/box (6/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #6
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (6/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #6
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (6/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #6
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Help string (6/3): [67, 0] -> [114, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #114
  STMFA   SP, {R0,R9}
  LDR     R0, [SP,#0x20]
  MOV     R1, #6
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #11
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #67
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (6/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #6
  MOV     R2, #4
  ADD     R0, R0, #0x1A8
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Help subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (7/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #7
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (7/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #7
  ADD     R0, R0, #0x1A8
  MOV     R2, #1
  MOV     R3, #77
  BL      @v3d_setSubImage

; # Right arrow/box (7/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #7
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #83
  BL      @v3d_setSubImage

; # Help string (7/3): [67, 0] -> [114, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #114
  STMFA   SP, {R0,R9}
  LDR     R0, [SP,#0x20]
  MOV     R1, #7
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #67
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (7/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #7
  MOV     R2, #4
  ADD     R0, R0, #0x1A8
  MOV     R3, #93
  BL      @v3d_setSubImage

; ------------------------------------------------- ;
; Help subtitle (other palette)
; ------------------------------------------------- ;
; # Left arrow/box (8/0): [67, 14] -> [77, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #77
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #8
  ADD     R0, R0, #0x1A8
  MOV     R2, #0
  MOV     R3, #67
  BL      @v3d_setSubImage

; # Box (8/1): [77, 14] -> [83, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #83
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #60
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R2, #1
  MOV     R3, #77
  MOV     R1, #8
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # Right arrow/box (8/2): [83, 14] -> [93, 32]
  STR     R9, [SP,@YStart]
  MOV     R0, #93
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  STR     R6, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R4, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R3, #83
  MOV     R1, #8
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  BL      @v3d_setSubImage

; # Help string (8/3): [67, 0] -> [114, 14]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #114
  STMFA   SP, {R0,R9}
  LDR     R0, [SP,#0x20]
  MOV     R2, #3
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x24]
  MOV     R3, #67
  STR     R0, [SP,@YOut]
  MOV     R0, #47
  STR     R0, [SP,@Width]
  STR     R9, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #8
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage

; # X button (8/4): [93, 22] -> [103, 32]
  MOV     R0, #22
  STR     R0, [SP,@YStart]
  MOV     R0, #103
  STMFA   SP, {R0,R8}
  MOV     R0, #30
  STR     R0, [SP,@XOut]
  MOV     R0, #2
  STR     R0, [SP,@YOut]
  STR     R5, [SP,@Width]
  STR     R5, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x10]
  MOV     R1, #8
  MOV     R2, #4
  MOV     R3, #93
  ADD     R0, R0, #0x1A8
  BL      @v3d_setSubImage
