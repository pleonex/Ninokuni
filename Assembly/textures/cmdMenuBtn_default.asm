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

@Ystart  equ -0x58
@Xend    equ -0x54
@Yend    equ -0x50
@Xout    equ -0x4C
@Yout    equ -0x48
@Width   equ -0x44
@Height  equ -0x40
@Palette equ -0x3C
@v3d_setSubImage equ 0x020FCD7C

@AutoW equ 0x04 ; Width of the automatic button

.arm

; # Common constant
.org 0x020A0AD0
  MOV     R9, #0

; # First panel, first part (0/0): [96, 35] -> [102, 57]
.org 0x020A0B0C
  MOV     R8, #35
  MOV     R7, #57
  STR     R8, [SP,#0x58+@Ystart]
  MOV     R0, #102
  STR     R0, [SP,#0x58+@Xend]
  SUB     R0, R7, #82
  STR     R7, [SP,#0x58+@Yend]
  STR     R0, [SP,#0x58+@Xout]
  SUB     R4, R7, #68
  STR     R0, [SP,#0x20]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #6
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #15
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, #96
  BL      @v3d_setSubImage

; # First panel, second part (0/1): [104, 35] -> [112, 57]
  MOV     R0, #112
  STR     R8, [SP,#0x58+@Ystart]
  STMFA   SP, {R0,R7}
  SUB     R11, R0, #133
  STR     R11, [SP,#0x58+@Xout]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #42
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #15
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #1
  MOV     R3, #104
  BL      @v3d_setSubImage

; # First panel, third part (0/2): [113, 35] -> [120, 57]
  STR     R8, [SP,#0x58+@Ystart]
  MOV     R0, #120
  STMFA   SP, {R0,R7}
  MOV     R0, #21
  STR     R0, [SP,#0x58+@Xout]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #7
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #15
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, R9
  ADD     R0, R0, #0x128
  MOV     R2, #2
  MOV     R3, #113
  BL      @v3d_setSubImage

; # Second panel, first part (1/0): [96, 35] -> [102, 57]
  STR     R8, [SP,#0x58+@Ystart]
  MOV     R0, #102
  STMFA   SP, {R0,R7}
  LDR     R0, [SP,#0x20]
  MOV     R1, #1
  STR     R0, [SP,#0x58+@Xout]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #6
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #17
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R2, R9
  ADD     R0, R0, #0x128
  MOV     R3, #96
  BL      @v3d_setSubImage

; # Second panel, second part (1/1): [104, 35] -> [112, 57]
  MOV     R1, #1
  STR     R8, [SP,#0x58+@Ystart]
  MOV     R0, #112
  STMFA   SP, {R0,R7}
  STR     R11, [SP,#0x58+@Xout]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #42
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #17
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R3, #104
  ADD     R0, R0, #0x128
  MOV     R2, R1
  BL      @v3d_setSubImage

; # Second panel, third part (1/2): [113, 35] -> [120, 57]
  STR     R8, [SP,#0x58+@Ystart]
  MOV     R0, #120
  STMFA   SP, {R0,R7}
  MOV     R0, #21
  STR     R0, [SP,#0x58+@Xout]
  STR     R4, [SP,#0x58+@Yout]
  MOV     R0, #7
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #22
  STR     R0, [SP,#0x58+@Height]
  MOV     R0, #17
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R3, #113
  MOV     R1, #1
  ADD     R0, R0, #0x128
  MOV     R2, #2
  BL      @v3d_setSubImage

; # First button (2/0): [0, 0] -> [54, 24]
  MOV     R4, #24
  MOV     r0, r9                        ; Added
  ;STR     R9, [SP,#0x58+@Ystart]       ; Deleted
  MOV     R1, #54
  ;STR     R1, [SP,#0x58+@Xend]         ; Deleted
  STMIA   sp, {r0,r1,r4}                ; Added
  ;STR     R4, [SP,#0x58+@Yend]         ; Deleted
  SUB     R0, R4, #51 + @AutoW
  STR     R0, [SP,#0x58+@Xout]
  SUB     R0, R4, #36
  STR     R0, [SP,#0x58+@Yout]
  ADD     r1, @AutoW                    ; Added
  STR     R1, [SP,#0x58+@Width]
  STR     R4, [SP,#0x58+@Height]
  MOV     R0, #20
  STR     R0, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, #2
  ADD     R0, R0, #0x128
  MOV     R2, R9
  MOV     R3, R9
  BL      @v3d_setSubImage

; "Automatic" word (2/1): [41, 24] -> [86 + 5, 36]
  MOV     r0, r4                        ; + Added
  ;STR     R4, [SP,#0x58+@Ystart]       ; - Deleted
  MOV     r1, #86 + 5                   ; Edited
  MOV     r2, #36                       ; Edited
  ;STR     R4, [SP,#0x58+@Xend]         ; - Deleted
  ;STR     R0, [SP,#0x58+@Yend]         ; - Deleted
  STMIA   sp, {r0,r1,r2}                ; + Added
  SUB     r0, r11, @AutoW + 1           ; + Added
  STR     r0, [SP,#0x58+@Xout]          ; Edited
  SUB     R0, r2, #42                   ; Edited
  STR     R0, [SP,#0x58+@Yout]
  MOV     R0, #45 + 5
  STR     R0, [SP,#0x58+@Width]
  MOV     R0, #12
  STR     R0, [SP,#0x58+@Height]
  MOV     R7, #19
  STR     R7, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, #2
  MOV     R2, #1
  ADD     R0, R0, #0x128
  MOV     R3, #41
  BL      @v3d_setSubImage

; # 'x' Button (2/2): [86 + 12, 25] -> [96 + 12, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x58+@Ystart]
  MOV     R0, #96 + 12
  STMFA   SP, {R0,R8}
  MOV     R0, #14
  STR     R0, [SP,#0x58+@Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x58+@Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x58+@Width]
  STR     R0, [SP,#0x58+@Height]
  STR     R7, [SP,#0x58+@Palette]
  LDR     R0, [R10,#0x38]
  MOV     R1, #2
  MOV     R2, R1
  MOV     R3, #86 + 12
  ADD     R0, R0, #0x128
  BL      @v3d_setSubImage
