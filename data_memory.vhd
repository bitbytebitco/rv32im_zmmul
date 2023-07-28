library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity data_memory is
	port(
		clock : in std_logic;
		in_Addr : in std_logic_vector(31 downto 0);
		in_MemRW : in std_logic;
		in_DataW : in std_logic_vector(31 downto 0);
		i_ByteSel : in std_logic_vector(2 downto 0);
		out_DataR : out std_logic_vector(31 downto 0)
	);
end entity;

architecture data_memory_arch of data_memory is
    signal EN : std_logic; 

    type rw_type is array (512 to 2047) of std_logic_vector(7 downto 0);
    signal RW0, RW1, RW2, RW3: rw_type;	
    
    signal clock_n : std_logic;
    signal r_DataR : std_logic_vector(31 downto 0) := x"00000000";
    
    signal v_byte_00, v_byte_01, v_byte_02, v_byte_03 : std_logic_vector(7 downto 0);

    begin
    
        clock_n <= not clock;
        
        out_DataR(31 downto 0) <= r_DataR when EN = '1' and in_MemRW = '0' else x"00000000";
        


        -- Enable Process
        enable : process(in_Addr)
          begin
            if(to_integer(unsigned(in_Addr)) >= 512) and (to_integer(unsigned(in_Addr)) <= 2047) then
              EN <= '1';
            else 
              EN <= '0';
            end if;
        end process;
        
        
        -- Memory Process
        memory : process(clock, EN, in_MemRW, in_Addr, i_ByteSel, v_byte_00, v_byte_01, v_byte_02, v_byte_03)
            variable r : integer; 
            variable n : integer := 8;
--            variable v_byte_00, v_byte_01, v_byte_02, v_byte_03 : std_logic_vector(7 downto 0);
  
            begin
            
                if(EN = '1') then 
                    if(to_integer(unsigned(in_Addr)) >= 512) and (to_integer(unsigned(in_Addr)) <= 2047) then
                    
                            v_byte_00 <= RW0(to_integer(unsigned(in_Addr) ));
                            v_byte_01 <= RW1(to_integer(unsigned(in_Addr) ));
                            v_byte_02 <= RW2(to_integer(unsigned(in_Addr) ));
                            v_byte_03 <= RW3(to_integer(unsigned(in_Addr) ));  
                                               
                    
                        if(in_MemRW = '1') then 
                        
                            -- WRITE
                            
                            -- Sync Write
                            if(rising_edge(clock)) then 
                            
                                -- TODO : current 3 bytes are being skipped every time due to the 
                                -- split up of bytes between BRAMs, need to adjust for this in indexing
                                
                                case i_ByteSel is
                                   when "000" => -- SB
                                        RW0(to_integer(unsigned(in_Addr) )) <= in_DataW(7 downto 0);
                                   when "001" => -- SH
                                        RW1(to_integer(unsigned(in_Addr) )) <= in_DataW(15 downto 8);
                                        RW0(to_integer(unsigned(in_Addr) )) <= in_DataW(7 downto 0);
                                   when others => -- SW
                                        RW3(to_integer(unsigned(in_Addr) )) <= in_DataW(31 downto 24);
                                        RW2(to_integer(unsigned(in_Addr) )) <= in_DataW(23 downto 16);
                                        RW1(to_integer(unsigned(in_Addr) )) <= in_DataW(15 downto 8);
                                        RW0(to_integer(unsigned(in_Addr) )) <= in_DataW(7 downto 0);
                                end case;
                                   
                            end if;
                            
                        else
                            -- READ
                    
--                            if(rising_edge(clock)) then     
                             
                                case i_ByteSel is
                                   when "000" => -- LB
                                        if(v_byte_00(7) = '0') then
                                            r_DataR(31 downto 0) <= x"000000" & v_byte_00;
                                        elsif(v_byte_00(7) = '1') then
                                            r_DataR(31 downto 0) <= x"111111" & v_byte_00;
                                        end if;
                                        
                                   when "001" => -- LH
                                        if(v_byte_01(7) = '0') then
                                            r_DataR(31 downto 0) <= x"0000" & v_byte_01 & v_byte_00;
                                        else
                                            r_DataR(31 downto 0) <= x"1111" & v_byte_01 & v_byte_00;
                                        end if;
                                        
                                   when "011" => -- LB
                                        r_DataR(31 downto 0) <= x"000000" & v_byte_00;
                                   when "100" => -- LB
                                        r_DataR(31 downto 0) <= x"0000" & v_byte_01 & v_byte_00;
                                   when others => -- LW
                                        r_DataR(31 downto 0) <= v_byte_03 & v_byte_02 & v_byte_01 & v_byte_00;
                                end case;
                                
--                            end if;
                        
                        end if;
                        
                    end if;
                end if;        
                      
        end process;

end architecture;
