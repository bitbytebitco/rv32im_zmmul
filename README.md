# rv32im_zmmul
RISC-V ```rv32im_zmmul``` VHDL implementation

**[ WORK IN PROGRESS ]**

#### Status (07/21/23) 
+ Basic blinking led program properly synthesized and implemented on Basys 3
  + Using 50 MHz CPU clock  
+ ```zmmul``` instructions not yet implemented 
+ Remaining instructions of rv32i todo
  + https://docs.google.com/document/d/11gn7-yY5YjZeH5jf3WMUH8FKyT9lCqL0K3gcKlKGxgU/edit?usp=sharing
 
# Hello, World! (Blinking LED)
#### Simulation Waveform
![Simulation Waveform](https://github.com/bitbytebitco/rv32im_zmmul/blob/master/rv32im_zmmul_blinking_led.png?raw=true)

#### Assembly Program (RISCV) 
```
addi x4, x0, 1
addi x2, x2, 1
bltu x2, x4, -4
xori x8, x8, 0xFFFFFFFF
sw x8, 0(x5)                         -- x5 holds address of GPIO
addi x2, x2, -1
bltu x2, x4, -24  
```
#### Synthesized Oscilloscope Output (50 MHz CPU Clock)
![Simulation Waveform](https://github.com/bitbytebitco/rv32im_zmmul/blob/master/rv32im_zmmul_blinking_led_oscope.png?raw=true)
