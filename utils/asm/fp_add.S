.globl _start

.text
_start : 
    addi x18,x0,0x01         # add 1 to x18 for use later

_p1:
    sb x6, 0(x3)             # set 0xFF1 (f_A) 
    sb x7, 0(x4)             # set 0xFF1 (f_B) 
    jal _poll_done
    j _start
    

_poll_done:
    lb x19, 0(x16)            # load 0xFE2 to x19
    andi x17, x19, 0x01       # set x17 to AND of x19 and 0b01 
    bltu x17, x18, _poll_done                                  
    lw x2, 0(x5)             # load 0xFE1 (f_R) to x2
    jr ra 


