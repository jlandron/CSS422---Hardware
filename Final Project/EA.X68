*-----------------------------------------------------------
* Title      :Effective Addressing for Disassembly Pipeline
* Written by :William Nguyen
* Date       :6/3/19
* Description:Part of disassembly pipeline for Machine code back to 68k
*-----------------------------------------------------------

*
*
*MODE PARSING
*    

ea_main
    
    
    CMP.L   #0,D6
    BEQ     DATAREG
    
    CMP.L   #1,D6
    BEQ     ADDREG
    
    CMP.L   #2,D6
    BEQ     INDIRECT
    
    CMP.L   #3,D6
    BEQ     PINCREMENT
    
    CMP.L   #4,D6
    BEQ     DECREMENT
    
    CMP.L   #7,D6
    BEQ     ABSOLUTE
    
    BRA     ERROR



*If data register, 
*check correct register
*return char value
DATAREG     
    CMP.L   #0,D7
    BEQ     PUSHD0
    CMP.L   #1,D7
    BEQ     PUSHD1
    CMP.L   #2,D7
    BEQ     PUSHD2
    CMP.L   #3,D7
    BEQ     PUSHD3
    CMP.L   #4,D7
    BEQ     PUSHD4
    CMP.L   #5,D7
    BEQ     PUSHD5
    CMP.L   #6,D7
    BEQ     PUSHD6
    CMP.L   #7,D7
    BEQ     PUSHD7
    BRA ERROR

PUSHD0
    *MOVE.B  #'#',(A1)+      *move # into good buffer
    MOVE.B  #'D',(A1)+
    MOVE.B  #'0',(A1)+
    *MOVE.L  DZERO,(A1)+
    BRA FINISH   
PUSHD1
    MOVE.B  #'D',(A1)+
    MOVE.B  #'1',(A1)+
    *MOVE.L  DONE,(A1)+
    BRA FINISH
PUSHD2
    MOVE.B  #'D',(A1)+
    MOVE.B  #'2',(A1)+
    *MOVE.L  DTWO,(A1)+
    BRA FINISH
PUSHD3
    MOVE.B  #'D',(A1)+
    MOVE.B  #'3',(A1)+
    
    *MOVE.L  DTHREE,(A1)+
    BRA FINISH
PUSHD4
    MOVE.B  #'D',(A1)+
    MOVE.B  #'4',(A1)+
    *MOVE.L  DFOUR,(A1)+
    BRA FINISH
PUSHD5
    MOVE.B  #'D',(A1)+
    MOVE.B  #'5',(A1)+
    *MOVE.L  DFIVE,(A1)+
    BRA FINISH
PUSHD6
    MOVE.B  #'D',(A1)+
    MOVE.B  #'6',(A1)+
    *MOVE.L  DSIX,(A1)+
    BRA FINISH
PUSHD7
    MOVE.B  #'D',(A1)+
    MOVE.B  #'7',(A1)+
    *MOVE.L  DSEVEN,(A1)+
    BRA FINISH

*ADDRESS REGISTER    
ADDREG      
    CMP.L   #0,D7
    BEQ     PUSHA0
    CMP.L   #1,D7
    BEQ     PUSHA1
    CMP.L   #2,D7
    BEQ     PUSHA2
    CMP.L   #3,D7
    BEQ     PUSHA3
    CMP.L   #4,D7
    BEQ     PUSHA4
    CMP.L   #5,D7
    BEQ     PUSHA5
    CMP.L   #6,D7
    BEQ     PUSHA6
    CMP.L   #7,D7
    BEQ     PUSHA7
    BRA ERROR

PUSHA0
    MOVE.B  #'A',(A1)+
    MOVE.B  #'0',(A1)+
    *MOVE.L  AZERO,(A1)+
    BRA FINISH
PUSHA1
    MOVE.B  #'A',(A1)+
    MOVE.B  #'1',(A1)+
    *MOVE.L  AONE,(A1)+
    BRA FINISH
PUSHA2
    MOVE.B  #'A',(A1)+
    MOVE.B  #'2',(A1)+
    *MOVE.L  ATWO,(A1)+
    BRA FINISH
PUSHA3
    MOVE.B  #'A',(A1)+
    MOVE.B  #'3',(A1)+
    *MOVE.L  ATHREE,(A1)+
    BRA FINISH
PUSHA4
    MOVE.B  #'A',(A1)+
    MOVE.B  #'4',(A1)+
    *MOVE.L  AFOUR,(A1)+
    BRA FINISH
PUSHA5
    MOVE.B  #'A',(A1)+
    MOVE.B  #'5',(A1)+
    *MOVE.L  AFIVE,(A1)+
    BRA FINISH
PUSHA6
    MOVE.B  #'A',(A1)+
    MOVE.B  #'6',(A1)+
    *MOVE.L  ASIX,(A1)+
    BRA FINISH   
PUSHA7
    MOVE.B  #'A',(A1)+
    MOVE.B  #'7',(A1)+
    *MOVE.L  ASIX,(A1)+
    BRA FINISH     
*INDIRECT
INDIRECT    
    CMP.L   #0,D7
    BEQ     PUSHI1
    CMP.L   #1,D7
    BEQ     PUSHI1
    CMP.L   #2,D7
    BEQ     PUSHI2
    CMP.L   #3,D7
    BEQ     PUSHI3
    CMP.L   #4,D7
    BEQ     PUSHI4
    CMP.L   #5,D7
    BEQ     PUSHI5
    CMP.L   #6,D7
    BEQ     PUSHI6
    CMP.L   #7,D7
    BEQ     PUSHI7
    BRA ERROR

PUSHI0
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'0',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  IZERO,(A1)+
    BRA FINISH    

PUSHI1
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'1',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  IONE,(A1)+
    BRA FINISH
PUSHI2
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'2',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  ITWO,(A1)+
    BRA FINISH
PUSHI3
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'3',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  ITHREE,(A1)+
    BRA FINISH
PUSHI4
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'4',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  IFOUR,(A1)+
    BRA FINISH
PUSHI5
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'5',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  IFIVE,(A1)+
    BRA FINISH
PUSHI6
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'6',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  ISIX,(A1)+
    BRA FINISH
PUSHI7
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'7',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  ISIX,(A1)+
    BRA FINISH
    
    
*POST INCREMENT    
PINCREMENT   
    CMP.L   #0,D7
    BEQ     PUSHPO1
    CMP.L   #1,D7
    BEQ     PUSHPO1
    CMP.L   #2,D7
    BEQ     PUSHPO2
    CMP.L   #3,D7
    BEQ     PUSHPO3
    CMP.L   #4,D7
    BEQ     PUSHPO4
    CMP.L   #5,D7
    BEQ     PUSHPO5
    CMP.L   #6,D7
    BEQ     PUSHPO6
    CMP.L   #7,D7
    BEQ     PUSHPO7    
    BRA ERROR

PUSHPO0
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'0',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POZERO,(A1)+
    BRA FINISH     

PUSHPO1
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'1',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POONE,(A1)+
    BRA FINISH
PUSHPO2
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'2',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POTWO,(A1)+
    BRA FINISH
PUSHPO3
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'3',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POTHREE,(A1)+
    BRA FINISH
PUSHPO4
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'4',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POFOUR,(A1)+
    BRA FINISH
PUSHPO5
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'5',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POFIVE,(A1)+
    BRA FINISH
PUSHPO6
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'6',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POSIX,(A1)+
    BRA FINISH
PUSHPO7
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'7',(A1)+
    MOVE.B  #')',(A1)+
    MOVE.B  #'+',(A1)+
    *MOVE.L  POSIX,(A1)+
    BRA FINISH 

     
*PRE DECREMENT
DECREMENT        
    CMP.L   #0,D7
    BEQ     PUSHPRE1
    CMP.L   #1,D7
    BEQ     PUSHPRE1
    CMP.L   #2,D7
    BEQ     PUSHPRE2
    CMP.L   #3,D7
    BEQ     PUSHPRE3
    CMP.L   #4,D7
    BEQ     PUSHPRE4
    CMP.L   #5,D7
    BEQ     PUSHPRE5
    CMP.L   #6,D7
    BEQ     PUSHPRE6
    CMP.L   #7,D7
    BEQ     PUSHPRE7    
    BRA ERROR

PUSHPRE0
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'0',(A1)+
    MOVE.B  #')',(A1)+
    
    *MOVE.L  PREZERO,(A1)+
    BRA FINISH
PUSHPRE1
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'1',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PREONE,(A1)+
    BRA FINISH 
PUSHPRE2
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'2',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PRETWO,(A1)+
    BRA FINISH 
PUSHPRE3
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'3',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PRETHREE,(A1)+
    BRA FINISH 
PUSHPRE4
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'4',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PREFOUR,(A1)+
    BRA FINISH 
PUSHPRE5
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'5',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PREFIVE,(A1)+
    BRA FINISH 
PUSHPRE6
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'6',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PRESIX,(A1)+
    BRA FINISH  
PUSHPRE7
    MOVE.B  #'-',(A1)+
    MOVE.B  #'(',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #'7',(A1)+
    MOVE.B  #')',(A1)+
    *MOVE.L  PRESIX,(A1)+
    BRA FINISH      
    


*For absolute, try storing address in data register, then converting all values to string
*subtraction for letters and numbers
*Josh may have something
*under reading subroutine in IO
*push a number into D6
*convert that to ascii
*can push that ascii code to good buffer

ABSOLUTE
*Need to check if word, long, or immediate first
*compare register (D7)
    MOVE.L  A5,D2
    CMP.L   #0,D7
    BEQ     WORD
    CMP.L   #1,D7
    BEQ     LONGWORD
    CMP.L   #4,D7
    BEQ     IMMEDIATE
    BRA     ERROR


*Can loop and send individual characters to good buffer

*HtoA
*AtoH
*Ascii and Hex conversions
*need to split Hex into 8 individual values
*LSR and LSL?
*Put individual hex values in D6
*fine to replace at this point since we already passed MODE section

*Assume address in D2

*Separate 1 hex value

*may need to build josh's method
*    JSR     Print_address
*    MOVE.L  (A5),D6
*

*Can assume everything is long
*Assume given size
*Need to check at beginning
IMMEDIATE
    MOVE.B  #'#',(A1)+
    *Byte
    CMP.B   #0,D1
    BEQ     IMMB
    *Word
    CMP.B   #1,D1
    BEQ     WORD
    *Long
    CMP.B   #2,D1
    BEQ     LONGWORD
    BRA     ERROR
    
IMMB
    MOVE.B  D2,D6
    
    AND.B   #%11110000,D6
    ROR.B   #4,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+
    
    MOVE.B  D2,D6
    
    AND.B   #%00001111,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+
    
    BRA FINISH


    
*Can use josh's methods
*Print_address
*A5 is working area
WORD
    *load to D6
    MOVE.W  D2,D6
    MOVE.B  #'$',(A1)+
    
    *1st hex
    AND.W  #%1111000000000000,D6
    ROR.W   #8,D6      
    ROR.W   #4,D6      
    JSR     HtoA
    MOVE.B  D6,(A1)+
    
    *reload
    MOVE.W  D2,D6
    
    *2nd hex
    AND.W  #%0000111100000000,D6
    ROR.W   #8,D6      
    JSR     HtoA
    MOVE.B  D6,(A1)+
    
    *reload
    MOVE.W  D2,D6
    
    *3rd hex
    AND.W  #%0000000011110000,D6
    ROR.W   #4,D6      
    JSR     HtoA
    MOVE.B  D6,(A1)+

    *reload
    MOVE.W  D2,D6

    *4th hex
    AND.W  #%0000000000001111,D6      
    JSR     HtoA
    MOVE.B  D6,(A1)+
    
    BRA FINISH
    
LONGWORD

    MOVE.L  D2,D6
    MOVE.B  #'$',(A1)+
    
    *first hex digit    
    AND.L  #%11110000000000000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #4,D6      
    JSR     HtoA  
    MOVE.B  D6,(A1)+
    *reset D6
    MOVE.L  D2,D6
    
    *2nd hex
    ANDI.L  #%00001111000000000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    JSR     HtoA  
    MOVE.B  D6,(A1)+
    
    *reset
    MOVE.L  D2,D6
    
    *3rd hex
    ANDI.L  #%00000000111100000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #4,D6      
    JSR     HtoA  
    MOVE.B  D6,(A1)+
    
    *reset
    MOVE.L  D2,D6
    
    *4th hex
    ANDI.L  #%00000000000011110000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+

    *reset
    MOVE.L  D2,D6
    
    *5th hex
    ANDI.L  #%00000000000000001111000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #4,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+     

    *reset
    MOVE.L  D2,D6
    
    *6th hex
    ANDI.L  #%00000000000000000000111100000000,D6
    ROR.L   #8,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+       

    *reset
    MOVE.L  D2,D6
    
    *7th hex
    ANDI.L  #%00000000000000000000000011110000,D6
    ROR.L   #4,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+   
    
    *reset
    MOVE.L  D2,D6
    
    ANDI.L  #%00000000000000000000000000001111,D6
    JSR     HtoA
    MOVE.B  D6,(A1)+    

    BRA FINISH
    
        
    

ERROR       

    MOVE.B  #'[',(A1)+
    MOVE.B  #'I',(A1)+
    MOVE.B  #'N',(A1)+
    MOVE.B  #'C',(A1)+
    MOVE.B  #'O',(A1)+
    MOVE.B  #'R',(A1)+
    MOVE.B  #'R',(A1)+
    MOVE.B  #'E',(A1)+
    MOVE.B  #'C',(A1)+
    MOVE.B  #'T',(A1)+
    MOVE.B  #' ',(A1)+
    MOVE.B  #'E',(A1)+
    MOVE.B  #'A',(A1)+
    MOVE.B  #']',(A1)+
    BRA FINISH



FINISH
    RTS
    
    
********************************************************************************
*
* p_hex - converts a word into ascii and puts into buffer A1, 4 bits at a time
*
********************************************************************************
p_hex       CMP.B   #$09,D3         *check if $value <= 9
            BLE     p_num           *if yes, branch to print the number
            CMP.B   #$0A,D3         *check if $value >= A
            BGE     p_char          *if yes, branch to print the letter
p_num       ADDI.B  #$30,D3         *add $30 to get the right ACSII code
            MOVE.B  D3,(A1)+        *move to buffer and increment
            RTS   
p_char      ADDI.B  #$37,D3         *add $37 to get the right ASCII code
            MOVE.B  D3,(A1)+        *move to buffer and increment
RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
