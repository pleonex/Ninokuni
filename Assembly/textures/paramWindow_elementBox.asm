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

.org 0x020AD288
; # Common constants
  MOV     R11, 0xFFFFFFDA
  ADD     R0, R11, #6
  STR     R0, [SP,#0x20]
  ADD     R0, R11, #33
  STR     R0, [SP,#0x24]
  ADD     R0, R11, #30
  ADD     R5, R11, #27
  STR     R0, [SP,#0x28]
  MOV     R7, #31
  MOV     R6, #56
  MOV     R4, #25

  @entryBox:
; # First part (i/0): [94, 31] -> [95, 56]
  STR     R7, [SP,@YStart]
  MOV     R0, #99
  STMFA   SP, {R0,R6}
  STR     R11, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #6
  STR     R0, [SP,@Width]
  ADD     R9, R8, #1
  MOV     R0, R9,LSL#16
  STR     R4, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x44]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, #0
  MOV     R3, #94
  BL      @v3d_setSubImage

; # Second part (i/1): [99, 31] -> [109, 56]
  STR     R7, [SP,@YStart]
  MOV     R0, #109
  STMFA   SP, {R0,R6}
  LDR     R0, [SP,#0x20]
  MOV     R1, R8
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #64
  STR     R0, [SP,@Width]
  MOV     R0, R9,LSL#16
  STR     R4, [SP,@Height]
  MOV     R0, R0,ASR#16
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x44]
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, #99
  BL      @v3d_setSubImage

; # Third part (i/2): [109, 31] -> [114, 56]
  MOV     R0, R9,LSL#16
  MOV     R1, R0,ASR#16
  STR     R7, [SP,@YStart]
  MOV     R0, #114
  STMFA   SP, {R0,R6}
  MOV     R0, #32
  STR     R0, [SP,@XOut]
  STR     R5, [SP,@YOut]
  MOV     R0, #6
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  STR     R1, [SP,@Palette]
  LDR     R0, [R10,#0x44]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #109
  BL      @v3d_setSubImage

; # Slash (i/3): [85, 0] -> [95, 11]
  MOV     R0, #0
  STR     R0, [SP,@YStart]
  MOV     R0, #95
  STR     R0, [SP,@XEnd]
  MOV     R0, #11
  STR     R0, [SP,@YEnd]
  LDR     R0, [SP,#0x24]
  MOV     R1, R8
  STR     R0, [SP,@XOut]
  LDR     R0, [SP,#0x28]
  MOV     R2, #3
  STR     R0, [SP,@YOut]
  MOV     R0, #11
  STR     R0, [SP,@Width]
  MOV     R0, #12
  STR     R0, [SP,@Height]
  MOV     R0, #7
  STR     R0, [SP,@Palette]
  LDR     R0, [R10,#0x44]
  MOV     R3, #85
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage

  MOV     R0, R9
  AND     R8, R0, #0xFF
  CMP     R8, #4
  BCC     @entryBox
