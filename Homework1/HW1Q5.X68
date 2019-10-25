*-----------------------------------------------------------
* Title      :HW1P5
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    LEA     START_MSG,A1    *Print prompt
    MOVE.B  #14, D0
    TRAP    #15
    
    MOVE.B  #4,D0           *prepare to take first keyboard entry
    TRAP    #15
    MOVE.B  D1,D2           *Store first number in D2
    TRAP    #15  
    MOVE.B  D1,D3           *Second number is stored in D3
    
    ADD.B   D2,D3           *the result is stored in D3
    BVS.S   OVERFLOW        *check for overflow, print message if there is
    
    
        
    
RESULTS     MOVE.B  D3,$6000        *Move result into memory
            CLR.L   D1              *clear D1 becasue the trap function fills it with F's
            MOVE.B  $6000,D1        
            LEA     ANSWER,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVE.B  #3,D0           *print result
            TRAP    #15
    

    SIMHALT           ; halt simulator
*------------------------------------------------------------
*   Save processor state and print message,then return
*------------------------------------------------------------
    
OVERFLOW    MOVEM.L A1-A6/D0-D7,-(SP)
            LEA OF_MSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVEM.L (SP)+,A1-A6/D0-D7
            JMP     RESULTS
            

* Put variables and constants here
CR          EQU     $0D         *Carriage return
LF          EQU     $0A         *Line feed
START_MSG   DC.B    'Hello, type two decimal numbers to be added in my 16bit system',CR,LF,0
ANSWER      DC.B    CR,LF,'The answer recieved is : ',0
OF_MSG      DC.B    'OVERFLOW OCCURED, RESULT NOT CORRECT!',0
        
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
