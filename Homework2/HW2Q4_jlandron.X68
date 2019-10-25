*-----------------------------------------------------------
* Title      :HW2Q4 - Decode 32Bit IEEE floating point number
* Written by :Joshua Landron
* Date       :30Apr2019
* Description:Decodes a IEEE floting point number input in HEX
*-----------------------------------------------------------

* Put variables and constants here    
UserHex     DC.L    1       *VARIABLE TO STORE USER HEX INPUT

    ORG    $4000
START:                  ; first instruction of program
*--------------------------------------------
*Program Start
*--------------------------------------------
    LEA     START_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15
    
    *Take user input, final hex number will be in D2
    JSR     READ_CHAR   *READ FIRST DIGIT
    JSR     AtoH
    MOVE.B  D6,D2
    LSL.L   #4,D2       *SHIFT D2 LEFT TO MAKE ROOM FOR NEXT DIGIT

    MOVE.B  #0, D4      *LOOP COUNTER   D4 RESERVED
    MOVE.B  #6, D5      *LOOP STOP      D5 RESERVED
READ_LOOP
    JSR     READ_CHAR   *LOOP TO READ NEXT 7 DIGITS
    JSR     AtoH
    ADD.B   D6,D2
    
    CMP.B   D4,D5
    BEQ     DONE_READ   *WHEN LOOP IS FINISHED, BRANCH BEFORE SHIFTING
    ADDI.B  #1,D4
    LSL.L   #4,D2       
    BRA     READ_LOOP   

DONE_READ   
    MOVE.L  D2,(UserHex) *Move user number to variable, leave number in D2
    JSR     PRINT_BLANK
*--------------------------------------------
*Sign check
*--------------------------------------------
    *Check sign with and BTST at location 1F(leftmost bit)
    BTST    #$1F,D2
    BEQ     PRINT_POS   *JUMP TO PRINT_POS IF Z FLAG IS SET
    LEA     SIGN_NEG,A1 *ELSE PRINT NEGATIVE MESSAGE
    MOVE.B  #14, D0
    TRAP    #15
    BRA     START_EXP
    
PRINT_POS
    LEA     SIGN_POS,A1
    MOVE.B  #14, D0
    TRAP    #15 
 
*--------------------------------------------
*Exponant print
*--------------------------------------------   
START_EXP          
    LSR.L   #$8, D2 *shift right by 23
    LSR.L   #$8, D2
    LSR.L   #$7, D2
    
    LEA     EXP_MSG,A1
    MOVE.B  #14, D1
    TRAP    #15
    MOVE.B  D2, D1
    MOVE.B  #3, D0
    TRAP    #15
    JSR     PRINT_BLANK
    
*--------------------------------------------
*Mantissa print
*--------------------------------------------   
    MOVE.L  (UserHex),D2
    LSL.L   #$1, D2     *Eliminate sign bit
    LSL.L   #$8, D2     *Eliminate exponant
    LSR.L   #$8, D2     *Move back to beggining
    LSR.L   #$1, D2     
    
RIGHT_ONE
    BTST.L  #$0,D2
    BNE     DONE_SHIFTING
    LSR.L   #$1,D2
    BRA     RIGHT_ONE

DONE_SHIFTING   
    LEA     MTSA_MSG,A1
    MOVE.B  #14, D1
    TRAP    #15
    MOVE.L  D2, D1
    MOVE.B  #3, D0
    TRAP    #15
    
    

    SIMHALT             ; halt simulator

*--------------------------------------------
*Subroutines
*--------------------------------------------
*----Reading subroutine----USES D0,D1,D6,D7
  
READ_CHAR
    MOVE.B  #5, D0
    TRAP    #15
    MOVE.B  D1, D6 *Store char in D6
    RTS
    
*PARAMETER SHOULD BE STORED IN D6
AtoH
    MOVE.B  #0, D7
    CMP.B   #$39, D6    *30-39 ARE NUMBERS, GREATER IS A LETTER
    BGT.B   ALPHA
    SUBI.B  #$30, D6
    RTS
    
ALPHA
    SUBI.B  #$37, D6
    RTS

PRINT_BLANK
    LEA     BLANK_MSG,A1    *Move print to new line
    MOVE.B  #14, D0
    TRAP    #15  
    RTS 
*--------------------------------------------
*Strings
*--------------------------------------------
CR      EQU     $0D
LF      EQU     $0A

START_MSG   DC.B    'Please enter IEEE 32-bit floating point number in Hexadecimal Format',CR,LF,0
SIGN_POS    DC.B    'Sign bit: +',CR,LF,0
SIGN_NEG    DC.B    'Sign bit: -',CR,LF,0
EXP_MSG     DC.B    'Exponant: ',0
MTSA_MSG    DC.B    'Mantissa: ',0
BLANK_MSG   DC.B    '',CR,LF,0




    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
