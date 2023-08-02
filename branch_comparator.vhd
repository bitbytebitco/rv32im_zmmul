library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

entity branch_comparator is
    port(
        i_A, i_B : in std_logic_vector(31 downto 0); 
        i_BrU  : in std_logic;
        o_BrEq, o_BrLT : out std_logic);
end entity;

architecture branch_comparator_rtl of branch_comparator is
    begin
      
    
    process(i_A, i_B, i_BrU)
	   begin
	       if(i_A = i_B) then 
	           o_BrEq <= '1';
	           o_BrLT <= '0'; 
	       else
	           o_BrEq <= '0';
               if(i_BrU = '1') then
                   if(unsigned(i_A) < unsigned(i_B)) then
                       o_BrLT <= '1';
                   else
                       o_BrLT <= '0';           
                   end if;
               else 
                   if(signed(i_A) < signed(i_B)) then
                       o_BrLT <= '1';
                   else 
                       o_BrLT <= '0';
                   end if;
               end if;
           end if;
	end process;
        
end architecture;