# rv32im_zmmul
RISC-V ```rv32im_zmmul``` VHDL implementation

# Status Updates  
<details>
  <summary>07/28/23 - Added I2C </summary>
  
  + I2C (Master Write) module added, which simulates and synthesizes.
  + Capable of sending single & multiple bytes at 100 kHz. 
</details>
<details>
  <summary>07/21/23 - Initial Report (Blinky) </summary>
  
  + Basic blinking led program properly synthesized and implemented on Basys 3
    + Using 50 MHz CPU clock  
  + ```zmmul``` instructions not yet implemented 
  + Remaining instructions of rv32i todo
    + https://docs.google.com/document/d/11gn7-yY5YjZeH5jf3WMUH8FKyT9lCqL0K3gcKlKGxgU/edit?usp=sharing
</details>

# Testing
## Hello, World! (Blinking LED)
<details>
  <summary>Simulation Waveform</summary>
  
  ![Simulation Waveform](https://github.com/bitbytebitco/rv32im_zmmul/blob/master/rv32im_zmmul_blinking_led.png?raw=true)
</details>
<details>
  <summary>Assembly Program (RISCV) </summary>
  
  ```
  addi x4, x0, 1
  addi x2, x2, 1
  bltu x2, x4, -4
  xori x8, x8, 0xFFFFFFFF
  sw x8, 0(x5)                         -- x5 holds address of GPIO
  addi x2, x2, -1
  bltu x2, x4, -24  
  ```
</details>
<details>
  <summary>Synthesis Waveform</summary>
  
  #### Synthesized Oscilloscope Output (50 MHz CPU Clock)
  ![Simulation Waveform](https://github.com/bitbytebitco/rv32im_zmmul/blob/master/rv32im_zmmul_blinking_led_oscope.png?raw=true)
</details>

## I2C Implementation
<details>
  <summary>RISCV Assembly</summary>
  
  #### RISCV Assembly
  ```
  addi x12, x0, 0x0A                                 set x12 to 0x0A (first byte to be sent)
  sb x12, 0x0400(x0)                                 set I2C current byte (r_i2c_current_data)
  addi x11, x0, 0x0B                                 set x11 to 0x0B (second byte to be sent)
  addi x2, x0, 0x02                                  (set x2 to 0x02 for byte count)
  sb x2, 0x0401(x0)                                  set I2C byte count (r_i2c_byte_cnt)
  addi x9, x0, 0x03                                  (set x9 for i2c_ctrl_wrd values 'active'=1  and 'i_buffer_clear'=1)
  addi x1, x0, 0x01                                  (set x1 to 1 for use in activating i2c and checking states)
  addi x4, x0, 0x70                                  (set x4 to i2c_addr value)
  sb x4, 0x0404(x0)                                  Set i2c_addr (x404) to device address 0x70
  sb x1, 0x0403(x0)                                  Set i2c_ctrl_wrd (x403) to value at x1 (x"00000001") to ENABLE I2C
  lw x6, 0x0402(x0)                                  load i2c_stat to x6
  beq x6, x1, 40                                     if o_done == 1 then jump forward 10 instructions
  andi x3,x6,0x04                                    set x3 to AND of x6 and BIT2 (testing o_busy)
  srl x3,x3,x2                                       shift right by two
  bltu x3, x1, -16                                   if o_busy < 1 then jump back 4 instructions
  andi x7,x6,0x02                                    set x7 to logical AND of x6 and BIT1 (testing o_buffer_clear)
  srl x7,x7,x1                                       shift right by one
  bltu x7, x1, -28                                   if o_buffer_clear < 1 jump back 6 instructions
  sb x11, 0x0400(x0)                                 set data memory address 0x400 to update (next byte to be sent)
  sb x9, 0x0403(x0)                                  Set i2c_ctrl_wrd (x403) to value at x9  ('active'=1  and 'i_buffer_clear'=1)
  bltu x0, x1, -40                                   jump back 10 instructions
  addi x5, x0, 0x05                                  set x5 to 0x05 (for the next instruction)
  sb x5, 0x0403(x0)                                  Set i2c_ctrl_wrd (x403) to 0b00000101 (`i_done_clear` = 1 and `active` = 1)
  bltu x0, x1, -84                                   jump back to start ( back 21 instructions)    
  ```
</details>

<details>
  <summary>Waveform Screenshot</summary>
  
  #### Synthesized Oscilloscope Output (50 MHz CPU Clock)
![Synthesis Waveform](https://github.com/bitbytebitco/rv32im_zmmul/blob/master/I2C_send_multi_byte_oscope.png?raw=true)
</details>
