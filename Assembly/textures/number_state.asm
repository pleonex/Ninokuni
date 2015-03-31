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

.org 0x02084834
@mediumNum:
  CMP     R4, #5
  BCS     @mediumNum_row2

; Constant for the first row
  MOV     R0, #43
  STR     R0, [SP,0x24]
  MOV     R0, #13
  MUL     R0, R4
  LSL     R0, R0, #0x10
  ASR     R7, R0, #0x10
  MOV     R0, #52
  STR     R0, [SP,0x20]
  ADD     R1, R4, #1
  B       @mediumNum_set

@mediumNum_row2:
  MOV     R0, #53
  STR     R0, [SP,0x24]
  SUB     R1, R4, #5
  MOV     R0, #13
  MUL     R0, R1
  LSL     R0, R0, #0x10
  ASR     R7, R0, #0x10
  MOV     R0, #62
  STR     R0, [SP,0x20]
  SUB     R1, R4, #4

@mediumNum_set:
; # Set number
  MOV     R0, #13
  MUL     R0, R1
  LSL     R0, R0, #0x10
  STR     R7, [SP,@Ystart]
  ASR     R6, R0, #0x10
  LDR     R0, [SP,#0x20]
  MOV     R2, #0
  STR     R0, [SP,@Xend]
  MOV     R0, #3
  STR     R6, [SP,@Yend]
  MVN     R0, R0
  STR     R0, [SP,@Xout]
  LDR     R0, [SP,0x2C]
  STR     R0, [SP,@Yout]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  MOV     R0, #12
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  .word   0x00802066        ; MOV R0, #0x198
  LDR     R1, [R5,R0]
  LDR     R0, [SP,#0x3C]
  LDR     R3, [SP,0x24]
  ADD     R0, R1, R0
  ADD     R1, R4, #0
  BLX     @v3d_setSubImage

; # Set again the same number in another struct
  STR     R7, [SP,@Ystart]
  LDR     R0, [SP,0x20]
  MOV     R2, #0
  STR     R0, [SP,@Xend]
  MOV     R0, #3
  STR     R6, [SP,@Yend]
  MVN     R0, R0
  STR     R0, [SP,@Xout]
  LDR     R0, [SP,0x2C]
  STR     R0, [SP,@Yout]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  MOV     R0, #12
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  LDR     R0, [SP,0x38]
  LDR     R3, [SP,0x24]
  LDR     R1, [R5,R0]
  LDR     R0, [SP,0x34]
  ADD     R0, R1, R0
  ADD     R1, R4, #0
  BLX     @v3d_setSubImage

; # Loop condition
  ADD     R0, R4, #1
  LSL     R0, R0, #0x18
  LSR     R4, R0, #0x18
  CMP     R4, #10
  BCC     @mediumNum

; # Great points (0/0): [0, 93] -> [34 + 12, 105]
.org 0x0208495C
  MOV     R0, #93
  STR     R0, [SP,@Ystart]
  MOV     R1, #34 + 12
  MOV     R0, #105
  STR     R1, [SP,@Xend]
  MOV     R6, #105
  STR     R6, [SP,@Yend]
  SUB     R0, #122 + 10
  STR     R0, [SP,@Xout]
  MOV     R0, #105
  SUB     R0, #111 + 1
  STR     R0, [SP,@Yout]
  STR     R1, [SP,@Width]
  MOV     R0, #12
  STR     R0, [SP,@Height]
  MOV     R0, #13
  STR     R0, [SP,@Palette]
  MOV     R0, #0x69
  LDR     R1, [R5,R4]
  ADD     R0, #0xBF
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
  MOV     R3, #0
  BLX     @v3d_setSubImage

; # Slash -> [48 + 5, 67] -> [57 + 5, 80]
.org 0x02084A36
  MOV     R0, #67
  STR     R0, [SP,@Ystart]
  MOV     R0, #57 + 5
  STR     R0, [SP,@Xend]
  MOV     R0, #80
  MOV     R1, #80
  STR     R0, [SP,@Yend]
  SUB     R1, #84 + 1
  STR     R1, [SP,@Xout]
  MOV     R1, #80
  SUB     R1, #86 + 1
  STR     R1, [SP,@Yout]
  MOV     R1, #9
  STR     R1, [SP,@Width]
  MOV     R1, #13
  STR     R1, [SP,@Height]
  STR     R7, [SP,@Palette]
  LDR     R1, [R5,R4]
  ADD     R0, #0xD8
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
  MOV     R3, #48 + 5
  BLX     @v3d_setSubImage
