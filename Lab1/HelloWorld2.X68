*-----------------------------------------------------------
* Title      :HelloWorld2
* Written by :Joshua Landron, based on Easy68K tutorial
* Date       :4/6/2019
* Description:Sample program 2 for quickstart guide
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    *----OUTPUT----
LOOP    LEA     MESSAGE, A1
        MOVE.B  #14, D0
        TRAP    #15
    
    *----INPUT----
        MOVE.B  #4, D0
        TRAP    #15     Read a number from keyboard
        CMP.L   #0, D1  CMP.L compares D1 to 0, L COMPARES EQUALITY
        BEQ     DONE    Branch to DONE if the comparison is true
        
        CMP.B   #0, D1  Compares D1 to 0
        BLT     INVALID BLT branch if D1 is less than 0
        CMP.B   #9, D1  Compares D1 to 9
        BGT     INVALID BGT loop if D1 is greater than 9 
        
        CMP.B   #1, D1      Compare D1 to 1
        BNE     TWO         Beq branches if D1 and 1 are not equal
        LEA     DISPONE,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP
        
TWO     CMP.B   #2, D1      Compare D1 to 2
        BNE     THREE       Beq branches if D1 and 2 are not equal
        LEA     DISPTWO,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

THREE   CMP.B   #3, D1      Compare D1 to 2
        BNE     FOUR        Beq branches if D1 and 3 are not equal
        LEA     DISPTHREE,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

FOUR    CMP.B   #4, D1      Compare D1 to 2
        BNE     FIVE        Beq branches if D1 and 4 are not equal
        LEA     DISPFOUR,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

FIVE    CMP.B   #5, D1      Compare D1 to 2
        BNE     SIX         Beq branches if D1 and 5 are not equal
        LEA     DISPFIVE,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

SIX     CMP.B   #6, D1      Compare D1 to 2
        BNE     SEVEN       Beq branches if D1 and 6 are not equal
        LEA     DISPSIX,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

SEVEN   CMP.B   #7, D1      Compare D1 to 2
        BNE     EIGHT       Beq branches if D1 and 7 are not equal
        LEA     DISPSEVEN,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP
        
EIGHT   CMP.B   #8, D1      Compare D1 to 2
        BNE     NINE        Beq branches if D1 and 8 are not equal
        LEA     DISPEIGHT,A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     LOOP

NINE    LEA     DISPNINE,A1
        MOVE.B  #14, D0
        TRAP    #15
        
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

MESSAGE DC.B    'Enter a number between 1 and 9, Enter 0 to exit: ',0
INV     DC.B    'That is not a number between 0 and 9',CR,LF,0
DISPONE DC.B    'HELLO MURCURY',CR,LF,0
DISPTWO DC.B    'HELLO VENUS',CR,LF,0
DISPTHREE DC.B  'HELLO EARTH',CR,LF,0
DISPFOUR DC.B   'HELLO MARS',CR,LF,0
DISPFIVE DC.B   'HELLO JUPITER',CR,LF,0
DISPSIX DC.B    'HELLO SATURN',CR,LF,0
DISPSEVEN DC.B  'HELLO URANUS',CR,LF,0
DISPEIGHT DC.B  'HELLO NEPTUNE',CR,LF,0
DISPNINE DC.B   'HELLO PLUTO :`(',CR,LF,0

        END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
