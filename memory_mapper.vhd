library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;
 
entity memory_mapper is
    port(
        clock : in std_logic;
        reset : in std_logic;
        i_write : in std_logic;
        i_address : in std_logic_vector(31 downto 0);
        i_data : in std_logic_vector(31 downto 0);
        i_byte_sel : in std_logic_vector(2 downto 0);
        o_data : out std_logic_vector(31 downto 0);
        port_in_00  : in std_logic_vector(7 downto 0);
        port_out_00  : out std_logic_vector(15 downto 0)
    );
end entity;

architecture memory_mapper_rtl of memory_mapper is

    
    
    signal w_o_data : std_logic_vector(31 downto 0);
    signal r_port_out_00 : std_logic_vector(15 downto 0);
    
    -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF r_port_out_00 : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF i_data : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF i_address : SIGNAL IS "true";
 
    -- DMEM
    component data_memory 
        port(
            clock : in std_logic;
            in_Addr : in std_logic_vector(31 downto 0);
            in_MemRW : in std_logic;
            in_DataW : in std_logic_vector(31 downto 0);
            i_ByteSel : in std_logic_vector(2 downto 0);
            out_DataR : out std_logic_vector(31 downto 0)
        );
    end component;
 
 
 begin
 
    port_out_00 <= r_port_out_00;
 
    -- DMEM init
    DMEM : data_memory 
        port map(
            clock => clock,
            in_Addr => i_address,
            in_MemRW => i_write, 
            in_DataW => i_data,
            i_ByteSel => i_byte_sel,
            out_DataR => w_o_data
        );
        
    -- port_out_00 : ADDRESS x"00000FF0"
    P0 : process(clock, reset, i_address, i_write, i_data)
      begin
        if(reset = '0') then
            r_port_out_00 <= x"0000";
        elsif(rising_edge(clock)) then 
            if(i_address = x"00000FF0" and i_write = '1') then
                r_port_out_00 <= i_data(15 downto 0);
            end if;
        end if;
    end process;
    
    -- n
        
    -- Memory Multiplexer Init
    MEM_MUX: process(i_address, w_o_data, port_in_00)
	   begin
	    -- Program Memory (address range 0 to 127)
--	    if(to_integer(unsigned(address)) >= 0 and 
--		to_integer(unsigned(address)) <= 127) then 
--		data_out <= rom_data_out;
	    
	    -- Data Memory 
	    if(to_integer(unsigned(i_address)) >= 1023 and to_integer(unsigned(i_address)) <= 2047) then 
	    	o_data <= w_o_data;

	    -- input ports
	    elsif(i_address = x"00000FE0") then 
	       o_data <= x"000000" & port_in_00;
--	    elsif(i_address = x"000000F1") then 
--	       o_data <= port_in_01;
--	    elsif(i_address = x"000000F2") then 
--	       o_data <= port_in_02;
--	    elsif(i_address = x"000000F3") then 
--	       o_data <= port_in_03;
--	    elsif(i_address = x"000000F4") then 
--	       o_data <= port_in_04;
	    else 
	       o_data <= x"00000000";
	    end if;
    end process;    
        
end architecture;       
