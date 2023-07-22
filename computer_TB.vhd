----------------------------------------------------------------------
-- File name   : computer_TB.vhd
--
-- Project     : 32-bit Microcomputer
--
-- Description : VHDL testbench
--
-- Author(s)   : Zachary Becker
--               bitbytebitco@gmail.com
--
-- Note	       : derived from a testbench from Brock J. LaMeres
----------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 

entity computer_TB is
end entity;

architecture computer_TB_arch of computer_TB is
        
  constant t_clk_per : time := 10 ns;  -- Period of a 100 MHz Clock

-- Component Declaration

  component computer
    port( 
        clock : in std_logic;
        reset : in std_logic
    );
  end component;

 -- Signal Declaration
    signal  clock_TB       : std_logic;
    signal  reset_TB       : std_logic;

  begin
      DUT1 : computer
         port map(
		      clock => clock_TB,
              reset => reset_TB
         );

-----------------------------------------------
      HEADER : process
        begin
            report "32-Bit Microcomputer System Test Bench Initiating..." severity NOTE;
            wait;
        end process;
-----------------------------------------------
      CLOCK_STIM : process
       begin
          clock_TB <= '1'; wait for 0.5*t_clk_per; 
          clock_TB <= '0'; wait for 0.5*t_clk_per; 
       end process;
-----------------------------------------------      
      RESET_STIM : process
       begin
          reset_TB <= '0'; wait for 0.25*t_clk_per; 
          reset_TB <= '1'; wait; 
       end process;
-----------------------------------------------     


end architecture;
