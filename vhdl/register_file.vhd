----------------------------------------------------------------------
-- File name   : register_file.vhd
--
-- Project     : RISCV RV32I CPU
--
-- Description : VHDL Register File
--
-- Author(s)   : Zachary Becker
--               bitbytebitco@gmail.com
--
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;

entity register_file is
	port(
		clock : in std_logic;
		reset : in std_logic;
		in_RegWEn : in std_logic;
		in_AddrA : in std_logic_vector(4 downto 0);
		in_AddrB : in std_logic_vector(4 downto 0);
		in_AddrD : in std_logic_vector(4 downto 0);
		in_DataD : in std_logic_vector(31 downto 0);
		out_DataA : out std_logic_vector(31 downto 0);
		out_DataB : out std_logic_vector(31 downto 0)
	);
end entity; 

architecture register_file_arch of register_file is
    signal EN : std_logic; 
    signal r_register_2_debug : std_logic_vector(31 downto 0);
    
        -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF r_register_2_debug : SIGNAL IS "true";

    type reg_bank_type is array (0 to 31) of std_logic_vector(31 downto 0);
    signal REG: reg_bank_type := (
        0 => x"00000000",
        1 => x"00000001",
        3 => x"00000FF1", -- FP-module write A
        4 => x"00000FF2", -- FP-module write B
        5 => x"00000FE1", -- FP-module read addr
        6 => x"41A40000", -- 20.5 float32
        7 => x"420F0000", -- 35.75 float32
        8 => x"C20F0000", --   -35.75 
        9 => x"41A40000", --   20.5
        10 => x"420F0000", --  35.75
        11 => x"41B40000", --  22.5
        12 => x"41460000", --  12.375
        13 => x"C0B00000",--   -5.5
        14 => x"C1460000",--   -12.375
        15 => x"40B00000",--   5.5
--        5 => x"80000000",   
--        2 => x"00000FF0",
--        5 => x"00000FF0", -- GPIO OUT
--        5 => x"00000403", -- I2C CTRL WRD
        others => x"00000000"
    );

    begin
    
    r_register_2_debug <= REG(2);
    
	 -- async read
	 out_DataA <= REG(to_integer(unsigned(in_AddrA)));
	 out_DataB <= REG(to_integer(unsigned(in_AddrB)));

	-- Enable Process
	enable : process(in_AddrD)
	  begin
	    -- 0 always driven to x"00000000" and writes ignored
	    if(to_integer(unsigned(in_AddrD)) >= 0) and (to_integer(unsigned(in_AddrD)) <= 31) then 
		  EN <= '1';
	    else 
		  EN <= '0';
	    end if;
	end process;

	-- RegisterBank Process
	RegisterBank : process(clock, EN, reset, in_RegWEn)
        begin
            if(reset = '0') then
            elsif(rising_edge(clock)) then
                if(EN = '1') then
                    if(in_RegWEn = '1') then  
                        -- synchronous write
                        REG(to_integer(unsigned(in_AddrD))) <= in_DataD;
                    else
--                        out_DataA <= REG(to_integer(unsigned(in_AddrA)));
--                        out_DataB <= REG(to_integer(unsigned(in_AddrB)));
                    end if;
                end if;
            end if;
	end process;

end architecture;