*-----------------------------------------------------------
* Title      : disassembler opcode
* Written by : Hyuk Gi Lee
* Date       : June 4th 2019
* Description: 68k disassembler
*-----------------------------------------------------------

*-----------------------------------------------------------
*           MAIN OPCODE
*-----------------------------------------------------------
opcode
            MOVEM.L D1,-(SP)
            MOVE.W  #$FFFF,D0       
            MOVE.W  (A5)+,D2        
            LEA     op_jump,A0
            CLR.L   D1
            MOVE.W  D2,D1           
            LSR.W   #8,D1           
            LSR.W   #4,D1           
            MULU    #6,D1           
            JSR     00(A0,D1)         
            MOVEM.L (SP)+,D1    
            RTS
            
*-----------------------------------------------------------
 
*-----------------------------------------------------------
*           OP JUMP TABLE
*-----------------------------------------------------------
op_jump   
            JMP     t_0000  
            JMP     t_0001  
            JMP     t_0010  
            JMP     t_0011  
            JMP     t_0100  
            JMP     t_0101  
            JMP     t_0110  
            JMP     t_0111
            JMP     t_1000
            JMP     t_1001
            JMP     t_1010
            JMP     t_1011
            JMP     t_1100
            JMP     t_1101
            JMP     t_1110
            JMP     t_1111
            
*-----------------------------------------------------------
         
*-----------------------------------------------------------
*           SUBROUTINE FOR  OUTPUT  
*-----------------------------------------------------------
op_ADD     
            MOVE.B  #'A',(A1)+
            MOVE.B  #'D',(A1)+
            MOVE.B  #'D',(A1)+
            MOVE.B  #'.',(A1)+
            JSR     get_Length     
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.W  D1,D3      
            ANDI.W  #$0004,D3  
            CMPI.W  #$0004,D3  
            BEQ     Dn_EA       
            BNE     EA_Dn            
            RTS

*-----------op_ADDA------------------------------------------
op_ADDA    
            MOVE.B  #'A',(A1)+
            MOVE.B  #'D',(A1)+
            MOVE.B  #'D',(A1)+
            MOVE.B  #'A',(A1)+ 
            MOVE.B  #'.',(A1)+
            JSR     SUBA_WL     
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            JSR     from_EA     * get EA
            JSR     ea_main     
            MOVE.B  #',',(A1)+
            MOVE.W  D2,D1       
            ANDI.W  #$0E00,D1   
            LSL.W   #4,D1       
            LSR.W   #4,D1       
            LSR.W   #8,D1       
            LSR.W   #1,D1       
            JSR     addressregister_A
            RTS
            
*-----------op_MULS------------------------------------------
op_MULS 
            MOVE.B  #'M',(A1)+
            MOVE.B  #'U',(A1)+
            MOVE.B  #'L',(A1)+
            MOVE.B  #'S',(A1)+
            MOVE.B  #'.',(A1)+
            JSR     get_length
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            JSR     dataregister_D
            *get #<data>
            MOVE.B  #',',(A1)+
            *get Dn
            JSR     dataregister_D
            RTS 
            
*-----------op_AND------------------------------------------
op_AND     
            MOVE.B  #'A',(A1)+
            MOVE.B  #'N',(A1)+
            MOVE.B  #'D',(A1)+
            MOVE.B  #'.',(A1)+
            JSR     get_Length
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.W  D1,D3      
            ANDI.W  #$0004,D3  
            CMPI.W  #$0004,D3  
            BEQ     Dn_EA       
            BNE     EA_Dn       
            RTS

*-----------op_JSR-------------------------------------------  
op_JSR
            MOVE.B  #'J',(A1)+
            MOVE.B  #'S',(A1)+
            MOVE.B  #'R',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            JSR     from_EA       
            JSR     ea_main
            RTS
            
*-----------op_LEA------------------------------------------
op_LEA                
            MOVE.B  #'L',(A1)+ 
            MOVE.B  #'E',(A1)+ 
            MOVE.B  #'A',(A1)+ 
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+ 
            MOVE.B  #' ',(A1)+ 
            MOVE.B  #' ',(A1)+ 
            MOVE.B  #' ',(A1)+                     
            MOVE.W  D2,D1          
            JSR     from_EA       
            JSR     ea_main       
            MOVE.W  D2,D1        
            ANDI.W  #$0FFF,D1    
            LSR.W   #8,D1         
            LSR.W   #1,D1           
            MOVE.B  #',',(A1)+     
            JSR     addressregister_A  
            RTS
            
*-----------op_MOVE-----------------------------------------
op_MOVE    
            MOVE.B  #'M',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'V',(A1)+
            MOVE.B  #'E',(A1)+
            MOVE.B  #'.',(A1)+
            MOVE.B  D1,(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            RTS
            
*-----------op_MOVEA-----------------------------------------
op_MOVEA
            MOVE.B  #'M',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'V',(A1)+
            MOVE.B  #'E',(A1)+
            MOVE.B  #'A',(A1)+
            MOVE.B  #'.',(A1)+
            MOVE.B  D1,(A1)+
            MOVE.B  #' ',(A1)+
            RTS
            
*-----------op_MOVEM-----------------------------------------
op_MOVEM   
            MOVE.B  #'M',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'V',(A1)+
            MOVE.B  #'E',(A1)+
            MOVE.B  #'M',(A1)+
            MOVE.B  #'.',(A1)+
            MOVE.W  D2,D1       
            ANDI.W  #$0040,D1   
            LSR.W   #6,D1       
            CMPI.W  #$0000,D1      * check size
            BEQ     op_MOVEMW      * if W, do MOVEMW
            BNE     op_MOVEML      * else, MOVEML
next_MOVEM            
            MOVE.B  #' ',(A1)+
            MOVE.W  D2,D1       
            ANDI.W  #$0400,D1   
            LSR.W   #8,D1       
            LSR.W   #2,D1      
            CMPI.W  #$0000,D1   
            BEQ     reg_mem     * reg to mem
            BNE     mem_reg     
            RTS
op_MOVEMW
            MOVE.W  #$0001,D1
            JSR     get_Length
            BRA     next_MOVEM
op_MOVEML
            MOVE.W  #$0002,D1
            JSR     get_Length
            BRA     next_MOVEM
reg_mem
            MOVE.W  (A5)+,D3
            MOVE.W  D3,D4
            ANDI.W  #$00FF,D4 
            MOVE.W  #$0008,D1
            MOVE.W  #$0000,D6
            
ALOOPd       
            SUBI.W  #$0001,D1
            JSR     checkbitAd
            ADDI.W  #$0001,D6
            CMPI.W  #$0000,D1
            BNE     ALOOPd
            
            *data part
            MOVE.W  D3,D4
            ANDI.W  #$FF00,D4 *get rid of data register
            LSR.W   #8,D4     *get data registers to the start
            MOVE.W  #$0008,D1 
            MOVE.W  #$0000,D6
DLOOPdd      
            SUBI.W  #$0001,D1 
            JSR     checkbitDd
            ADDI.W  #$0001,D6
            CMPI.W  #$0000,D1   *see if we reached the value 8[no reg with that value]
            BNE     DLOOPdd       *if not, go back to DLOOPd
            **
            *get rid of last slash
            MOVE.B  #$FF,-(A1)
            MOVE.B  #$FF,(A1)         
            *
            MOVE.B  #',',(A1)+
            * CALL EA
            JSR     from_EA
            JSR     ea_main
            **
            RTS            
checkbitAd
            BTST    D6,D4
            BNE     addressSlash
            RTS
            
checkbitDd
            BTST    D6,D4
            BNE     dataSlash
            RTS       
mem_reg
            JSR     from_EA
            JSR     ea_main
            MOVE.B  #',',(A1)+
            MOVE.W  (A5)+,D3 
            MOVE.W  D3,D4
            ANDI.W  #$00FF,D4 
            MOVE.W  #$0000,D1
DLOOP       
            JSR     checkbitD
            ADDI.W  #$0001,D1
            CMPI.W  #$0008,D1
            BNE     DLOOP
            
            *address part
            MOVE.W  D3,D4
            ANDI.W  #$FF00,D4 *get rid of data register
            LSR.W   #8,D4     *get address registers to the start
            MOVE.W  #$0000,D1
ALOOP       
            JSR     checkbitA
            ADDI.W  #$0001,D1   *add 1 to register
            CMPI.W  #$0008,D1   *see if we reached the value 8[no reg with that value]
            BNE     ALOOP       *if not, go back to ALOOP
            **
            *get rid of last slash
            MOVE.B  #$FF,-(A1)
            MOVE.B  #$FF,(A1)
            RTS  
checkbitA
            BTST    D6,D4
            BNE     addressSlash
            RTS
            
checkbitD
            BTST    D6,D4
            BNE     dataSlash
            RTS  
dataSlash    
            JSR     dataregister_D
            MOVE.B  #'/',(A1)+
            RTS

addressSlash
            JSR     addressregister_A
            MOVE.B  #'/',(A1)+
            RTS             
*-----------op_MOVEQ-----------------------------------------
op_MOVEQ
            MOVE.B  #'M',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'V',(A1)+
            MOVE.B  #'E',(A1)+
            MOVE.B  #'Q',(A1)+
            MOVE.B  #'.',(A1)+
            MOVE.W  D2,D1       
            *call #<data>
            *call Dn
            RTS   
            
*-----------op_NOP-----------------------------------------
op_NOP
            MOVE.B  #'N',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'P',(A1)+
            RTS
*-----------op_NOT-----------------------------------------
op_NOT     
            MOVE.W  D2,D1           
            LSR.W   #6,D1           
            MOVE.B  #'N',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'T',(A1)+                                  
            MOVE.B  #'.',(A1)+         
            JSR     get_Length            
            MOVE.B  #' ',(A1)+      
            MOVE.B  #' ',(A1)+      
            MOVE.B  #' ',(A1)+     
            JSR     from_EA       
            JSR     ea_main         
            RTS

*-----------op_OR------------------------------------------
op_OR      
            MOVE.B  #'O',(A1)+
            MOVE.B  #'R',(A1)+
            MOVE.B  #'.',(A1)+
            JSR     get_Length
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.W  D1,D3      
            ANDI.W  #$0004,D3  
            CMPI.W  #$0004,D3  
            BEQ     Dn_EA      
            BNE     EA_Dn      
            RTS

*-----------op_RTS-----------------------------------------
op_RTS    
            MOVE.B  #'R',(A1)+
            MOVE.B  #'T',(A1)+
            MOVE.B  #'S',(A1)+      
            RTS
            
*-----------op_SUB-----------------------------------------
op_SUB     
            MOVE.B  #'S',(A1)+
            MOVE.B  #'U',(A1)+
            MOVE.B  #'B',(A1)+
            MOVE.B  #'.',(A1)+
            JSR     get_Length
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.W  D1,D3      
            ANDI.W  #$0004,D3  
            CMPI.W  #$0004,D3 
            BEQ     Dn_EA     
            BNE     EA_Dn  
            RTS
            
Dn_EA
            MOVE.W  D2,D1   
            LSL.W   #4,D1  
            LSR.W   #4,D1 
            LSR.W   #6,D1  
            LSR.W   #3,D1  
            JSR     dataregister_D
            MOVE.B  #',',(A1)+
            JSR     from_EA
            JSR     ea_main
            RTS
            
EA_Dn
            JSR     from_EA
            JSR     ea_main
            MOVE.B  #',',(A1)+
            MOVE.W  D2,D1  
            LSL.W   #4,D1  
            LSR.W   #4,D1  
            LSR.W   #6,D1  
            LSR.W   #3,D1  
            JSR     dataregister_D
            RTS

get_Length
            MOVE.W  D1,D3
            ANDI.W  #$0003,D3
            JSR     output_length
            RTS
            
output_length
            CMPI.W  #$0000,D3 
            BEQ     output_B
            CMPI.W  #$0001,D3 
            BEQ     output_W
            CMPI.W  #$0002,D3 
            BEQ     output_L
            CMPI.W  #$0003,D3 
            BEQ     size_error            
            RTS  
                   
output_B
            MOVE.B  #'B',(A1)+    
            MOVE.W  #$0000,D1     
            RTS 
            
output_W
            MOVE.B  #'W',(A1)+    
            MOVE.W  #$0001,D1     
            RTS
            
output_L
            MOVE.B  #'L',(A1)+    
            MOVE.W  #$0002,D1    
            RTS
            
*-----------GET_EA-----------------------------------------
from_EA
            MOVE.W  D2,D1
            ANDI.W  #$0007,D1
            MOVE.W  D1,D7     
            MOVE.W  D2,D1
            ANDI.W  #$0038,D1 
            LSR.W   #3,D1     
            MOVE.W  D1,D6     
            RTS      

*-----------SIZE ERROR-----------------------------------------         
size_error    
            MOVE.B  #$01,D0
            RTS        

*-----------SUBA for W or L-----------------------------------------
SUBA_WL
            CMPI.B  #$3,D1     
            BEQ     output_W    
            CMPI.B  #$7,D1      
            BEQ     output_L   
            RTS
            
dataregister_D             
            MOVE.B  #'D',(A1)+
            JSR     number_D1
            RTS
            
addressregister_A    
            MOVE.B  #'A',(A1)+
            JSR     number_D1
            RTS
            
number_D1
            MOVEM.L D1,-(SP) 
            ADDI    #$30,D1
            MOVE.B  D1,(A1)+
            MOVEM.L (SP)+,D1
            RTS  

*-----------ERROR OUTPUT------------------------------------- 
error_output   
            MOVE.B  #'D',(A1)+
            MOVE.B  #'A',(A1)+
            MOVE.B  #'T',(A1)+
            MOVE.B  #'A',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #'$',(A1)+
            MOVE.B  #'A',(A1)+
            MOVE.B  #'B',(A1)+
            MOVE.B  #'C',(A1)+
            MOVE.B  #'D',(A1)+
            RTS
            
*-----------MOVE_EA-----------------------------------------
from_MOVE_EA
            MOVE.W  D2,D1       *copy original code
            LSR.W   #6,D1       *get EA to the start
            ANDI.W  #$0007,D1   *get mode bits
            MOVE.W  D1,D6       *load them to D6 [EA MODE]
            MOVE.W  D2,D1       *copy original code
            LSR.W   #6,D1       *get EA to the start
            ANDI.W  #$0038,D1   *get mode bits
            LSR.W   #3,D1       *make them the first 3 bits in D1
            MOVE.W  D1,D7       *load them to D7 [EA REGISTER]
            RTS             

*-----------------------------------------------------------

*-----------------------------------------------------------
*           OPCODES
*-----------------------------------------------------------
           
************************************************************
*           REQUIRED OPCODES IN 0000 : NONE 
************************************************************
t_0000    
            BRA     error_output
            RTS 

************************************************************
*           REQUIRED OPCODES IN 0001 : MOVE.B   
************************************************************
t_0001
            JSR     output_Move
            MOVE.B  #'B',D7  
            MOVE.B  #$0000,D1 
            JSR     MorMA          
            RTS
            
MorMA       *is it MOVE? or MOVEA?
            MOVE.W  D2,D1
            ANDI.W  #$01C0,D1 
            LSR.W   #6,D1    
            CMPI.W  #0001,D1 
            BEQ     get_MOVEA   
            BNE     get_MOVE
            RTS        
   
get_MOVEA      
            CMPI.W  #'B',D1
            BEQ     error_output  
            MOVE.B  #'A',(A1)+  
            MOVE.B  #'.',(A1)+
            MOVE.B  D7,(A1)+    
            MOVE.B  #' ',(A1)+
            JSR     from_EA
            JSR     ea_main
            MOVE.B  #',',(A1)+
            MOVE.W  D2,D1
            LSR.W   #8,D1
            LSR.W   #1,D1
            ANDI.W  #$0007,D1 
            JSR     addressregister_A
            RTS 
            
get_MOVE      
            MOVE.B  #'.',(A1)+
            MOVE.B  D7,(A1)+
            MOVE.B  #' ',(A1)+  
            MOVE.B  #' ',(A1)+ 
            JSR     from_EA
            JSR     ea_main
            MOVE.B  #',',(A1)+
            JSR     from_MOVE_EA
            JSR     ea_main
            RTS
                  
output_Move
            MOVE.B  #'M',(A1)+
            MOVE.B  #'O',(A1)+
            MOVE.B  #'V',(A1)+
            MOVE.B  #'E',(A1)+
            RTS            
            
************************************************************
*           REQUIRED OPCODES IN 0010 : MOVE.L, MOVEA.L  
************************************************************
t_0010
            JSR     output_Move 
            MOVE.B  #'L',D7  
            MOVE.W  #$0002,D1
            JSR     MorMA    
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 0011 : MOVE.W, MOVEA.W  
************************************************************
t_0011
            JSR     output_Move 
            MOVE.W  #$0001,D1
            MOVE.B  #'W',D7  
            JSR     MorMA     
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 0100 : MOVEM, NOP, NOT, RTS, LEA, JSR  
************************************************************       
t_0100                               
            MOVE.W  D2,D1
            CMPI.W  #$4E71,D1
            BEQ     op_NOP          *NOP  
  
            MOVE.W  D2,D1           
            CMPI.W  #$4E75,D1
            BEQ     op_RTS          *RTS BITS 0100, 1110, 0111, 0101
            
            MOVE.W  D2,D1          
            LSR.W   #6,D1
            ANDI.W  #$0007,D1
            CMPI.W  #$0007,D1
            BEQ     op_LEA         *LEA BITS: 0100, 
                       
            MOVE.W  D2,D1
            ANDI.W  #$FFC0,D1
            CMPI.W  #$4E80,D1
            BEQ     op_JSR         *JSR BITS 0100, 1110, 10 , 6, BTS, EA
            
            MOVE.W  D2,D1
            ANDI.W  #%1111111100000000,D1
            CMPI.W  #$4600,D1
            BEQ     op_NOT         * NOR BITS 0100, 0100, 2 Bits size, 6 BITS EA
            
            MOVE.W  D2,D1
            ANDI.W  #$FB80,D1
            CMPI.W  #$4880,D1
            BEQ     op_MOVEM        *MOVEM BITS: 0100 
         
            BRA     error_output 
            RTS

************************************************************
*           REQUIRED OPCODES IN 0101 : ADDQ 
************************************************************
t_0101
            JSR     error_output
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 0110 : Bcc (BGT, BLE, BEQ), BRA 
************************************************************
t_0110
            BRA     error_output  
            RTS   
*            MOVE.W  D2,D1  
                 
            
************************************************************
*           REQUIRED OPCODES IN 0111 : MOVEQ    
************************************************************    
t_0111
            BRA    error_output 
            RTS           
*            MOVE.W  D2,D1
            
************************************************************
*           REQUIRED OPCODES IN 1000 : OR, DIVU  
************************************************************
t_1000    
            MOVE.W  D2,D1      
            ANDI.W  #$01C0,D1  
            LSR.W   #6,D1       
            CMPI.B  #$3,D1    
            BEQ     error_output   
            CMPI.B  #$7,D1    
            BEQ     error_output
            BRA     op_OR                   *OR 
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1001 : SUB   
************************************************************
t_1001    
            MOVE.W  D2,D1       
            ANDI.W  #$01C0,D1  
            LSR.W   #6,D1       
            CMPI.B  #$3,D1     
            BEQ     error_output   
            CMPI.B  #$7,D1      
            BEQ     error_output                      
            BRA     op_SUB                  *SUB       
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1010 : NONE 
************************************************************
t_1010
            BRA     error_output
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1011 : NONE 
************************************************************
t_1011   
            BRA     error_output
            RTS

************************************************************
*           REQUIRED OPCODES IN 1100 : AND, MULS    
************************************************************
t_1100               
            MOVE.W  D2,D1      
            ANDI.W  #$01C0,D1   
            LSR.W   #6,D1      
            CMPI.B  #$3,D1   
            BEQ     error_output   
            CMPI.B  #$7,D1    
            BEQ     op_MULS    
            BRA     op_AND              *AND     
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1101 : ADD, ADDA 
************************************************************
t_1101
            MOVE.W  D2,D1       
            ANDI.W  #$01C0,D1   
            LSR.W   #6,D1      
            CMPI.B  #$3,D1     
            BEQ     op_ADDA    
            CMPI.B  #$7,D1     
            BEQ     op_ADDA  
            BRA     op_ADD      
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1110 : ASd, LSd 
************************************************************
t_1110 
            MOVE.W  D2,D1
            ANDI.W  #$FEC0,D1   
            CMPI.W  #$E0C0,D1
            BEQ     op_ASd_EA      
            CMPI.W  #$E2C0,D1
            BEQ     op_LSd_EA   
            MOVE.W  D2,D1    
            ANDI.W  #$0018,D1
            LSR.W   #3,D1       
            CMPI.W  #$0000,D1 
            BEQ     op_ASd_D   
            CMPI.W  #$0001,D1  
            BEQ     op_LSd_D                 
            BRA     error_output
            RTS
            
op_ASd_EA
            MOVE.B  #'A',(A1)+
            MOVE.B  #'S',(A1)+
            JSR     next_ASLS_EA
            RTS
op_LSd_EA
            MOVE.B  #'L',(A1)+
            MOVE.B  #'S',(A1)+
            JSR     next_ASLS_EA
            RTS

next_ASLS_EA
            JSR     dir_output
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            JSR     from_EA
            JSR     ea_main
            RTS

op_ASd_D
            MOVE.B  #'A',(A1)+ 
            MOVE.B  #'S',(A1)+ 
            JSR     next_ASLS_D
            RTS
            
op_LSd_D
            MOVE.B  #'L',(A1)+ 
            MOVE.B  #'S',(A1)+ 
            JSR     next_ASLS_D
            RTS

next_ASLS_D
            JSR     dir_output
            MOVE.B  #'.',(A1)+
            MOVE.W  D2,D3    
            ANDI.W  #$00C0,D3   
            LSR.W   #6,D3    
            JSR     output_length 
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.B  #' ',(A1)+
            MOVE.W  D2,D1       
            ANDI.W  #$0020,D1 
            CMPI.W  #$0020,D1   
            BEQ     reg_ASLS  
            BNE     ASLSi 
            RTS
            
reg_ASLS
            MOVE.W  D2,D1   
            ANDI.W  #$0E00,D1   
            LSR.W   #8,D1
            LSR.W   #1,D1
            JSR     dataregister_D
            MOVE.B  #',',(A1)+
            MOVE.W  D2,D1
            ANDI.W  #$0007,D1 
            JSR     dataregister_D
            RTS

ASLSi
            MOVE.B  #'#',(A1)+ 
            MOVE.W  D2,D1
            ANDI.W  #$0E00,D1  
            LSR.W   #8,D1
            LSR.W   #1,D1
            CMPI.W  #$0000,D1   
            BEQ     ASLS_8    
            JSR     number_D1
            
next_ASLSi
            MOVE.B  #',',(A1)+
            MOVE.W  D2,D1
            ANDI.W  #$0007,D1       
            JSR     dataregister_D  
            RTS     

ASLS_8
            MOVE.B #'8',(A1)+
            BRA next_ASLSi
            
dir_output       
            MOVE.W  D2,D1
            ANDI.W  #$0100,D1
            LSR.W   #8,D1
            CMPI.W  #$0000,D1
            BEQ     output_R
            BNE     output_L

output_R
            MOVE.B  #'R',(A1)+
            RTS
            
************************************************************
*           REQUIRED OPCODES IN 1111 : NONE 
************************************************************
t_1111
            JSR     error_output
            RTS
            
*------------------------------------------------------------

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
