;;-----------------------------------------------------------------------------------------------;;
;; ## SUPPORT 1-BYTE & 2-BYTE CHARS ##
;;-----------------------------------------------------------------------------------------------;;

;;-----------------------------------------------------------------------------------------------;;
;;      Fix add new char.
;;-----------------------------------------------------------------------------------------------;;
.org 020C68ACh
.area 38h

    LDR     R0, [R11,#0x3D0]				; Name pointer
	LDR     R1, [R11,#0x3D8]				; Number of characters before write the new
    BL		get_postIndex
    MOV     R1, R2
    MOV     R3, R7
    
	BL		write_char

	LDR     R3, [R11,#0x3D4]				; Get the util (1) 
	CMP     R1, R3							; (1) Check if it must be incremented
	STRGE   R1, [R11,#0x3D4]				; (1) Write it
    
    NOP
    NOP  
    NOP
    NOP
    NOP
.endarea
	
;;-----------------------------------------------------------------------------------------------;;
;;      Fix nigori (accent) button click (change char)
;;-----------------------------------------------------------------------------------------------;;
.org 020C691Ch      ; Fix reading char
.area 2Ch
    BL      get_preIndex       ; Fix the char index too
    STR     R1, [SP,#0x0]      ; ||
	BL 		read_charSP
    MOV     R2, R0
    MOVEQ   R2, R2,LSL#0x8  ; To be able to compare with alphabet
    
    ; Changes to get free space
    CMP     R2, R9
    BEQ     020C69F4h
    MOV     R8, #0x64 ; 'd' ; Changed
    MUL     R4, R7, R8      ; Changed
    MOV     R3, #0
    MOV     R0, R3
.endarea
 
.org 020C6998h      ; Write new char
.area 0Ch
    LDR     R0, [SP,#0x4]
    LDR     R1, [SP,#0x0]
    BL      write_char
    ; Jump to next code
.endarea
   
.org 020C69CCh      ; Fix reading char
.area 10h
    BL      read_charSP
    MOV     R1, R2
    BL      update_util
    CMP     R0, R1
.endarea

;;-----------------------------------------------------------------------------------------------;;
;;      Fix nigori (accent) button activation
;;-----------------------------------------------------------------------------------------------;;
.org 020C6A60h
.area 18h
    LDR     R1, [R10,#0x3D8]    ; Char index
    CMP     R1, R0
    SUBGE   R1, R0, #1
    LDR     R0, [R10,#0x3D0]    ; Name offset
    BL      read_charIndex
    MOV     R5, R0
.endarea

;;-----------------------------------------------------------------------------------------------;;
;;      EOF
;;-----------------------------------------------------------------------------------------------;;
