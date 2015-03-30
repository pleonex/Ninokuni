;;  Modify the subimages position of the texture battles images.
;;  Numbers for the changed time box.
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
.org 0x0209F7C8
  MOV     R8, 0xFFFFFFFC
  MOV     R9, #0
  SUB     R7, R8, #2
  MOV     R11, #1
  ADD     R4, R10, R0,LSL#2

; # Small numbers
@smallNumbers:
  CMP     R9, #5
  BCS     @smallNumbers_row2
  MUL     R0, R9, R5
  MOV     R0, R0,LSL#16
  MOV     R3, #26
  MOV     R0, R0,ASR#16
  MOV     R1, #34
  ADD     R2, R9, #1
  B       @smallNumbers_set

@smallNumbers_row2:
  SUB     R0, R9, #5
  MUL     R1, R0, R5
  MOV     R0, R1,LSL#16
  MOV     R3, #35
  MOV     R0, R0,ASR#16
  MOV     R1, #43
  SUB     R2, R9, #4

@smallNumbers_set:
  MUL     R12, R2, R5
  MOV     R2, R12,LSL#16
  MOV     R2, R2,ASR#16
  STMEA   SP, {R0-R2}
  STR     R8, [SP,@Xout]
  STR     R7, [SP,@Yout]
  STR     R6, [SP,@Width]
  STR     R5, [SP,@Height]
  STR     R11, [SP,@Palette]
  LDR     R0, [R4,#0x30]
  MOV     R1, R9
  ADD     R0, R0, #0x14C
  MOV     R2, #0
  BL      @v3d_setSubImage

; Iterate over the 10 digits
  ADD     R0, R9, #1
  AND     R9, R0, #0xFF
  CMP     R9, #10
  BCC     @smallNumbers
