*-----------------------------------------------------------
* Title      :68k Dissasembler
* Written by :Joshua Landron, Hyuk Gi Lee, William Nguyen
*-----------------------------------------------------------
* Title      :Dissasembler IO
* Written by :Joshua Landron
* Date       :4Jun2019
* Description:Simple 68k dissasembler, 
*     Test code is loaded the the bottom of this file
*-----------------------------------------------------------

*-----------------------------------------------
* Front facing program
*
* D1 - holds trap codes only
* D2 - message start
* D3 - holds how many lines printed
* A5 - working memory pointer
* A6 - holds last memory location of program being decoded
* A7 - STACK POINTER (SP)
* -------Variables----------
START_ADDR      DS.L    1
END_ADDR        DS.L    1

* stacks to hold chars to be printed, saved as a string
GOOD_BUFF       DS.W   100
* define the maximum number of lines to be printed (page length)
MAX_LENGTH      EQU     $1E

*-------------------------------------------
*-------------------------------------------
*Main start
*-------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    *print welcome and start messages
    JSR     Print_welcome
main_loop
    JSR     Clear_registers
    JSR     Print_start  *print start messege
    JSR     Get_start    *gets start address
    JSR     Print_end
    JSR     Get_end      
    *Load A1 with good buffer address
    LEA     GOOD_BUFF,A1
    *Load A6 with start location of program to be decoded
    MOVEA.L START_ADDR,A5
    MOVE.L END_ADDR,A6
    
op_loop
    
    LEA     GOOD_BUFF,A1
    JSR     Print_address
    MOVEM.L D0-D7/A0/A2/A3/A4/A6,-(SP)
    JSR     opcode
    MOVEM.L (SP)+,D0-D7/A0/A2/A3/A4/A6
    JSR     Print_buffer
    
    CMPA.L  A6,A5   *Compare working address with end address
    BLE     op_loop *continue loop or
    BRA     main_loop *continue to run again
    
    

    SIMHALT             ; halt simulator
    
*-------------------------------------------
* Subroutines
*-------------------------------------------
Print_buffer
    MOVEM.L     A2,-(SP)        *store A2 on the stack
            
    MOVE.B      #CR,(A1)+  
    MOVE.B      #LF,(A1)+  
    MOVE.B      #$00,(A1)   *end symbol
    MOVEA.L     A1,A2         
    LEA         GOOD_BUFF,A1 *go to the bottom of the Buffer
    MOVE.B      #14,D0
    TRAP        #15
    JSR         Increment
    MOVEM.L     (SP)+,A2
    RTS   
    
*-------------------------------------------
* Clear_registers
*-------------------------------------------
Clear_registers
    MOVEA.L     #$0,A0
    MOVEA.L     #$0,A1
    MOVEA.L     #$0,A2
    MOVEA.L     #$0,A3
    MOVEA.L     #$0,A4
    MOVEA.L     #$0,A5
    MOVEA.L     #$0,A6
    CLR         D0
    CLR         D1
    CLR         D2
    CLR         D3
    CLR         D4
    CLR         D5
    CLR         D6
    CLR         D7
    RTS
    
*--------------------------------------------
* Get_start
*------------------------------------------- 
Get_Start
    *take one word hex value from user, 
    JSR READ_CHAR       *Read first digit
    JSR AtoH
    LSL.W   #8,D6
    LSL.W   #4,D6
    MOVE.W  D6,D2       *save first digit

    JSR READ_CHAR       *read second digit
    JSR AtoH
    LSL.W   #8,D6
    ADD.W   D6,D2      *Add to first digit HEX digits
    
    JSR READ_CHAR       *read third digit
    JSR AtoH
    LSL.W   #4,D6
    ADD.W   D6,D2      *Add to first digit HEX digits

    JSR READ_CHAR       *read fourth digit
    JSR AtoH
    ADD.W   D6,D2      *Add to first digit HEX digits
    
    MOVE.L  D2, START_ADDR   *save to START_ADDR
    
    CLR.L   D2          *Clear used registers
    CLR.L   D6
    LEA     BLANK_MSG,A1    *Move output to new line
    MOVE.B  #14,D0
    TRAP    #15
    RTS
    
*--------------------------------------------
* Get_end
*------------------------------------------- 
Get_end
    *take one word hex value from user, 
    JSR READ_CHAR       *Read first digit
    JSR AtoH
    LSL.W   #8,D6
    LSL.W   #4,D6
    MOVE.W  D6,D2       *save first digit

    JSR READ_CHAR       *read second digit
    JSR AtoH
    LSL.W   #8,D6
    ADD.W   D6,D2      *Add to first digit HEX digits
    
    JSR READ_CHAR       *read third digit
    JSR AtoH
    LSL.W   #4,D6
    ADD.W   D6,D2      *Add to first digit HEX digits

    JSR READ_CHAR       *read fourth digit
    JSR AtoH
    ADD.W   D6,D2      *Add to first digit HEX digits
    
    MOVE.L  D2, END_ADDR   *save to START_ADDR
    
    CLR.L   D2          *Clear used registers
    CLR.L   D6
    LEA     BLANK_MSG,A1    *Move output to new line
    MOVE.B  #14,D0
    TRAP    #15
    RTS

*--------------------------------------------
* Reading subroutine
*------------------------------------------- 
READ_CHAR
    MOVE.B      #5, D0
    TRAP        #15
    MOVE.L      D1, D6 *Store char in D6
    RTS
    
*PARAMETER SHOULD BE STORED IN D6
AtoH
    CMP.B       #$39, D6    *30-39 ARE NUMBERS, GREATER IS A LETTER
    BGT.B       ALPHA
    SUBI.B      #$30, D6
    RTS
    
ALPHA
    SUBI.B      #$37, D6
    RTS

*----printing subroutine----

PRINT_CHAR
    MOVE.B      #6, D0
    MOVE.B      D6, D1
    TRAP        #15
    RTS
    
HtoA    
    CMPI.B      #9, D6
    BGT         ABCD
NUM 
    ADDI.B      #$30, D6
    RTS
ABCD
    ADDI.B      #$37, D6
    RTS
*-----------------------------------------
*Printing subroutines for HEX to ASCII
*----------------------------------------       
PRINT_WORD *STORE INITIAL WORD IN D2
    MOVE.W      D2, D6 *MOVE ENTIRE WORD TO D6 FOR WORK
    LSR.W       #8, D6 *shift right to eliminate first 3 digits
    LSR.B       #4, D6
    JSR         HtoA
    MOVE.B      D6, D1
    JSR         PRINT_CHAR
    MOVE.W      D2, D6  *max shift is one Byte
    LSL.L       #8, D6  *shift left to delete first digit
    LSL.L       #8, D6
    LSL.L       #4, D6
    LSR.L       #8, D6  *shift right to move desired digit to first 4 bits
    LSR.L       #8, D6
    LSR.L       #8, D6
    LSR.B       #4, D6
    JSR         HtoA
    MOVE.B      D6, D1
    JSR         PRINT_CHAR
    JSR         PRINT_BYTE    
    RTS

PRINT_BYTE *STORE INITIAL BYTE IN D2
    MOVE.B      D2, D6
    LSR.B       #4, D6
    JSR         HtoA
    MOVE.B      D6, D1
    JSR         PRINT_CHAR 
    MOVE.B      D2, D6
    LSL.B       #4, D6
    LSR.B       #4, D6
    JSR         HtoA
    MOVE.B      D6, D1
    JSR         PRINT_CHAR
    RTS

*-----------------------------------------
* Print messages
*-----------------------------------------
Print_welcome
    LEA         Wel_msg,A1
    MOVE.B      #14,D0
    TRAP        #15
    RTS
Print_start
    LEA         Start_msg,A1
    MOVE.B      #14,D0
    TRAP        #15
    RTS     
Print_end
    LEA         End_msg,A1
    MOVE.B      #14,D0
    TRAP        #15
    RTS       
*------------------------------------------
*Clear screen
*------------------------------------------
Clear_scr   
    CLR         D1
    MOVE.W      #$FF00,D1
    MOVE.B      #11,D0
    TRAP        #15
    CLR         D3
    MOVEM.L     (SP)+,D0/D1/A1
    RTS     
    
**********************************************************************
* Increment
**********************************************************************
Increment
            MOVEM.L     D0/D1/A1,-(SP) *save D1 and A1
            CLR         D1
            ADD.L       #$01,D3    
            CMP         #MAX_LENGTH,D3
            BGE         Wait
            MOVEM.L     (SP)+,D0/D1/A1
            RTS  
    
*-----------------------------------------
* Pause
*-----------------------------------------
Wait        LEA         continue,A1
            MOVE.B      #14,D0
            TRAP        #15
            
Enter_loop  MOVE.B      #5,D0
            TRAP        #15
            
            CMP.B       #$0D,D1
            BEQ         Clear_scr
            BRA         Enter_loop      
            
**********************************************************************
* print current address
**********************************************************************            
Print_address            
    MOVEM.L     D6,-(SP)
            

    CLR     D6          *prep D6 by clearing it
            
    *get long word at (A5)*            
    MOVE.L  A5,D6  

    *print 1st(left) hex digit
    AND.L  #%11110000000000000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #4,D6      
    JSR     HtoA  
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6

    *print 2nd from left hex digit *
    ANDI.L  #%00001111000000000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #8,D6
    JSR     HtoA             
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6

    *print 3rd from left hex digit*
    ANDI.L  #%00000000111100000000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6      
    ROR.L   #4,D6
    JSR     HtoA             
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6

    *print 3rd from left hex digit *
    ANDI.L  #%00000000000011110000000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #8,D6
    JSR     HtoA             
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6
            
    *print 3rd from left hex digit*
    ANDI.L  #%00000000000000001111000000000000,D6
    ROR.L   #8,D6      
    ROR.L   #4,D6
    JSR     HtoA            
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6
            
    *print 3rd from left hex digit *
    ANDI.L  #%00000000000000000000111100000000,D6
    ROR.L   #8,D6
    JSR     HtoA            
    JSR     print_char
         
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6
           
    *print 3rd from left hex digit to*
    ANDI.L  #%00000000000000000000000011110000,D6
    ROR.L   #4,D6
    JSR     HtoA            
    JSR     print_char
            
    *reset D6 to hold lower order byte again*
    MOVE.L  A5,D6
              
    *print lowest order hex digit*
    ANDI.L  #%00000000000000000000000000001111,D6
    JSR     HtoA
    JSR     print_char       
    
    *put spaces in buffer      
    MOVE.B  #' ',(A1)+
    MOVE.B  #' ',(A1)+
    MOVE.B  #' ',(A1)+
 
    *return whatever was in d6        
    MOVEM.L (SP)+,D6

    RTS

  
**********************************************************************
* Includes
**********************************************************************

            INCLUDE "opcode.x68"    
            INCLUDE "ea.x68"
* Put variables and constants here
CR          EQU     $0D
LF          EQU     $0A

Wel_msg     DC.B    '###########################',CR,LF
            DC.B    '#                         #',CR,LF
            DC.B    '#    68k Dissasembler     #',CR,LF
            DC.B    '#           by:           #',CR,LF
            DC.B    '#       Josh Landron      #',CR,LF
            DC.B    '#      William Hguyen     #',CR,LF
            DC.B    '#         Gi Lee          #',CR,LF
            DC.B    '#                         #',CR,LF
            DC.B    '###########################',CR,LF,0
            
Start_msg   DC.B    'Enter the starting address word value: $',0
End_msg     DC.B    'Ender the ending address word value: $',0
Continue    DC.B    'Press Enter to continue',0
BLANK_MSG   DC.B    '',CR,LF,0
  

    END    START        ; last line of source



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
