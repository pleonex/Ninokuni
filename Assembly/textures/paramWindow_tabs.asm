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

; # Team tabs (i/0)
; Xend, Xout, Width, Palette are common.
.org 0x020A703C
  MOV     R6, -37
  MOV     R9, #0
  ADD     R4, R6, #19               ; Non selected
  ADD     R5, R6, #15               ; Selected
  MOV     R8, #58
  MOV     R7, #77
  MOV     R11, #79

@TabLoop:
  MOV     R2, R9,LSR#31
  MOV     R0, R9,ASR#1              ; For palette (1)
  RSB     R1, R2, R9,LSL#31
  ADD     R1, R2, R1,ROR#31
  ADD     R0, R0, #1                ; (1) ...
  AND     R0, R0, #0xFF             ; (1) ...
  CMP     R1, #1
  MOV     R2, #0
  BNE     @TabNonSelected
  STR     R8, [SP,@Ystart]
  STMFA   SP, {R7,R11}
  STR     R6, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R7, [SP,@Width]
  MOV     R1, #21
  B       @SetTab

@TabNonSelected:
  MOV     R1, #81
  STR     R1, [SP,@Ystart]
  MOV     R1, #77
  STR     R1, [SP,@Xend]
  MOV     R1, #101
  STR     R1, [SP,@Yend]
  STR     R6, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R1, #77
  STR     R1, [SP,@Width]
  MOV     R1, #20

@SetTab:
  STR     R1, [SP,@Height]
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x5C]
  MOV     R1, R9
  ADD     R0, R0, #0x1A8
  MOV     R3, R2
  BL      @v3d_setSubImage
  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #8
  BCC     @TabLoop

; # HP image (0/0): [77, 19] -> [91, 28]
.org 0x020A7118
  MOV     R9, #28
  MOV     R6, #19
  MOV     R1, #0
  STR     R6, [SP,@Ystart]
  MOV     R0, #91
  STMFA   SP, {R0,R9}
  SUB     R8, R9, #0x22
  STR     R8, [SP,@Xout]
  SUB     R5, R9, #0x20
  STR     R5, [SP,@Yout]
  MOV     R4, #14
  STR     R4, [SP,@Width]
  MOV     R0, #9
  STR     R0, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x60]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, #77
  BL      @v3d_setSubImage

; # MP image (0/0): [92, 19] -> [106, 28]
  MOV     R1, #0
  STR     R6, [SP,@Ystart]
  MOV     R0, #106
  STMFA   SP, {R0,R9}
  STR     R8, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R4, [SP,@Width]
  MOV     R0, #9
  STR     R0, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x64]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, #92
  BL      @v3d_setSubImage

; # Sword icon (0/0): [0, 0] -> [16, 16]
.org 0x020A71D0
  MOV     R1, #0
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R6, #16
  STR     R6, [SP,@Xend]
  STR     R6, [SP,@Yend]
  SUB     R5, R6, #0x18
  STR     R5, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x68]
  MOV     R2, R1
  ADD     R0, R0, #0x128
  MOV     R3, R1
  BL      @v3d_setSubImage

; # Shield icon (1/0): [16, 0] -> [32, 16]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R4, #32
  STMFA   SP, {R4,R6}
  STR     R5, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x68]
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, R6
  BL      @v3d_setSubImage

; # Wand icon (2/0): [32, 0] -> [48, 16]
  MOV     R0, #0
  MOV     R3, R4
  STR     R0, [SP,@Ystart]
  MOV     R4, #48
  STMFA   SP, {R4,R6}
  STR     R5, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x68]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, #0
  BL      @v3d_setSubImage

; # Bag icon (3/0): [48, 0] -> [64, 16]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #64
  STMFA   SP, {R0,R6}
  STR     R5, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x68]
  MOV     R3, R4
  ADD     R0, R0, #0x128
  MOV     R1, #3
  MOV     R2, #0
  BL      @v3d_setSubImage
