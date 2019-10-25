*-----------------------------------------------------------
* Title      :HW2Q3_jlandron
* Written by :Josh Landron
* Date       :27Apr2019
* Description:source code answer to question 3
*-----------------------------------------------------------

* Put variables and constants here

    *define LONGWORD variable named Addr1, assign memory location to Addr1
    *if value is found in the range checked, if not found Addr1 should be $6000
Addr1       DS.L    1
    
    
    *define WORD variable called Addsum, add all of the next 512 bytes stored
    *in memory beggining at Addr1, save final sum to Addsum
Addsum      DS.W    1
    
    *define BYTE called CarryBit to store the C if it is ever flagged during
    *the summation
CarryBit    DS.B    1


*-----START OF PROGRAM------*
    ORG    $1000
    
START:                  ; first instruction of program
*--------------------------------------------------
* Initial Setup
*--------------------------------------------------
    LEA     START_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15

    *take one byte hex value from user, 
    JSR READ_CHAR       *Read first digit
    JSR AtoH
    LSL.B   #4,D6
    MOVE.B  D6,D2       *save first digit
    JSR READ_CHAR       *read second digit
    JSR AtoH
    ADD.B   D6, D2      *Add the two HEX digits to get result
    MOVE.B  D2, $A000   *save to $A000
    
    CLR.L   D2          *Clear used registers
    CLR.L   D6
    LEA     BLANK_MSG,A1    *Move output to new line
    MOVE.B  #14,D0
    TRAP    #15
 
*-------------------------------------------------
*Loop through memory  
*-------------------------------------------------
    
    *Read each byte data stored in memory betweeen $6000 and $8000,
    *and compare it to byte stored from user at $A000
    MOVEA.L #$6000, A4   *STARTING LOCATION
    MOVEA.L #$8000, A5   *ENDING LOCATION
    MOVE.L  #$6000, (Addr1) *initialize valueS
    MOVE.L  #$0, (Carrybit)
    MOVE.L  #$0, (Addsum)
    MOVE.B  #$2E,$7120     *Test number
    
LOOP_MEM    
    CMPA.L   A4, A5  *start of loop, break if the addresses are the same
    BEQ     START_SUM
    MOVE.B  (A4),D2
    CMP.B   ($A000),D2
    BEQ     SET_ADDR1
    BRA     CONTINUE_MEM

SET_ADDR1
    MOVE.L  A4, Addr1
    
CONTINUE_MEM
    MOVE.B  (A4)+,D2    *Increcemnt A4
    BRA     LOOP_MEM
    
*----------------------------------------------------      
*Summation loop
*---------------------------------------------------- 
*Set up A4,A5,D2, and D3 for use in summation
START_SUM
    CLR.L   D2
    CLR.L   D3
    MOVE.L  (Addr1),D4
    MOVEA.L D4,A4
    ADDI.L   #512,D4
    MOVEA.L D4,A5
    MOVE.B  (A4)+,D2    *Initialize a value into D2, this register will hold values to be added 
    MOVE.B  (A4)+,D3    *Initialize a value into d3, the sum destination
    
*Start summation loop
LOOP_SUM
    CMPA.L  A4,A5
    BEQ     PUSH_SUM
    ADD.W   D2,D3
    BCS     SET_CARRYBIT    *branch if carry set
    BRA     CONTINUE_SUM    *branch past carry setting
    
SET_CARRYBIT
    MOVE.B  #$01,(CarryBit)
    
CONTINUE_SUM
    MOVE.B  (A4)+,D2
    BRA     LOOP_SUM
    
    
PUSH_SUM
    MOVE.W  D3,Addsum
    BRA     END_PRINT
    
*---------------------------------------------------
*Ending messages
*---------------------------------------------------    
END_PRINT
    LEA     ADDR1_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.L  (Addr1),D2
    JSR     PRINT_WORD  
    
    LEA     BLANK_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     SUM_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L   D2
    MOVE.W  (Addsum),D2
    JSR     PRINT_WORD
    
    LEA     BLANK_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    LEA     CARRY_MSG,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    CLR.L   D2
    MOVE.B  (Carrybit),D2
    JSR     PRINT_BYTE
    
    
    SIMHALT             ; halt simulator
*--------------------------------------------
*Subroutines
*-------------------------------------------
    
*----Reading subroutine----
  
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

*----printing subroutine----

PRINT_CHAR
    MOVE.B  #6, D0
    MOVE.B  D6, D1
    TRAP    #15
    RTS
    
HtoA    
    CMPI.B  #9, D6
    BGT     ABCD
NUM 
    ADDI.B  #$30, D6
    RTS
ABCD
    ADDI.B  #$37, D6
    RTS

*-----------------------------------------
*Printing subroutines for HEX to ASCII
*----------------------------------------       
PRINT_WORD *STORE INITIAL WORD IN D2
    MOVE.W  D2, D6 *MOVE ENTIRE WORD TO D6 FOR WORK
    LSR.W   #8, D6 *shift right to eliminate first 3 digits
    LSR.B   #4, D6
    JSR     HtoA
    MOVE.B  D6, D1
    JSR     PRINT_CHAR
    MOVE.W  D2, D6  *max shift is one Byte
    LSL.L   #8, D6  *shift left to delete first digit
    LSL.L   #8, D6
    LSL.L   #4, D6
    LSR.L   #8, D6  *shift right to move desired digit to first 4 bits
    LSR.L   #8, D6
    LSR.L   #8, D6
    LSR.B   #4, D6
    JSR     HtoA
    MOVE.B  D6, D1
    JSR     PRINT_CHAR
    JSR     PRINT_BYTE    
    RTS

PRINT_BYTE *STORE INITIAL BYTE IN D2
    MOVE.B  D2, D6
    LSR.B   #4, D6
    JSR     HtoA
    MOVE.B  D6, D1
    JSR     PRINT_CHAR 
    MOVE.B  D2, D6
    LSL.B   #4, D6
    LSR.B   #4, D6
    JSR     HtoA
    MOVE.B  D6, D1
    JSR     PRINT_CHAR
    RTS
    
*--------------------------------------------
*Strings
*--------------------------------------------
CR      EQU     $0D
LF      EQU     $0A

START_MSG   DC.B    'Welcome to Pattern Finding, Please a 2-digit HEX number',CR,LF,0
BLANK_MSG   DC.B    '',CR,LF,0
ADDR1_MSG   DC.B    'Addr1 was set to : ',0
SUM_MSG     DC.B    'Addsum is set to : ',0
CARRY_MSG   DC.B    'Carrybit is : ',0



    
    END    START        ; last line of source










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
