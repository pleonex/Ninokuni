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

Ystart  equ -0x60
Xend    equ -0x5C
Yend    equ -0x58
Xout    equ -0x54
Yout    equ -0x50
Width   equ -0x4C
Height  equ -0x48
Palette equ -0x44
v3d_setSubImage equ 0x020FCD7C

.arm

; # Hack to get some space later
.org 0x020A1650
  ADD     R7, R5, R4,LSL#2
  LDR     R11, [R7,#8]
  LDR     R1, [SP,#0x58]
  LDR     R2, [SP,#0x5C]
  STR     R1, [R11,#0x14]
  LDR     R1, [SP,#0x60]
  STR     R2, [R11,#0x18]
  ADD     R0, SP, #0x58
  STR     R1, [R11,#0x1C]

; # Constants
.org 0x20A16B4
  MOV     R8, #36
  MOV     R6, #24

; ------------------------------------------------- ;
; Switch jump: Down Arrow
; ------------------------------------------------- ;

; # First Down Arrow (0/0): [0, 36] -> [21, 58]
.org 0x020A1718
  MOV     R0, #58
  STR     R8, [SP,#0x60+Ystart]
  MOV     R11, #21
  MOV     R1, #0
  STR     R11, [SP,#0x60+Xend]
  STR     R0, [SP,#0x60+Yend]
  SUB     R10, R0, #68
  SUB     R9, R0, #69
  STR     R10, [SP,#0x60+Xout]
  STR     R9, [SP,#0x60+Yout]
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #22
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,8]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, R1
  BL      v3d_setSubImage

; # Second Down Arrow (1/0): [24, 36] -> [45, 58]
  STR     R8, [SP,#0x60+Ystart]
  MOV     R0, #45
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #58
  STR     R0, [SP,#0x60+Yend]
  STR     R10, [SP,#0x60+Xout]
  STR     R9, [SP,#0x60+Yout]
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #22
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #1
  MOV     R2, #0
  ADD     R0, R0, #0x1A8
  MOV     R3, R6
  BL      v3d_setSubImage

; # Second Down Arrow (2/0): [24, 36] -> [45, 58]
  STR     R8, [SP,#0x60+Ystart]
  MOV     R0, #45
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #58
  STR     R0, [SP,#0x60+Yend]
  STR     R10, [SP,#0x60+Xout]
  STR     R9, [SP,#0x60+Yout]
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #22
  STR     R0, [SP,#0x60+Height]
  MOV     R2, #0
  MOV     R3, R6

ThirdFrameSetPaletteAndQuit:
  MOV     R0, #0xD
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8

; ------------------------------------------------- ;
; Switch jump: Up Arrow
; ------------------------------------------------- ;

;; Removed a call to some function

; # First Up Arrow (0/0): [48, 36] -> [69, 58]
.org 0x020A1820
  MOV     R10, #58
  STR     R8, [SP,#0x60+Ystart]
  MOV     R0, #69
  STMFA   SP, {R0,R10}              ; X and Y end
  SUB     R9, R10, #0x44
  MOV     R1, #0
  STR     R9, [SP,#0x60+Xout]
  SUB     R6, R10, #69
  STR     R6, [SP,#0x60+Yout]
  MOV     R11, #21
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #22
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R2, R1
  ADD     R0, R0, #0x1A8
  MOV     R3, #48
  BL      v3d_setSubImage

; # Second Up Arrow (1/0): [72, 36] -> [93, 58]
  STR     R8, [SP,#0x60+Ystart]
  MOV     R0, #93
  STMFA   SP, {R0,R10}
  STR     R9, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #22
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R7, #72
  MOV     R1, #1
  MOV     R2, #0
  ADD     R0, R0, #0x1A8
  MOV     R3, R7
  BL      v3d_setSubImage

; # Second Up Arrow (2/0): [72, 36] -> [93, 58]
  STR     R8, [SP,#0x60+Ystart]
  MOV     R0, #0x5D
  STMFA   SP, {R0,R10}
  STR     R9, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R11, [SP,#0x60+Width]
  MOV     R0, #0x16
  STR     R0, [SP,#0x60+Height]
  MOV     R2, #0
  MOV     R3, R7
  B       ThirdFrameSetPaletteAndQuit

; ------------------------------------------------- ;
; Switch jump: Automatic
; ------------------------------------------------- ;

;; Removed a call to some function
@AutoW equ 0x04

; # First Button (0/0): [0, 0] -> [54, 24], W=54+5
.org 0x020A1910
  MOV     R10, #0
  STR     R10, [SP,#0x60+Ystart]
  MOV     r1, #54
  STR     r1, [SP,#0x60+Xend]
  STR     R6, [SP,#0x60+Yend]
  SUB     R9, R6, #51 + @AutoW
  STR     R9, [SP,#0x60+Xout]
  SUB     R8, R6, #36
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  MOV     R1, R10
  NOP
  ADD     R0, r11, #0x1A8
  MOV     R2, R10
  MOV     R3, R10
  BL      v3d_setSubImage

; # Second Button (1/0): [54, 0] -> [108, 24], W=54+5
  STR     R10, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R6}
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  NOP
  MOV     R1, #1
  ADD     R0, r11, #0x1A8
  MOV     R2, R10
  MOV     r3, #54
  BL      v3d_setSubImage

; # First button (2/0): [0, 0] -> [54, 24], W=54+5
  MOV     r1, #54
  STMEA   SP, {R10,r1}         ; Y start and X end
  STR     R6, [SP,#0x60+Yend]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  MOV     R7, #9
  STR     R7, [SP,#0x60+Palette]
  MOV     R1, #2
  ADD     r0, r11, #0x1A8
  MOV     R2, R10
  MOV     R3, R10
  BL      v3d_setSubImage

; # First button (3/0): [0, 0] -> [54, 24], W=54+5
  MOV     r1, #54
  STMEA   SP, {R10,r1}
  STR     R6, [SP,#0x60+Yend]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  MOV     R0, #21
  STR     R0, [SP,#0x60+Palette]
  MOV     R1, #3
  MOV     R2, R10
  MOV     R3, R10
  ADD     R0, r11, #0x1A8
  BL      v3d_setSubImage

; # Second button (4/0): [54, 0] -> [108, 24], W=54+5
  STR     R10, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R6}
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  MOV     R0, #21
  STR     R0, [SP,#0x60+Palette]
  NOP
  MOV     R2, R10
  ADD     R0, r11, #0x1A8
  MOV     R1, #4
  MOV     R3, #54
  BL      v3d_setSubImage

; # First button (5/0): [0, 0] -> [54, 24], W=54+5
  MOV     r1, #54
  STMEA   SP, {R10,r1}
  STR     R6, [SP,#0x60+Yend]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  MOV     R2, R10
  MOV     R3, R10
  ADD     R0, r11, #0x1A8
  MOV     R1, #5
  BL      v3d_setSubImage

; # Common constants for "Automatic" word and "x" button
  MOV     R9, -21 - @AutoW - 1      ; Move to the left
  ADD     R8, R9, #15 + @AutoW +1   ; Keep Y position
  ADD     R6, R5, R4,LSL#2
  MOV     R11, #13
  MOV     R7, #12

setAutomatic:
  CMP     R10, #2
  MOV     R0, #24
  MOV     R2, #1
  BCS     setAutomaticIf2Palette13

; # "Automatic" word (i/1): [41, 24] -> [86 + 5, 36]
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #86 + 5
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #36
  STR     R0, [SP,#0x60+Yend]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     R0, #45 + 5
  STR     R0, [SP,#0x60+Width]
  STR     R7, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R3, #41
  BL      v3d_setSubImage

; # 'x' Button (i/2): [86 + 12, 25] -> [96, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #96 + 12
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #35
  STR     R0, [SP,#0x60+Yend]
  MOV     R0, #14
  STR     R0, [SP,#0x60+Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x60+Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x60+Width]
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  B       setButtonX

setAutomaticIf2Palette13:
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #86 + 5
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #36
  STR     R0, [SP,#0x60+Yend]
  CMP     R10, #2
  MOV     R0, #45 + 5
  BNE     setAutomaticPalette12

; # "Automatic" word (2/1): [41, 24] -> [86 + 5, 36]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  STR     R0, [SP,#0x60+Width]
  MOV     R0, #12
  STR     R0, [SP,#0x60+Height]
  STR     R11, [SP,#0x60+Palette]   ; 13
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R3, #41
  BL      v3d_setSubImage

; # 'x' Button (2/2): [86 + 12, 25] -> [96, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #96 + 12
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #35
  STR     R0, [SP,#0x60+Yend]
  MOV     R0, #14
  STR     R0, [SP,#0x60+Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x60+Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x60+Width]
  STR     R0, [SP,#0x60+Height]
  STR     R11, [SP,#0x60+Palette]
  B       setButtonX

setAutomaticPalette12:  ; Same as < 2
; # "Automatic" word (i/1): [41, 24] -> [86 + 5, 36]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  STR     R0, [SP,#0x60+Width]
  MOV     R0, #12
  STR     R0, [SP,#0x60+Height]
  STR     R0, [SP,#0x60+Palette]
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R3, #41
  BL      v3d_setSubImage

; # 'x' Button (i/2): [86 + 12, 25] -> [96, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #96 + 12
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #35
  STR     R0, [SP,#0x60+Yend]
  MOV     R0, #14
  STR     R0, [SP,#0x60+Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x60+Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x60+Width]
  STR     R0, [SP,#0x60+Height]
  MOV     R0, #12
  STR     R0, [SP,#0x60+Palette]

setButtonX:
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #86 + 12
  BL      v3d_setSubImage

  ; Loop condition, write Automatic word and X button for 5 frames
  ADD     R0, R10, #1
  AND     R10, R0, #0xFF
  CMP     R10, #6
  BCC     setAutomatic

; ------------------------------------------------- ;
; Switch jump: Formation
; ------------------------------------------------- ;

;; Removed a call to some function

; # First button (0/0): [0, 0] -> [54, 24]
.org 0x020A1C64
  MOV     R10, #0
  STR     R10, [SP,#0x60+Ystart]
  MOV     r1, #54
  STR     r1, [SP,#0x60+Xend]
  STR     R6, [SP,#0x60+Yend]
  SUB     R9, R6, #51
  STR     R9, [SP,#0x60+Xout]
  SUB     R8, R6, #36
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  NOP
  MOV     R1, R10
  ADD     R0, r11, #0x1A8
  MOV     R2, R10
  MOV     R3, R10
  BL      v3d_setSubImage

; # Second button (1/0): [54, 0] -> [108, 24]
  STR     R10, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R6}
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  NOP
  MOV     R1, #1
  ADD     R0, r11, #0x1A8
  MOV     R2, R10
  MOV     R3, #54
  BL      v3d_setSubImage

; # First button (2/0): [0, 0] -> [54, 24]
  MOV     r1, #54
  STMEA   SP, {R10,r1}
  STR     R6, [SP,#0x60+Yend]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  MOV     r1, #54 + @AutoW
  STR     r1, [SP,#0x60+Width]
  STR     R6, [SP,#0x60+Height]
  MOV     R0, #9
  STR     R0, [SP,#0x60+Palette]
  MOV     R1, #2
  ADD     R0, r11, #0x1A8
  MOV     R2, R10
  MOV     R3, R10
  BL      v3d_setSubImage

; # Common constants for "Formation" word and "y" button
  MOV     R9, -18 + 4          ; Move to the left
  ADD     R8, R9, #12 - 4      ; Keep Y pos
  ADD     R6, R5, R4,LSL#2
  MOV     R11, #13
  MOV     R7, #12

setFormation:
  MOV     R0, #24
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #38
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #36
  STR     R0, [SP,#0x60+Yend]
  CMP     R10, #2
  MOV     R2, #1
  MOV     R0, #37
  BCS     setFormationPalette13

; # "Formation" word (i/1): [1, 24] -> [38, 36]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  STR     R0, [SP,#0x60+Width]
  STR     R7, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R3, R2
  BL      v3d_setSubImage

; # "y" button (i/2): [96 + 12, 25] -> [106 + 12, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #106 + 12
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #35
  STR     R0, [SP,#0x60+Yend]
  MOV     R0, #14 + @AutoW
  STR     R0, [SP,#0x60+Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x60+Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x60+Width]
  STR     R0, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  B       setButtonY

setFormationPalette13:
; # "Formation" word (i/1): [1, 24] -> [38, 36]
  STR     R9, [SP,#0x60+Xout]
  STR     R8, [SP,#0x60+Yout]
  STR     R0, [SP,#0x60+Width]
  MOV     R0, #12
  STR     R0, [SP,#0x60+Height]
  STR     R11, [SP,#0x60+Palette]
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R3, R2
  BL      v3d_setSubImage

; # "y" button (i/2): [96 + 12, 25] -> [106 + 12, 35]
  MOV     R0, #25
  STR     R0, [SP,#0x60+Ystart]
  MOV     R0, #106 + 12
  STR     R0, [SP,#0x60+Xend]
  MOV     R0, #35
  STR     R0, [SP,#0x60+Yend]
  MOV     R0, #14 + @AutoW
  STR     R0, [SP,#0x60+Xout]
  MOV     R0, #4
  STR     R0, [SP,#0x60+Yout]
  MOV     R0, #10
  STR     R0, [SP,#0x60+Width]
  STR     R0, [SP,#0x60+Height]
  STR     R11, [SP,#0x60+Palette]

setButtonY:
  LDR     R0, [R6,#8]
  MOV     R1, R10
  ADD     R0, R0, #0x1A8
  MOV     R2, #2
  MOV     R3, #96 + 12
  BL      v3d_setSubImage

  ; Loop condition, write "Formation" word and "y" button for 3 frames
  ADD     R0, R10, #1
  AND     R10, R0, #0xFF
  CMP     R10, #3
  BCC     setFormation

; ------------------------------------------------- ;
; Switch jump: Main menu buttons
; ------------------------------------------------- ;

; # Common constants
.org 0x020A1E60
  MOV     R11, #0
  MOV     R9, #24

.org 0x020A1E70
  MOV     R10, #54

;; Removed a call to some function

; # First Button (0/0): [0, 0] -> [54, 24]
.org 0x020A1EA8
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  SUB     R8, R9, #0x32
  STR     R8, [SP,#0x60+Xout]
  SUB     R6, R9, #0x24
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, R11
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage

; # Second Button (1/0): [54, 0] -> [108, 24]
  STR     R11, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R9}
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #1
  MOV     R2, R11
  ADD     R0, R0, #0x1A8
  MOV     R3, R10
  BL      v3d_setSubImage

; # First Button (2/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #9
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage

; # First Button (3/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #2
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R2, R11
  MOV     R3, R11
  ADD     R0, R0, #0x1A8
  MOV     R1, #3
  BL      v3d_setSubImage

; # Second Button (4/0): [54, 0] -> [108, 24]
  STR     R11, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R9}
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #2
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #4
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R10
  BL      v3d_setSubImage

; # First Button (5/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #9
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #5
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage

; # First Button (6/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #18
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #6
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage

; # Second Button (7/0): [54, 0] -> [108, 24]
  STR     R11, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R9}
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #2
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R2, R11
  MOV     R3, R10
  ADD     R0, R0, #0x1A8
  MOV     R1, #7
  BL      v3d_setSubImage

; # First Button (8/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #9
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R2, R11
  MOV     R3, R11
  ADD     R0, R0, #0x1A8
  MOV     R1, #8
  ; Set and quit

; ------------------------------------------------- ;
; Switch jump: Main menu, second button only
; ------------------------------------------------- ;

;; Removed a call to some function

; # First Button (0/0): [0, 0] -> [54, 24]
.org 0x020A2100
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  SUB     R8, R9, #0x32
  STR     R8, [SP,#0x60+Xout]
  SUB     R6, R9, #0x24
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, R11
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage

; # Second Button (1/0): [54, 0] -> [108, 24]
  STR     R11, [SP,#0x60+Ystart]
  MOV     R0, #108
  STMFA   SP, {R0,R9}
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  STR     R7, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #1
  MOV     R2, R11
  ADD     R0, R0, #0x1A8
  MOV     R3, R10
  BL      v3d_setSubImage

; # First Button (2/0): [0, 0] -> [54, 24]
  STR     R11, [SP,#0x60+Ystart]
  STR     R10, [SP,#0x60+Xend]
  STR     R9, [SP,#0x60+Yend]
  STR     R8, [SP,#0x60+Xout]
  STR     R6, [SP,#0x60+Yout]
  STR     R10, [SP,#0x60+Width]
  STR     R9, [SP,#0x60+Height]
  MOV     R0, #9
  STR     R0, [SP,#0x60+Palette]
  ADD     R0, R5, R4,LSL#2
  LDR     R0, [R0,#8]
  MOV     R1, #2
  ADD     R0, R0, #0x1A8
  MOV     R2, R11
  MOV     R3, R11
  BL      v3d_setSubImage
