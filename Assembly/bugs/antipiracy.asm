;; Antipiracy patch from Dicastia.com
;; It patches some bytes at the beggining of the ARM9 file.
;; The third routine is called when to the BLZ function it's passed a 0 size.

.arm
.org 0x02000200

.area 0x0C
  LDR     R0, =0xB3CF
  BX      LR

  .pool
.endarea

.area 0x0C
  LDR     R0, =0xB177
  BX      LR

  .pool
.endarea

.area 0x34
  STMFD   SP!, {R0-R2,LR}
  LDR     R0, =0x215D7E0
  LDR     R1, =0x215C04C
  LDR     R2, [R1]
  CMP     R0, R2
  LDREQ   R0, =0x2002300
  STREQ   R0, [R1]
  ADDEQ   R0, R0, #0xC
  STREQ   R0, [R1,#0x3C]
  LDMFD   SP!, {R0-R2,PC}

  .pool
.endarea


; BLZ decoding when size is 0.
.org 0x0020009F8
  B       0x2000218
