.PHONY: get_hex 
hex: 
	echo $(BASENAME).S
	riscv32-unknown-elf-as -march=rv32i $(BASENAME).S -o $(BASENAME).o
	riscv32-unknown-elf-objdump -drwC -S $(BASENAME).o > $(BASENAME).dump
	cat $(BASENAME).dump	
	
clean:
	rm $(BASENAME).o
	rm $(BASENAME).dump


