library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity instruction_memory is
	port(
	    clock : in std_logic;
	    in_reset_imem : in std_logic;
		in_addr: in std_logic_vector(31 downto 0);
		in_data : in std_logic_vector(31 downto 0);
		in_rw : in std_logic;
		out_inst : out std_logic_vector(31 downto 0)
	);
end entity;

architecture instruction_memory_arch of instruction_memory is 
  
    signal EN : std_logic;
    type prog_mem is array (0 to 511) of std_logic_vector(7 downto 0);
    
    -- Instruction Memory
 	 signal PROG : prog_mem := (
				0 => "00010011", -- addi x2, x2, 1
				1 => "00000001",
				2 => "00010001",
				3 => "00000000",
				4 => "01101111", -- bgeu x2, x3, 8            
				5 => "11110000",
				6 => "11011111",
				7 => "11111111",

				others => x"00");    
    

    begin
        -- Enable Process
        enable : process(in_addr)
          begin
            if(to_integer(unsigned(in_addr)) >= 0) and (to_integer(unsigned(in_addr)) <= 511) then
                EN <= '1';
            else 
                EN <= '0';
            end if;
        end process;
    
        -- Memory Process
        memory : process(in_reset_imem, EN, in_rw, clock, in_addr, in_data, PROG)
          begin
            if(in_reset_imem = '0') then -- driven by active low reset
            
                --PROG <= (0 => x"00", others => x"00");  
                
            else
            
                if(EN = '1') then
                    if(in_rw = '1') then
                        if(rising_edge(clock)) then 
                            PROG(to_integer(unsigned(in_addr)) -1) <= in_data(31 downto 24);
                            PROG(to_integer(unsigned(in_addr)) -2) <= in_data(23 downto 16);
                            PROG(to_integer(unsigned(in_addr)) -3) <= in_data(15 downto 8);
                            PROG(to_integer(unsigned(in_addr)) -4) <= in_data(7 downto 0);
                        end if;
                    else
                        out_inst <= PROG(to_integer(unsigned(in_addr))+3) & PROG(to_integer(unsigned(in_addr))+2) & PROG(to_integer(unsigned(in_addr))+1) & PROG(to_integer(unsigned(in_addr)));
                    end if;
                end if;
                
            end if;
        end process;

end architecture;