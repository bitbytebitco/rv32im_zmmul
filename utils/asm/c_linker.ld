OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")

OUTPUT_ARCH(riscv)

ENTRY(_start)

MEMORY
{
  INST (rx) : ORIGIN = 0x0, LENGTH = 0x200
  DATA (rw) : ORIGIN = 0x200, LENGTH = 2K 
}

SECTIONS
{

    .text :
    {
        *(.text)
        *(.rodata)
    } > INST

    .data :
    {
        __DATA_BEGIN =.;
        *(.data)
        *(.sdata)
    } > DATA


    .bss :
    {
        __start_bss = .;
        *(.bss)
        __end_bss = .;
    } > DMEM    

    PROVIDE( __global_pointer = ORIGIN(DATA) + (LENGTH(DATA) / 2) ); 
    PROVIDE( __stack_pointer = ORIGIN(DATA) + LENGTH(DATA) );
 
}

