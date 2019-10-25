*-----------------------------------------------------------
* Title      :HelloWorld2
* Written by :Joshua Landron, based on Easy68K tutorial
* Date       :4/6/2019
* Description:Sample program 2 for quickstart guide
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
*-------------OUTPUT---------
LOOP    LEA     MESSAGE, A1
        MOVE.B  #14, D0
        TRAP    #15
    
*-------------INPUT-----------
        MOVE.B  #4, D0
        TRAP    #15          Read a number from keyboard
        CMP.L   #0, D1       CMP.L compares D1 to 0, L COMPARES EQUALITY
        BEQ     DONE         Branch to DONE if the comparison is true

*------CHECKING VALUE---------            
        CMP.B   #20, D1      Compares D1 to 20
        BLT     INVALID      BLT branch if D1 is less than 20
        CMP.B   #25, D1      Compares D1 to 25
        BGT     INVALID      BGT loop if D1 is greater than 25 
        
        CMP.B   #20, D1      Compare D1 to 20
        BNE     TONE         Beq branches if D1 and 1 are not equal
        LEA     DISP20,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP
        
TONE    CMP.B   #21, D1      
        BNE     TTWO        
        LEA     DISP21,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

TTWO    CMP.B   #22, D1     
        BNE     TTHREE         
        LEA     DISP22,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

TTHREE  CMP.B   #23, D1      
        BNE     TFOUR         
        LEA     DISP23,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

TFOUR   CMP.B   #24, D1      
        BNE     TFIVE          
        LEA     DISP24,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

TFIVE   LEA     DISP25,A1  Last option is 25
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP
        
*------INVALID ENTRY----------        
INVALID LEA     INV, A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP
        
DONE    MOVE.B  #9, D0
        TRAP    #15   

        SIMHALT             ; halt simulator

* Put variables and constants here
CR      EQU     $0D
LF      EQU     $0A

MESSAGE DC.B    'Enter a number between 20 and 25, Enter 0 to exit: ',0
INV     DC.B    'AWW Shucks! That is not a number between 20 and 25!',CR,LF,0
DISP20  DC.B    'Fun fact: It rains diamonds on Saturn.',CR,LF,0
DISP21  DC.B    'Fun fact: Squids have donut shaped brains.',CR,LF,0
DISP22  DC.B    'Fun fact: A cat has been gentically modified to glow in the dark.',CR,LF,0
DISP23  DC.B    'Fun fact: Yoda and Miss.Piggy were voiced by the same person.',CR,LF,0
DISP24  DC.B    'Fun fact: France is the most viseted country in the world.',CR,LF,0
DISP25  DC.B    'Fun fact: There is a parking spot in Manhattan that sold for $1 million.',CR,LF,0


        END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
