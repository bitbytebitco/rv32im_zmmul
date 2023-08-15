OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")

OUTPUT_ARCH(riscv)

ENTRY(_start)

MEMORY
{
  INST (rx) : ORIGIN = 0x0, LENGTH = 0x400
  DATA (rw) : ORIGIN = 0x400, LENGTH = 0x400 
}

SECTIONS
{

    . = 0x00000000;
    .text :
    {
        *(.init);
        *(.text);
    } > INST


    .data :
    {
        *(.data)
        *(.sdata)
    } > DATA


    .bss :
    {
        __start_bss = .;
        *(.bss)
        __end_bss = .;
    } > DATA    

    PROVIDE( __global_pointer$ = ORIGIN(DATA) + (LENGTH(DATA) / 2) ); 
    PROVIDE( __stack_pointer = ORIGIN(DATA) + LENGTH(DATA) );
 
}

