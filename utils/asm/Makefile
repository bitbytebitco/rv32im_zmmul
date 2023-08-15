.PHONY: get_hex 
hex_asm: 
	echo $(BASENAME).S
	riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 $(BASENAME).S -o $(BASENAME).o  # assemble
	riscv32-unknown-elf-ld -o $(BASENAME).elf -T asm.ld  -nostdlib $(BASENAME).o	# link 
	riscv32-unknown-elf-objdump -dtrwC -S $(BASENAME).elf > $(BASENAME).dump		# obtain hex
	cat $(BASENAME).dump	

hex_c:
    riscv32-unknown-elf-gcc -g -ffreestanding -O0 -Wl,--gc-sections -fno-toplevel-reorder -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,c_linker.ld crt0.S main.c -o main.elf
    riscv32-unknown-elf-objdump -drwC -S main.elf > main.dump
    cp main.dump ~/Documents/bitstream_prep/asm/
	
clean:
	rm *.o
	rm *.dump
	rm *.elf
	


