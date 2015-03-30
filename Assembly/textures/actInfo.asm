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
.org 0x020A0064
; Set iterator to 0
  MOV     R0, #0
  STR     R0, [SP,#0x24]

; # Mini textbox. Loaded 4 times in each iteration / section.
@section_box:
  LDR     R1, [SP,#0x20]
  MOV     R7, -19
  LDR     R0, [SP,#0x24]
  MOV     R9, #0
  ADD     R6, R7, #13
  ADD     R5, R1, R0,LSL#3
  ADD     R11, R7, #3
  MOV     R4, R9
  MOV     R8, #13

@miniTextbox:
; # Left segment of box with i palette (i/0): [0, 0] -> [5, 13]
  STR     R4, [SP,@Ystart]
  MOV     R0, #5
  STMFA   SP, {R0,R8}
  STR     R7, [SP,@Xout]
  STR     R6, [SP,@Yout]
  STR     R0, [SP,@Width]
  ADD     R10, R9, #1
  MOV     R0, R10,LSL#16
  STR     R8, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R5,#8]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, R4
  BL      @v3d_setSubImage

; # Middle segment of box with i palette and width 32 (i/1): [6, 0] -> [14, 13]
  STR     R4, [SP,@Ystart]
  MOV     R0, #14
  STMFA   SP, {R0,R8}
  STR     R11, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #32
  STR     R0, [SP,@Width]
  MOV     R0, R10,LSL#16
  STR     R8, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R5,#8]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #1
  MOV     R3, #6
  BL      @v3d_setSubImage

; # Right segment of box with i palette (i/2): [15, 0] -> [20, 13]
  MOV     R0, R10,LSL#16
  MOV     R1, R0,ASR#16
  STR     R4, [SP,@Ystart]
  MOV     R0, #20
  STMFA   SP, {R0,R8}
  MOV     R0, #16
  STR     R0, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #5
  STR     R0, [SP,@Width]
  STR     R8, [SP,#0x18]
  STR     R1, [SP,@Palette]
  LDR     R0, [R5,#8]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #15
  BL      @v3d_setSubImage

  ; Load 4 times with different palettes
  MOV     R0, R10
  AND     R9, R0, #0xFF
  CMP     R9, #4
  BCC     @miniTextbox

  ; Load 4x3 times in different place
  LDR     R0, [SP,#0x24]
  ADD     R0, R0, #1
  AND     R0, R0, #0xFF
  STR     R0, [SP,#0x24]
  CMP     R0, #3
  BCC     @section_box

.org 0x020A01E0
; Set to 0 the iterator
  MOV     R0, #0
  STR     R0, [SP,#0x28]

@miniTextbox2_and3:
  LDR     R1, [SP,#0x20]
  LDR     R0, [SP,#0x28]
  MOV     R11, 0xFFFFFFED
  ADD     R5, R1, R0,LSL#3
  ADD     R0, R11, #3
  MOV     R10, #0
  ADD     R6, R11, #0xD
  STR     R0, [SP,#0x2C]
  MOV     R4, #5
  MOV     R7, #13

@miniTextbox2:
; # Left segment of box with i palette (i/0): [0, 0] -> [5, 13]
  STR     R9, [SP,@Ystart]
  STMFA   SP, {R4,R7}
  STR     R11, [SP,@Xout]
  STR     R6, [SP,@Yout]
  ADD     R8, R10, #5
  STR     R4, [SP,@Width]
  MOV     R0, R8,LSL#16
  STR     R7, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R5,#0xC]
  MOV     R1, R10
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Middle segment of box with i palette and width 32 (i/1): [6, 0] -> [14, 13]
  STR     R9, [SP,@Ystart]
  MOV     R0, #14
  STMFA   SP, {R0,R7}
  LDR     R0, [SP,#0x2C]
  MOV     R1, R10
  STR     R0, [SP,@Xout]
  STR     R6, [SP,@Yout]
  MOV     R0, #32
  STR     R0, [SP,@Width]
  MOV     R0, R8,LSL#16
  STR     R7, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R5,#0xC]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, #6
  BL      @v3d_setSubImage

; # Right segment of box with i palette (i/2): [15, 0] -> [20, 13]
  MOV     R0, R8,LSL#16
  MOV     R1, R0,ASR#16
  STR     R9, [SP,@Ystart]
  MOV     R0, #20
  STMFA   SP, {R0,R7}
  MOV     R0, #16
  STR     R0, [SP,@Xout]
  STR     R6, [SP,@Yout]
  STR     R4, [SP,@Width]
  STR     R7, [SP,@Height]
  STR     R1, [SP,@Palette]
  LDR     R0, [R5,#0xC]
  MOV     R1, R10
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #15
  BL      @v3d_setSubImage

; Load 5 times with different palettes
  ADD     R0, R10, #1
  AND     R10, R0, #0xFF
  CMP     R10, #5
  BCC     @miniTextbox2

; # Common constants for this part
  LDR     R1, [SP,#0x20]
  MOV     R8, 0xFFFFFFDD
  LDR     R0, [SP,#0x28]
  ADD     R7, R8, #29
  ADD     R6, R1, R0,LSL#3
  ADD     R5, R8, #3
  MOV     R11, #0

@miniTextbox3:
  CMP     R4, #8
  BNE     @miniTextbox3_otherPalette

; # Left segment of box with i palette (i/0): [0, 0] -> [5, 13]
  STR     R11, [SP,@Ystart]
  MOV     R0, #5
  STR     R0, [SP,@Xend]
  MOV     R0, #13
  STR     R0, [SP,@Yend]
  STR     R8, [SP,@Xout]
  STR     R7, [SP,@Yout]
  MOV     R0, #5
  STR     R0, [SP,@Width]
  MOV     R0, #13
  ADD     R10, R4, #2
  STR     R0, [SP,@Height]
  MOV     R0, R10,LSL#16
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0xC]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R11
  MOV     R3, R11
  BL      @v3d_setSubImage

; # Middle segment of box with i palette and width 32 (i/1): [6, 0] -> [14, 13]
  STR     R11, [SP,@Ystart]
  MOV     R0, #14
  STR     R0, [SP,@Xend]
  MOV     R0, #13
  STR     R0, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R7, [SP,@Yout]
  MOV     R0, #64
  STR     R0, [SP,@Width]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  MOV     R0, R10,LSL#16
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0xC]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, #1
  MOV     R3, #6
  BL      @v3d_setSubImage

; # Right segment of box with i palette (i/2): [15, 0] -> [20, 13]
  MOV     R0, R10,LSL#16
  MOV     R1, R0,ASR#16
  STR     R11, [SP,@Ystart]
  MOV     R0, #20
  STR     R0, [SP,@Xend]
  MOV     R0, #13
  STR     R0, [SP,@Yend]
  MOV     R0, #32
  STR     R0, [SP,@Xout]
  STR     R7, [SP,@Yout]
  MOV     R0, #5
  STR     R0, [SP,@Width]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  STR     R1, [SP,@Palette]
  B       @miniTextbox3_setEnd

@miniTextbox3_otherPalette:
; # Left segment of box with i palette (i/0): [0, 0] -> [5, 13]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #5
  STR     R0, [SP,@Xend]
  MOV     R0, #13
  STR     R0, [SP,@Yend]
  STR     R8, [SP,@Xout]
  STR     R7, [SP,@Yout]
  MOV     R0, #5
  STR     R0, [SP,@Width]
  MOV     R0, #13
  MOV     R2, #0
  ADD     R10, R4, #1
  STR     R0, [SP,@Height]
  MOV     R0, R10,LSL#16
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0xC]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R3, R2
  BL      @v3d_setSubImage

; # Middle segment of box with i palette and width 32 (i/1): [6, 0] -> [14, 13]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #14
  STR     R0, [SP,@Xend]
  MOV     R0, #13
  STR     R0, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R7, [SP,@Yout]
  MOV     R0, #64
  STR     R0, [SP,@Width]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  MOV     R0, R10,LSL#16
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R6,#0xC]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, #1
  MOV     R3, #6
  BL      @v3d_setSubImage

; # Right segment of box with i palette (i/2): [15, 0] -> [20, 13]
  MOV     R1, #0
  STR     R1, [SP,@Ystart]
  MOV     R1, #20
  STR     R1, [SP,@Xend]
  MOV     R1, #13
  STR     R1, [SP,@Yend]
  MOV     R1, #32
  STR     R1, [SP,@Xout]
  MOV     R0, R10,LSL#16
  STR     R7, [SP,@Yout]
  MOV     R1, #5
  STR     R1, [SP,@Width]
  MOV     R1, #13
  MOV     R0, R0,ASR#16
  STR     R1, [SP,@Height]
  STR     R0, [SP,@Palette]

@miniTextbox3_setEnd:
  LDR     R0, [R6,#0xC]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #15
  BL      @v3d_setSubImage

; Load 4 times with different palettes
  ADD     R0, R4, #1
  AND     R4, R0, #0xFF
  CMP     R4, #9
  BCC     @miniTextbox3

  LDR     R0, [SP,#0x28]
  MOV     R4, #20
  ADD     R0, R0, #1
  AND     R0, R0, #0xFF
  STR     R0, [SP,#0x28]
  CMP     R0, #3
  MOV     R10, #1
  MOV     R8, #0
  BCC     @miniTextbox2_and3

; # Common constants
  MOV     R9, R8
  MOV     R7, #31
  MOV     R6, #11
  MOV     R5, 0xFFFFFFFB

.org 0x020A0558
; # 3x Arrow (0/0): [20, 0] -> [31, 11]
  STR     R8, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R5, [SP,@Yout]
  STR     R6, [SP,@Width]
  LDR     R0, [SP,#0x20]
  STR     R6, [SP,@Height]
  STR     R10, [SP,@Palette]
  ADD     R0, R0, R9,LSL#2
  LDR     R0, [R0,#0x20]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, R4
  BL      @v3d_setSubImage

  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #3
  ; A loop jump
