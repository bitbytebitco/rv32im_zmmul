OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
ENTRY(_start)

MEMORY
{
  INST (rx) : ORIGIN = 0x0, LENGTH = 0x200
  DATA (rw) : ORIGIN = 0x200, LENGTH = 0x400
}

SECTIONS
{
  .data :
  {
    *(.data)
  }> DATA

  .text :
  {
    *(.text)
  }> INST
}

