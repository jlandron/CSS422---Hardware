*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
CR      EQU     $0D
LF      EQU     $0A

        ORG     $1000
START:
        MOVE.L  #$CAFECAFE,-(A7)
        BSR     OUTHEX8
        ADDA.L  #4,A7

        MOVE.L  #$12345678,-(A7)
        BSR     OUTHEX8
        ADDA.L  #4,A7

        MOVE.L  #$9ABCDEF0,-(A7)
        BSR     OUTHEX8
        ADDA.L  #4,A7

        MOVE.W  #CR,-(A7)
        BSR     OUTCHAR
        ADDA.L  #2,A7

        MOVE.W  #LF,-(A7)
        BSR     OUTCHAR
        ADDA.L  #2,A7

        MOVE.B  #9,D0
        TRAP    #15

OUTHEX8 LINK    A6,#0
        MOVEM.L D0-D2,-(A7)
        MOVE.L  8(A6),D0
        MOVE.W  #8-1,D1
NXTDIG  ROL.L   #4,D0
        MOVE.L  D0,D2
        AND.L   #$0F,D2
        CMP.B   #10,D2
        BCS     UNDER10
        ADD.W   #$07,D2
UNDER10 ADD.W   #$30,D2
        MOVE.W  D2,-(A7)
        BSR     OUTCHAR
        ADDA.L  #2,A7
        DBRA    D1,NXTDIG
        MOVEM.L (A7)+,D0-D2
        UNLK    A6
        RTS

OUTCHAR LINK    A6,#0
        MOVEM.L D0-D1,-(A7)
        MOVE.W  8(A6),D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVEM.L (A7)+,D0-D1
        UNLK    A6
        RTS

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
