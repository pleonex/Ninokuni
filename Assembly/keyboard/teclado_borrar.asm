;;-----------------------------------------------------------------------------------------------;;
;; ## KEYBOARD DELETE BUTTON ##
;;-----------------------------------------------------------------------------------------------;;
UpdateCursor   equ  020C66B0h

.org 020C6400h
.area 64h
STMFD   SP!, {R3,R5,LR}
LDR     R5, [R0,#0x3D4]                 ; Check there are chars written
CMP     R5, #0                          ; |
LDMLEFD SP!, {R3,R5,PC}                 ; | Quit

MOV     R3, R0
LDR     R0, [R3,#0x3D0]                 ; Pointer

; Substract index
BL      get_preIndex
MOV     R5, R1
STR     R5, [R3,#0x3D4]

; Get index
LDR     R1, [R3,#0x3D8]
BL      get_postIndex 

; Compare index with util if it's lower (need to shift the vector)
CMP     R2, R5
BGE     @@set_nullchar

; shift vector
MOV     R1, R5
BL      shiftL_vector

@@set_nullchar:                             
MOV     R2, #0                          ; Set the null char to the last char
STRB    R2, [R0,R5]                     ; |

LDR     R0, [R3,#0x3CC]                 ; Get max chars
SUB     R0, R0, #0x1                    ; |
LDR     R1, [R3,#0x3D8]                 ; Get index
CMP     R1, R0
SUBLT   R1, R1, #0x1
MOV     R0, R3
BL      UpdateCursor
LDMFD   SP!, {R3,R5,PC}
.endarea
 
;;-----------------------------------------------------------------------------------------------;;
;;      EOF
;;-----------------------------------------------------------------------------------------------;;
