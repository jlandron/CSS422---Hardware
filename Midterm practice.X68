*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
START:                  ; first instruction of program
    MOVEA.L #$6000, A2
    MOVE.W  #$7C08,(A2)+
    MOVE.W  #$4428,(A2)+
    MOVE.W  #$4408,(A2)+
    MOVE.W  #$4408,(A2)+
    MOVE.W  #$7C3E,(A2)   
    MOVEA.L #$6000, A2
    
* Put program code here
    MOVE.B  #0, D4
    MOVE.B  #5, D5
PRE_PRINT
    MOVE.B  #15, D0
    MOVE.B  #2 , D2
    MOVE.W  (A2)+,D1
    TRAP    #15
    JSR     PRINT_BLANK
    ADDI.B  #1, D4
    CMP.W   D4, D5
    BNE     PRE_PRINT
    
    MOVEA.L #$6000, A2
    MOVE.B  #0, D2
    MOVE.B  #5, D3
AND_LOOP
    ANDI.W  #$00FF,(A2)+
    ADDI.B  #1, D2
    CMP.W   D2, D3
    BNE     AND_LOOP
    
    *Reset A2 and counters
    MOVEA.L #$6000, A2
    MOVE.B  #0, D2
    MOVE.B  #5, D3
PUSH_LOOP    
    MOVE.W  (A2)+,-(SP)
    ADDI.B  #1, D2
    CMP.W   D2, D3
    BNE     PUSH_LOOP
    
    MOVEA.L #$6000, A2
    MOVE.B  #0, D2
    MOVE.B  #5, D3
POP_LOOP
    MOVE.W  (SP)+,(A2)+
    ADDI.B  #1, D2
    CMP.W   D2, D3
    BNE     POP_LOOP
    
    JSR     PRINT_BLANK
    MOVEA.L #$6000, A2
    MOVE.B  #0, D4
    MOVE.B  #5, D5
POST_PRINT
    MOVE.B  #15, D0
    MOVE.B  #2 , D2
    MOVE.W  (A2)+,D1
    TRAP    #15
    JSR     PRINT_BLANK
    ADDI.B  #1, D4
    CMP.W   D4, D5
    BNE     POST_PRINT
    
    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT_BLANK
    LEA     BLANK_MSG,A1    *Move print to new line
    MOVE.B  #14, D0
    TRAP    #15  
    RTS 

CR      EQU     $0D
LF      EQU     $0A

BLANK_MSG   DC.B    '',CR,LF,0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
