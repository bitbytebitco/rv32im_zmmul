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
        
--  constant t_clk_per : time := 50 ns;  -- Period of a 20 MHz Clock
  constant t_clk_per : time := 10 ns;  -- Period of a 100 MHz Clock
--  constant t_clk_per : time := 40 ns;  -- Period of a 25 MHz Clock
  
  signal inst_i : integer := 0;
  type prog_mem is array (0 to 511) of std_logic_vector(7 downto 0);
  signal IMEM : prog_mem := (
				0 => "00010011", -- addi x2, x2, 1          0x00110113
				1 => "00000001",
				2 => "00010001",
				3 => "00000000",
				4 => "11100011", -- bltu x2, x3, -4         0xfe316ee3
				5 => "01101110",
				6 => "00110001",
				7 => "11111110",
				others => x"00");
				
--				(
--				0 => x"13", 
--				1 => x"01",
--				2 => x"11",
--				3 => x"00",
--				4 => x"e3",
--				5 => x"6e",
--				6 => x"31",
--				7 => x"fe",
--				)
  
   
  constant c_BIT_PERIOD : time := 8680 ns;
--    constant c_BIT_PERIOD : time := 4340 ns;  
--  constant c_BIT_PERIOD : time := 21702 ns;
  
  signal r_CLOCK : std_logic := '0';
  signal r_RX_SERIAL : std_logic := '1';
  

-- Component Declaration

  component computer
    port( 
        clock : in std_logic;
        reset : in std_logic;
        i_load_imem : in std_logic := '0';
        i_uart_rx_00 : in std_logic := '0'
    );
  end component;

 -- Signal Declaration
    signal  clock_TB, reset_TB  : std_logic;
    signal load_imem_TB  : std_logic := '0'; 
    
        procedure UART_WRITE_BYTE (
            i_data_in       : in  std_logic_vector(7 downto 0);
            signal o_serial : out std_logic) is
          begin
         
            -- Send Start Bit
            o_serial <= '0';
            wait for c_BIT_PERIOD;
         
            -- Send Data Byte
            for ii in 0 to 7 loop
              o_serial <= i_data_in(ii);
              wait for c_BIT_PERIOD;
            end loop;  -- ii
         
            -- Send Stop Bit
            o_serial <= '1'; wait for c_BIT_PERIOD; 
        end UART_WRITE_BYTE; 
    

  begin
  
      r_CLOCK <= not r_CLOCK after t_clk_per;    
          
  
      DUT1 : computer
         port map(
		      clock => clock_TB,
              reset => reset_TB,
              i_load_imem => load_imem_TB,
              i_uart_rx_00 => r_RX_SERIAL
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
      UART_PROC : process
        begin
            -- Send a command to the UART
            wait until rising_edge(r_CLOCK);
--            UART_WRITE_BYTE(X"3F", r_RX_SERIAL);

            if(inst_i <= 7 ) then
                UART_WRITE_BYTE(IMEM(inst_i), r_RX_SERIAL);
                
                inst_i <= inst_i + 1;
                wait for 102500*t_clk_per; 
                
                --inst_i <= 0;
            end if;
            wait until rising_edge(r_CLOCK);
                    
      end process;
      
      IMEM_PROC : process
        begin
            wait for 800 us;
            load_imem_TB <= '0';
      end process;



end architecture;
