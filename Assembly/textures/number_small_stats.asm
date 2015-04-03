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

; # Small Digits twice
.org 0x020A78B0
@smallDigits:
  CMP     R9, #5
  BCS     @row2
  MUL     R0, R9, R4
  MOV     R0, R0,LSL#16
  MOV     R6, R0,ASR#16
  MOV     R5, #26                       ; X start
  MOV     R7, #34                       ; X end
  ADD     R0, R9, #1
  B       @setTexture

@row2:
  SUB     R0, R9, #5
  MUL     R1, R0, R4
  MOV     R0, R1,LSL#16
  MOV     R6, R0,ASR#16
  MOV     R5, #35                       ; X start
  MOV     R7, #43                       ; X end
  SUB     R0, R9, #4

@setTexture:
  MUL     R1, R0, R4
  MOV     R0, R1,LSL#16
  MOV     R8, R0,ASR#16
  STMEA   SP, {R6-R8}
  LDR     R0, [SP,#0x30]
  ADD     R1, R9, R11
  STR     R0, [SP,@Xout]
  LDR     R0, [SP,#0x34]
  MOV     R2, #0
  STR     R0, [SP,@Yout]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  LDR     R0, [SP,#0x38]
  STR     R10, [SP,@Palette]
  LDR     R0, [R0,#0x70]
  MOV     R3, R5
  ADD     R0, R0, #0x14C
  BL      @v3d_setSubImage

  STMEA   SP, {R6-R8}
  LDR     R0, [SP,#0x30]
  MOV     R3, R5
  STR     R0, [SP,@Xout]
  LDR     R0, [SP,#0x34]
  ADD     R1, R9, R11
  STR     R0, [SP,@Yout]
  MOV     R0, #8
  STR     R0, [SP,@Width]
  STR     R4, [SP,@Height]
  LDR     R0, [SP,#0x38]
  STR     R10, [SP,@Palette]
  LDR     R0, [R0,#0x78]
  MOV     R2, #0
  ADD     R0, R0, #0x14C
  BL      @v3d_setSubImage

  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #10
  BCC     @smallDigits

; # Slash -> [48 + 5, 67 + 25] -> [57 + 5, 80 + 25]
.org 0x020A7A80
  MOV     R0, #67 + 25
  STR     R0, [SP,@Ystart]
  MOV     R0, #57 + 5
  STR     R0, [SP,@Xend]
  MOV     R1, #80 + 25
  STR     R1, [SP,@Yend]
  SUB     R0, R1, #84 + 1 + 25
  STR     R0, [SP,@Xout]
  SUB     R0, R1, #86 + 1 + 25
  STR     R0, [SP,@Yout]
  MOV     R0, #9
  STR     R0, [SP,@Width]
  MOV     R0, #13
  STR     R0, [SP,@Height]
  STR     R5, [SP,@Palette]
  LDR     R1, [SP,#0x20]
  LDR     R0, [SP,#0x2C]
  MOV     R2, R6
  ADD     R0, R1, R0,LSL#2
  LDR     R0, [R0,#0x80]
  MOV     R1, R6
  ADD     R0, R0, #0x128
  MOV     R3, #48 + 5
  BL      @v3d_setSubImage
