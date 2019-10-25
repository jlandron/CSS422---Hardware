*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
        ORG    $1000
START:                  ; first instruction of program

* Put program code here

        move.l  #5, D0
        move.l  #5, D1
        cmp.l   D0, D1
        BEQ     EQUAL
        JMP     N_EQUAL
        
EQUAL   LEA MSG_EQUAL, A1
        move.b  #14, D0
        TRAP    #15
        JMP     END
        
N_EQUAL LEA MSG_N_EQUAL, A1
        move.b  #14, D0
        TRAP    #15
        JMP     END

END     SIMHALT             ; halt simulator

* Put variables and constants here

MSG_EQUAL   DC.B    'Numbers are equal',0
MSG_N_EQUAL DC.B    'Numbers are not equal',0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
