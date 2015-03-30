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

; # Common constants
.org 0x020AA6A4
  MOV     R8, #8
  MOV     R9, #0

; # Common constants
.org 0x020AA6F4
  MOV     R7, #2

; # Return Button Palette 6 (0/0): [0, 2] -> [29, 29]
.org 0x020AA714
  MOV     R6, #29
  STR     R7, [SP,@Ystart]
  STR     R6, [SP,@Xend]
  STR     R6, [SP,@Yend]
  SUB     R5, R6, #43
  STR     R5, [SP,@Xout]
  SUB     R4, R6, #42
  STR     R4, [SP,@Yout]
  STR     R6, [SP,@Width]
  MOV     R11, #27
  STR     R11, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0xC]
  MOV     R1, R9
  ADD     R0, R0, #0x1A8
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Return Button Palette 7 (1/0): [0, 2] -> [29, 29]
  STR     R7, [SP,@Ystart]
  STR     R6, [SP,@Xend]
  MOV     R0, #6
  STR     R6, [SP,@Yend]
  SUB     R0, R0, #18
  STR     R0, [SP,@Xout]
  MOV     R0, 0xFFFFFFF5
  STR     R0, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R11, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0xC]
  MOV     R1, #1
  ADD     R0, R0, #0x1A8
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; # Return Button Palette 8 (2/0): [0, 2] -> [29, 29]
  STR     R7, [SP,@Ystart]
  STR     R6, [SP,@Xend]
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R4, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R11, [SP,@Height]
  STR     R8, [SP,@Palette]
  LDR     R0, [R10,#0xC]
  MOV     R1, R7
  MOV     R2, R9
  MOV     R3, R9
  ADD     R0, R0, #0x1A8
  MOV     R4, #1
  BL      @v3d_setSubImage

; # New Constans
  MOV     R8, R9
  MOV     R7, #53
  MOV     R6, #10
  MOV     R5, #7
  MOV     R11, #8

@setButtonB:
  CMP     R9, #1
  MOV     R3, #43
  BNE     @buttonBcase2_3

; # First B Button (i/0): [43, 0] -> [53, 10]
  STR     R8, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  STR     R6, [SP,@Yend]
  STR     R5, [SP,@Xout]
  STR     R11, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R6, [SP,@Height]
  B       @button_set

@buttonBcase2_3:
  CMP     R9, #2
  BNE     @buttonBcase3

; # Second B Button (i/0): [43, 10] -> [53, 20]
  MOV     R0, #10
  STR     R0, [SP,@Ystart]
  MOV     R0, #53
  STR     R0, [SP,@Xend]
  MOV     R0, #20
  B       @button_common

@buttonBcase3:
; # First B Button (i/0): [43, 0] -> [53, 10]
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #53
  STR     R0, [SP,@Xend]
  MOV     R0, #10

@button_common:
  STR     R0, [SP,@Yend]
  MOV     R0, #5
  STR     R0, [SP,@Xout]
  MOV     R0, #6
  STR     R0, [SP,@Yout]
  MOV     R0, #10
  STR     R0, [SP,@Width]
  STR     R0, [SP,@Height]

@button_set:
  MOV     R0, #12
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0xC]
  MOV     R1, R9
  ADD     R0, R0, #0x1A8
  MOV     R2, R4
  BL      @v3d_setSubImage

  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #3
  BCC     @setButtonB
