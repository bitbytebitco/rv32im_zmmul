riscv32-unknown-elf-gcc -g -ffreestanding -O0 -Wl,--gc-sections -nostartfiles -fno-toplevel-reorder -nostdlib -nodefaultlibs -Wl,-T,c_linker.ld crt0.S main.c -o main.elf
riscv32-unknown-elf-objdump -drwC -S main.elf > main.dump
cp main.dump ~/Documents/bitstream_prep/asm/
