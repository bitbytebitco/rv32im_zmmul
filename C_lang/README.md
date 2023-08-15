
### Bash commands to compile,link, and disassemble hex instructions 
```
    riscv32-unknown-elf-gcc -g -ffreestanding -O0 -Wl,--gc-sections -fno-toplevel-reorder -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,c_linker.ld crt0.S main.c -o main.elf
    riscv32-unknown-elf-objdump -drwC -S main.elf > main.dump
```
