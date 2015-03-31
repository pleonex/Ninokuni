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

; # Constant
.org 0x020841E2
  MOV     R6, #25

; # Attack string (0/0): [0, 0] -> [31 + 14, 13 + 2]
.org 0x020841FA
  MOV     R0, #0
  STR     R0, [SP,@Ystart]
  MOV     R0, #31 + 14
  STR     R0, [SP,@Xend]
  MOV     R0, #13 + 2
  MOV     R7, #13
  STR     R0, [SP,@Yend]
  SUB     R7, #34
  MOV     R4, #13
  STR     R7, [SP,@Xout]
  SUB     R4, #19
  STR     R4, [SP,@Yout]
  MOV     R0, #31 + 14
  STR     R0, [SP,@Width]
  MOV     R0, #13 + 2
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  MOV     R0, R6
  LDR     R1, [R5,R6]
  SUB     R0, #0x68
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
  MOV     R3, #0
  BLX     @v3d_setSubImage

; # Defense string (1/0): [0, 13 + 1] -> [29 + 21, 26 + 2]
  MOV     R0, #13 + 1
  STR     R0, [SP,@Ystart]
  MOV     R0, #29 + 21
  STR     R0, [SP,@Xend]
  MOV     R0, #26 + 2
  STR     R0, [SP,@Yend]
  MOV     R0, #26
  STR     R0, [SP,0x20]
  SUB     R0, #46
  STR     R0, [SP,@Xout]
  STR     R0, [SP,0x20]
  STR     R4, [SP,@Yout]
  MOV     R0, #29 + 21
  STR     R0, [SP,@Width]
  MOV     R0, #13 + 1
  STR     R0, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #0
  LDR     R1, [R5,R6]
  SUB     R0, #0x68
  ADD     R0, R1, R0
  MOV     R1, #1
  MOV     R2, #0
  MOV     R3, #0
  BLX     @v3d_setSubImage

; # Magic Attack string (2/0): [0, 26 + 18] -> [29 + 21, 39 + 21]
  MOV     R0, #26 + 18
  STR     R0, [SP,@Ystart]
  MOV     R0, #29 + 21
  STR     R0, [SP,@Xend]
  MOV     R0, #39 + 18 + 3
  STR     R0, [SP,@Yend]
  LDR     R0, [SP,0x20]
  MOV     R2, #0
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #29 + 21
  STR     R0, [SP,@Width]
  MOV     R0, #13 + 3
  STR     R0, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  MOV     R0, R6
  LDR     R1, [R5,R6]
  SUB     R0, #0x68
  ADD     R0, R1, R0
  MOV     R1, #2
  MOV     R3, #0
  BLX     @v3d_setSubImage

; # Magic Defense string (3/0): [0, 39 + 20] -> [31 + 25, 52 + 23]
  MOV     R0, #39 + 20
  STR     R0, [SP,@Ystart]
  MOV     R0, #31 + 25
  STR     R0, [SP,@Xend]
  MOV     R0, #52 + 20 + 3
  STR     R0, [SP,@Yend]
  STR     R7, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #31 + 25
  STR     R0, [SP,@Width]
  MOV     R0, #13 + 3
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  MOV     R0, #0x34
  LDR     R1, [R5,R6]
  ADD     R0, #0xF4
  ADD     R0, R1, R0
  MOV     R1, #3
  MOV     R2, #0
  MOV     R3, #0
  BLX     @v3d_setSubImage

; # Agility string (4/0): [29 - 29, 15 + 14] -> [60 - 11, 28 + 17]
  MOV     R0, #15 + 14
  STR     R0, [SP,@Ystart]
  MOV     R0, #60 - 11
  STR     R0, [SP,@Xend]
  MOV     R1, #28 + 17
  STR     R1, [SP,@Yend]
  STR     R7, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R1, #31 + 18
  STR     R1, [SP,@Width]
  MOV     R1, #13 + 3
  STR     R1, [SP,@Height]
  MOV     R1, #5
  STR     R1, [SP,@Palette]
  LDR     R1, [R5,R6]
  ADD     R0, #0xEC
  ADD     R0, R1, R0
  MOV     R1, #4
  MOV     R2, #0
  MOV     R3, #29
  BLX     @v3d_setSubImage

; # Without Changes string (5/0): [0, 52 + 28] -> [46 + 13, 64 + 30]
  MOV     R0, #52 + 28
  STR     R0, [SP,@Ystart]
  MOV     R1, #46 + 13
  MOV     R0, #64
  STR     R1, [SP,@Xend]
  MOV     R7, #64 + 28 + 2
  STR     R7, [SP,@Yend]
  SUB     R0, #93
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  STR     R1, [SP,@Width]
  MOV     R0, #12 + 2
  STR     R0, [SP,@Height]
  MOV     R0, #6
  STR     R0, [SP,@Palette]
  MOV     R0, #0x40
  LDR     R1, [R5,R6]
  ADD     R0, #0xE8
  ADD     R0, R1, R0
  MOV     R1, #5
  MOV     R2, #0
  MOV     R3, #0
  BLX     @v3d_setSubImage

.org 0x0208434E
; # Big Up Arrow Palette 1 (0/0): [31 - 7, 0 + 99] -> [43 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R0, #43 - 7
  STR     R0, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  MOV     R4, #43
  STR     R0, [SP,@Xout]
  SUB     R4, #50
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x2B
  ADD     R0, #0xFD
  ADD     R0, R1, R0
  MOV     R1, #0
  MOV     R2, #0
  MOV     R3, #31 - 7
  BLX     @v3d_setSubImage

; # Big Up Arrow Palette 2 (1/0): [31 - 7, 0 + 99] -> [43 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R0, #43 - 7
  STR     R0, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x2B
  ADD     R0, #0xFD
  ADD     R0, R1, R0
  MOV     R1, #1
  MOV     R2, #0
  MOV     R3, #31 - 7
  BLX     @v3d_setSubImage

; # Big Up Arrow Palette 3 (2/0): [31 - 7, 0 + 99] -> [43 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R0, #43 - 7
  STR     R0, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x2B
  ADD     R0, #0xFD
  ADD     R0, R1, R0
  MOV     R1, #2
  MOV     R2, #0
  MOV     R3, #31 - 7
  BLX     @v3d_setSubImage

; # Big Up Arrow Palette 4 (3/0): [31 - 7, 0 + 99] -> [43 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R0, #43 - 7
  STR     R0, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x2B
  ADD     R0, #0xFD
  ADD     R0, R1, R0
  MOV     R1, #3
  MOV     R2, #0
  MOV     R3, #31 - 7
  BLX     @v3d_setSubImage

; # Big Up Arrow Palette 5 (4/0): [31 - 7, 0 + 99] -> [43 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R0, #43 - 7
  STR     R0, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x2B
  ADD     R0, #0xFD
  ADD     R0, R1, R0
  MOV     R1, #4
  MOV     R2, #0
  MOV     R3, #31 - 7
  BLX     @v3d_setSubImage

; # Big Down Arrow Palette 1 (5/0): [43 - 7, 0 + 99] -> [55 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  MOV     R7, #55 - 7
  STR     R7, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #1
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x37
  ADD     R0, #0xF1
  ADD     R0, R1, R0
  MOV     R1, #5
  MOV     R2, #0
  MOV     R3, #43 - 7
  BLX     @v3d_setSubImage

; # Big Down Arrow Palette 2 (6/0): [43 - 7, 0 + 99] -> [55 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #2
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x37
  ADD     R0, #0xF1
  ADD     R0, R1, R0
  MOV     R1, #6
  MOV     R2, #0
  MOV     R3, #43 - 7
  BLX     @v3d_setSubImage

; # Big Down Arrow Palette 3 (7/0): [43 - 7, 0 + 99] -> [55 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #3
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x37
  ADD     R0, #0xF1
  ADD     R0, R1, R0
  MOV     R1, #7
  MOV     R2, #0
  MOV     R3, #43 - 7
  BLX     @v3d_setSubImage

; # Big Down Arrow Palette 4 (8/0): [43 - 7, 0 + 99] -> [55 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #4
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R1, [R5,R0]
  MOV     R0, #0x37
  ADD     R0, #0xF1
  ADD     R0, R1, R0
  MOV     R1, #8
  MOV     R2, #0
  MOV     R3, #43 - 7
  BLX     @v3d_setSubImage

; # Big Down Arrow Palette 5 (9/0): [43 - 7, 0 + 99] -> [55 - 7, 15 + 99]
  MOV     R0, #0 + 99
  STR     R0, [SP,@Ystart]
  STR     R7, [SP,@Xend]
  MOV     R0, #15 + 99
  STR     R0, [SP,@Yend]
  MOV     R0, #10
  STR     R0, [SP,@Xout]
  STR     R4, [SP,@Yout]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #15
  STR     R0, [SP,@Height]
  MOV     R0, #5
  STR     R0, [SP,@Palette]
  ADD     R0, R6, #4
  LDR     R0, [R5,R0]
  ADD     R7, #0xF1 + 7
  ADD     R0, R0, R7
  MOV     R1, #9
  MOV     R2, #0
  MOV     R3, #43 - 7
  BLX     @v3d_setSubImage
