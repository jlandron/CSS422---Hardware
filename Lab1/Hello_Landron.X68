*-----------------------------------------------------------
* Title      :Hello World
* Written by :Joshua Landron, based on Easy68K tutorial
* Date       :4/6/2019
* Description:Sample program 1 for quickstart guide
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
        LEA     MESSAGE, A1     loads message into address register A1
        MOVE.B  #14, D0      Moves the number 14 into data register D0
        TRAP    #15            Display message
    
        MOVE    #9, D0 
        TRAP    #15            ; halt simulator

* Put variables and constants here
CR      EQU     $0D         Carriage return
LF      EQU     $0A         Line feed
MESSAGE DC.B    'Hello, My name is Josh Landron.',CR,LF,CR,LF
        DC.B    'This program was interesting to learn',CR,LF
        DC.B    'Assembly seems daunting, but the more I work with it,',CR,LF
        DC.B    'The easier it gets.',CR,LF
        DC.B    'I hope I can learn to use assembly well as the class continues',CR,LF,CR,LF
        DC.B    'Thank you for listening.',0  

        END     START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
