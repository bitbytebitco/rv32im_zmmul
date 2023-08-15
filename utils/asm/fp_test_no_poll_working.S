
.equ F_A, 0xFF1
.equ F_B, 0xFF2
.equ F_RESULT, 0xFE1
.equ F_STAT, 0xFE2
.equ F_CTL, 0xFF3
.equ EN, 0x01
.equ DONE_CLEAR, 0x03
.equ A1, 0x41A40000             # 20.5 float32
.equ B1, 0x420F0000             # 35.75 float32 

.equ A2, 0xC20F0000             # -35.75 
.equ B2, 0x41A40000             # 20.5

.equ A3, 0x420F0000             # 35.75
.equ B3, 0x41B40000             # 22.5

.equ A4, 0x41460000             # 12.375 
.equ B4, 0xC0B00000             # -5.5

.equ A5, 0xC1460000             # -12.375
.equ B5, 0x40B00000             # 5.5

.globl _start

.text
_start : 
    li x22, F_A
    li x23, F_B
    li x5, F_RESULT
    li x16, F_STAT
    li x21, F_CTL

    li x24, EN                  # set x24 to 0b01 
    li x20, DONE_CLEAR          # set x20 to 0b11

    sw x20, 0(x21)               # set F_A 
    j _p1

_p1:
    li x6, A1
    li x7, B1
    sw x6, 0(x22)               # set F_A 
    sw x7, 0(x23)               # set F_B 
    lw x18, 0(x5)                # load 0xFE1 (f_R) to x2
    j _p2
        
 _p2:
    li x6, A2
    li x7, B2
    sw x6, 0(x22)               # set F_A 
    sw x7, 0(x23)               # set F_B 
    lw x18, 0(x5)                # load 0xFE1 (f_R) to x2
    j _p3 
    
_p3:
    li x6, A3
    li x7, B3
    sw x6, 0(x22)               # set F_A 
    sw x7, 0(x23)               # set F_B 
    lw x18, 0(x5)                # load 0xFE1 (f_R) to x2
    j _p4

_p4:
    li x6, A4
    li x7, B4
    sw x6, 0(x22)               # set F_A 
    sw x7, 0(x23)               # set F_B 
    lw x18, 0(x5)                # load 0xFE1 (f_R) to x2
    j _p5

_p5:
    li x6, A5
    li x7, B5
    sw x6, 0(x22)               # set F_A 
    sw x7, 0(x23)               # set F_B 
    lw x18, 0(x5)                # load 0xFE1 (f_R) to x2
    j _start




 

