*-----------------------------------------------------------
* Title      :H1Q4
* Written by :Joshua Landron
* Date       :17Apr2019
* Description:What is the WORD VALUE (not byte, or longword) of the data in memory location $4000, when the program is just about to
*             loop back to the place where "start" is labelled? Please describe how you got the answer as well. (For example, you can describe how
*             you analyzed the code segments, or how you traced the code segments with debug tools)
* Answer:Before executing the S68 file, I placed a breakpoint on the line with the JMP command. This pauses the execution before that works.
*        I executed the code and then examind the stack when the code paused, the word value at $4000 is 4515. I found this easily because the 
*        address $4000 is stored in A1, so choosing that register points directly at the memory location i needed.      
*-----------------------------------------------------------
    ORG $400    
********************************************************************************************************
*
* Beginning of EQUates section, just like #define in C
*
********************************************************************************************************
addr1 EQU $4000
addr2 EQU $4001
data2 EQU $A7FF
data3 EQU $5555
data4 EQU $0000
data5 EQU 4678
data6 EQU %01001111
data7 EQU %00010111
********************************************************************************************************
*
* Beginning of code segment. This is the actual assembly language instructions.
*
********************************************************************************************************
* the program will run in memory


start   MOVE.W  #data2,D0   * Load D0
        MOVE.B  #data6,D1   * Load D1
        MOVE.B  #data7,D2   * load D2
        MOVE.W  #data3,D3   * load D3
        MOVEA.W #addr1,A0   * load address register
        MOVE.B  D1,(A0)+    * transfer byte to memory
        MOVE.B  D2,(A0)+    * transfer second byte
        MOVEA.W #addr1,A1   * load address
        AND.W   D3,(A1)     * Logical AND

        JMP     start   * This instruction keeps the program
                * looping forever
            
        END    $400       ; last line of source
                        * where the program source code ends and
                        * where to load the program in memory.
* End of the program

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
