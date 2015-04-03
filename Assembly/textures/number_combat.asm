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


.org 0x02099F24
; ------------------------------------------------- ;
; Big Numbers
; ------------------------------------------------- ;
  MOV     R11, #0

@bigNumbers:
  CMP     R11, #6
  ADDLS   PC, PC, R11,LSL#2
  B       @bigNumbers_subImg
  B       @bigNumbers_pal1
  B       @bigNumbers_pal3
  B       @bigNumbers_pal4
  B       @bigNumbers_pal5
  B       @bigNumbers_pal9
  B       @bigNumbers_pal10
  B       @bigNumbers_pal11

  @bigNumbers_pal1:
  MOV     R5, #1
  B       @bigNumbers_subImg

  @bigNumbers_pal3:
  MOV     R5, #3
  B       @bigNumbers_subImg

  @bigNumbers_pal4:
  MOV     R5, #4
  B       @bigNumbers_subImg

  @bigNumbers_pal5:
  MOV     R5, #5
  B       @bigNumbers_subImg

  @bigNumbers_pal9:
  MOV     R5, #9
  B       @bigNumbers_subImg

  @bigNumbers_pal10:
  MOV     R5, #10
  B       @bigNumbers_subImg

  @bigNumbers_pal11:
  MOV     R5, #11

  @bigNumbers_subImg:
  MOV     R0, #10
  MUL     R6, R11, R0
  MOV     R7, #0
  MOV     R4, 0xFFFFFFFF
  SUB     R10, R4, #7
  MOV     R8, R7

@bigNumbers_loop:
  CMP     R7, #5
  BCS     @bigNumbers_row2

  MOV     R0, R7,LSL#20
  MOV     R3, #0
  MOV     R0, R0,ASR#16
  MOV     R1, #12
  ADD     R2, R7, #1
  B       @bigNumbers_set

  @bigNumbers_row2:
  SUB     R0, R7, #5
  MOV     R0, R0,LSL#20
  MOV     R3, #13
  MOV     R0, R0,ASR#16
  MOV     R1, #25
  SUB     R2, R7, #4

@bigNumbers_set:
  MOV     R2, R2,LSL#20
  MOV     R2, R2,ASR#16
  STMEA   SP, {R0-R2}
  STR     R4, [SP,@XOut]
  STR     R10, [SP,@YOut]
  MOV     R0, #12
  STR     R0, [SP,@Width]
  MOV     R0, #16
  STR     R0, [SP,@Height]
  STR     R5, [SP,@Palette]
  LDR     R0, [R9,#0x19C]
  ADD     R1, R7, R6
  ADD     R0, R0, #0x14C
  MOV     R2, R8
  BL      @v3d_setSubImage

  ADD     R0, R7, #1
  AND     R7, R0, #0xFF
  CMP     R7, #10
  BCC     @bigNumbers_loop

  ADD     R0, R11, #1
  AND     R11, R0, #0xFF
  CMP     R11, #7
  BCC     @bigNumbers


.org 0x0209A068
; ------------------------------------------------- ;
; Number Strings
; ------------------------------------------------- ;
; # Fail (0/0): [25 - 1, 68 - 1] -> [48 + 6, 80]
  MOV     R0, #68 - 1
  STR     R0, [SP,@YStart]
  MOV     R0, #48 + 6
  STR     R0, [SP,@XEnd]
  MOV     R4, #80
  STR     R4, [SP,@YEnd]
  SUB     R0, R4, #91
  STR     R0, [SP,@XOut]
  SUB     R0, R4, #86
  STR     R0, [SP,@YOut]
  MOV     R0, #23 + 7
  STR     R0, [SP,@Width]
  MOV     R0, #12 + 1
  STR     R0, [SP,@Height]
  STR     R5, [SP,@Palette]
  LDR     R0, [R9,#0x1A0]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, #25 - 1
  BL      @v3d_setSubImage

.org 0x0209A0E4
; # Critic (0/0): [0, 80 - 1] -> [59 - 2, 93]
  MOV     R1, #93
  MOV     r2, #79
  MOV     r4, #59 - 2
  STMIA   sp, {r2,r4}
  STR     R1, [SP,@YEnd]
  SUB     R0, R1, #122
  STR     R0, [SP,@XOut]
  SUB     R0, R1, #114
  STR     R0, [SP,@YOut]
  STR     r4, [SP,@Width]
  MOV     R0, #13 + 1
  STR     R0, [SP,@Height]
  MOV     R0, #9
  STR     R0, [SP,@Palette]
  LDR     R0, [R9,#0x1A4]
  MOV     R1, R8
  ADD     R0, R0, #0x128
  MOV     R2, R8
  MOV     R3, R8
  BL      @v3d_setSubImage


  MOV     R7, 0xFFFFFFED
  MOV     R10, R5
  ADD     R6, R7, #7
  MOV     R11, #104
  MOV     R5, #12
  MOV     R4, #0

.org 0x0209A17C
; # Great! (0/0): [26 - 18, 104] -> [64, 128]
  STR     R11, [SP,@YStart]
  MOV     R0, #64
  STR     R0, [SP,@XEnd]
  MOV     R0, #128
  STR     R0, [SP,@YEnd]
  STR     R7, [SP,@XOut]
  STR     R6, [SP,@YOut]
  MOV     R0, #38 + 18
  STR     R0, [SP,@Width]
  MOV     R0, #24
  STR     R0, [SP,@Height]
  STR     R5, [SP,@Palette]
  ADD     R0, R9, R8,LSL#2
  LDR     R0, [R0,#0x1A8]
  MOV     R1, R4
  ADD     R0, R0, #0x128
  MOV     R2, R4
  MOV     R3, #26 - 18
  BL      @v3d_setSubImage

  ADD     R0, R8, #1
  AND     R8, R0, #0xFF
  CMP     R8, #2
  ; A loop jump
