*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
 
  *Subroutines
ADD_ONE     LEA MSG_ONE, A1
            MOVE.L  #14,D0
            TRAP    #15
            RTS         *Will pop address from stack and return


ADD_ZERO    LEA MSG_ZERO, A1
            MOVE.L  #14,D0
            TRAP    #15
            RTS
            
            
            
LOCATION        EQU     $6000    
                
    
*ALL_REGISTERS   REG     DO-D7/A0-A6
GROUP           REG     D0-D3/A0-A6

   
START:                  ; first instruction of program
        MOVE.L  #$4567,LOCATION
* Put program code here
    
            MOVE.L  #0, D0  *INCREMENT COUNTER
            MOVE.L  #16, D1 *STOP NUMBER
FOR_LOOP    CMP.B   D0, D1
            BEQ     END_LOOP
            
            *If Statement
            MOVE.L  (LOCATION),D2  *DATA FRO COMPARISON
            BTST.L  D0,D2
            BEQ     GO_ZERO
            BRA     GO_ONE
            
GO_ZERO     MOVEM   GROUP,-(SP)
            JSR     ADD_ZERO        *Will jump to Subroutine
            MOVEM   (SP)+,GROUP
            ADDQ.L  #1, D0          
            BRA     FOR_LOOP
            
GO_ONE      MOVEM   GROUP,-(SP)
            JSR     ADD_ONE
            MOVEM   (SP)+,GROUP

            ADDQ.L  #1, D0          
            BRA     FOR_LOOP
              
END_LOOP    LEA END_MESSAGE, A1
            MOVE.L  #14,D0
            TRAP    #15
            
            SIMHALT             ; halt simulaton
            




* Put variables and constants here            


CR      EQU     $0D         *Carriage return
LF      EQU     $0A         *Line feed

MSG_ZERO    DC.B    'ZERO FOUND',CR,LF,0
MSG_ONE     DC.B    'ONE FOUND',CR,LF,0
END_MESSAGE     DC.B    'END OF LOOP',0

    END    START        ; last line of source
    
    
    
    
    
    
    
    
    
    
    *Stack_push  Move.l  #15,-(SP)
*Stack_pop   Move.l  (SP)+,D0

*Save_Registers  MOVEM   GROUP,-(SP)
*Load_Registers  MOVEM   (SP)+,GROUP
    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
