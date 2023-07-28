----------------------------------------------------------------------
-- File name   : i2c_module_write.vhd
--
-- Project     : I2C Master (Write)
--
-- Description : I2C Master (Write) 
--
-- Author(s)   : Zachary Becker
--               bitbytebitco@gmail.com
--
-- Note	       : 
----------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package misc_pkg is
    type DataArray is array (natural range <>) of std_logic_vector(7 downto 0);
end package;
use work.misc_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--        i_addr : in std_logic_vector(6 downto 0);

entity i2c_module_write is
    generic(
        g_CLK_RATE : integer := 50_000_000
    );
    port(
        i_reset_n : in std_logic;				-- Active low reset
        i_CLK : in std_logic;				
        i_en : in std_logic;
        i_addr : in std_logic_vector(6 downto 0);
        i_tx_byte : in std_logic_vector(7 downto 0);
        i_byte_cnt : in std_logic_vector(7 downto 0);
        i_SDA : in std_logic;
        i_done_clear : in std_logic;
        i_buffer_clear : in std_logic; 
        o_buffer_clear : out std_logic := '0'; 
        o_busy : out std_logic := '0';
        o_done : out std_logic := '0';
        o_SCL : out std_logic;
        o_SDA : out std_logic	
    );
end entity;


architecture i2c_module_write_arch of i2c_module_write is

    constant clock_divider_int : integer := integer(real(g_CLK_RATE) / real(100000))/4;    -- Count needed to produce 100kHz I2C Clock 
    
	-- Initializations
	type state_type is (IDLE, START, START2, START3,
	                    ADDR, ADDR2, ADDR3, ADDR4, ADDR5, ADDR6, ADDR7,
	                    RW, ACK1, 
	                    DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7, DATA8,
	                    ACKN, STOP, STOP2, STOP3, WAIT_CLEAR, WAIT_BUF_CLEAR);
	                    
	signal current_state : state_type := IDLE;
	signal next_state : state_type := START;
	signal halfcount_int : integer range 0 to 100000 := 0;
	signal delay_count : integer range 0 to 20 := 0;
	signal cnt : integer range 0 to 20 := 0;
	signal cycle_cnt : integer range 0 to 3 := 0;

	signal s_BYTECNT_int : integer range 0 to 10000 := 2; 
	
	signal s_SDA_int : std_logic := '1'; 
	signal s_SDA_EN : std_logic;
	signal s_SCL_EN : std_logic;
	signal s_SCL_int : std_logic := '1';
	
	signal s_HALFSCL_int : std_logic := '0';
	
	-- TODO: RW_int values should come from port input
	signal RW_int : std_logic := '0'; -- READ : 1 , WRITE : 0
--	signal i_addr : std_logic_vector(6 downto 0) := "1110000"; -- hard coded address 
    signal addr_buf : unsigned(6 downto 0);
	signal data_buf : unsigned(7 downto 0);
	signal current_byte : std_logic_vector(7 downto 0);
	signal byte_cnt : integer range 0 to 100;
	signal total_bytes : integer range 0 to 100;
	
	
	--- TEMP 
	signal state : std_logic := '1';
    signal cnt2 : integer range 0 to 200000 := 0;
	--- END TEMP

    begin
    
        total_bytes <= to_integer(unsigned(i_byte_cnt));
          
	
	PROC2 : process(i_CLK, i_reset_n)
      begin
        if(rising_edge(i_CLK)) then
            cnt2 <= cnt2 + 1;
            if(cnt2 >= (clock_divider_int-1) ) then
                cnt2 <= 0;
               
                s_HALFSCL_int <= not s_HALFSCL_int;
            end if;
        end if;
    end process;
	
	------------------------------------------------------
	process(s_HALFSCL_int, i_reset_n)
	    begin
	        if(i_reset_n = '0') then
	           cycle_cnt <= 0;
            elsif(rising_edge(s_HALFSCL_int)) then
                if(cycle_cnt = 1) then
                    cycle_cnt <= 0;
                else 
                    cycle_cnt <= cycle_cnt + 1;
                end if;
            end if;     
	end process;
	
    -----------------------------------------------------
    STATE_MEM : process(s_HALFSCL_int, i_reset_n, cycle_cnt) 
        begin
            if(i_reset_n = '0') then 
                current_state <= IDLE;
                delay_count <= 0;
            elsif(rising_edge(s_HALFSCL_int) and (cycle_cnt = 0)) then
                if((current_state = IDLE) and (delay_count < 20)) then
                    delay_count <= delay_count + 1;
                else 
                    current_state <= next_state;
                    delay_count <= 0;
                end if;
            end if;
    end process;

    -----------------------------------------------------    
    NEXT_STATE_LOGIC: process(s_HALFSCL_int, i_reset_n, cycle_cnt, current_state)
        begin
            if(i_reset_n = '0') then
                --
            elsif(rising_edge(s_HALFSCL_int) and (cycle_cnt = 1)) then
                case(current_state) is 
                    when IDLE => 
                        if ((i_en = '1')) then 
                            next_state <= START;
                        else 
                            next_state <= IDLE;
                        end if;
                        
--                        next_state <= START;
                        
                    when START => 
                        next_state <= START2;
                        o_done <= '0';
                    when START2 => next_state <= START3;
                    when START3 => next_state <= ADDR;
                    when ADDR => next_state <= ADDR2;
                    when ADDR2 => next_state <= ADDR3;
                    when ADDR3 => next_state <= ADDR4;
                    when ADDR4 => next_state <= ADDR5;
                    when ADDR5 => next_state <= ADDR6;
                    when ADDR6 => next_state <= ADDR7;
                    when ADDR7 => next_state <= RW;
                    when RW => next_state <= ACK1;
                    when ACK1 =>
                        if(total_bytes>0) then
                            byte_cnt <= byte_cnt + 1;
                            next_state <= DATA1;
                        else 
                            next_state <= STOP;
                        end if;
                    when DATA1 => next_state <= DATA2;
                    when DATA2 => next_state <= DATA3;
                    when DATA3 => next_state <= DATA4;
                    when DATA4 => next_state <= DATA5;
                    when DATA5 => next_state <= DATA6;
                    when DATA6 => next_state <= DATA7;
                    when DATA7 => next_state <= DATA8;
                    when DATA8 => next_state <= ACKN;
                    When ACKN => 
                        if(i_buffer_clear = '1') then
                            if (byte_cnt < total_bytes) then  -- how multiple bytes are currently handled
                                byte_cnt <= byte_cnt + 1;
                                next_state <= DATA1;
    --                            next_state <= WAIT_BUF_CLEAR;
                            else 
                                byte_cnt <= 0;
                                next_state <= STOP;
                            end if;
                        end if;
                    when WAIT_BUF_CLEAR => 
                        if(i_buffer_clear = '1') then 
                            byte_cnt <= byte_cnt + 1;
                            next_state <= DATA1;
                        end if;
                    when STOP => next_state <= STOP2;
                    when STOP2 => next_state <= STOP3;
                    when STOP3 => 
                        next_state <= WAIT_CLEAR;
                        o_done <= '1';
                    when WAIT_CLEAR => 
                        if(i_done_clear = '1') then 
                            o_done <= '0';
                            next_state <= IDLE;
                        end if;
                    when others => 
                        next_state <= IDLE;
                        --next_state <= STOP;
                end case;
            end if;
    end process;
        
    ----------------------------------------------------- 
    OUTPUT_LOGIC_SDA : process(s_HALFSCL_int, cycle_cnt, current_state, next_state)
        begin
--            if(rising_edge(i_buffer_clear)) then
--                o_buffer_clear <= '0';
--            end if;
        
            if(rising_edge(s_HALFSCL_int)) then -- SCL output
                case(current_state) is 
                    when IDLE => 
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_EN <= '1';    -- enable SCL output
                            s_SDA_EN <= '1';    -- enable SDA output 
                            s_SDA_int <= '1';   -- set SDA
                            s_SCL_int <= '1';
                        end if;
                    when START =>
                        o_buffer_clear <= '0';  -- set `active`
                        o_busy <= '1';
                        
                        
                        if(cycle_cnt = 0) then -- SCL output
                            --s_SDA_int <= '0';   -- RESET SDA
                        end if;
                        current_byte <= i_tx_byte;
                    when START2 => 
                        if(cycle_cnt = 0) then -- SCL output
                            --s_SCL_int <= '0';
                            s_SDA_int <= '0';
                        end if;
                        if(cycle_cnt = 1) then
                            ----s_SDA_int <= '0';
                        end if;
                    when START3 => 
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= not s_SCL_int; 
                              
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            s_SCL_int <= '0';
                            
                            s_SDA_int <= i_addr(6);  
                            addr_buf <= shift_left(unsigned(i_addr), 1); 
                        end if;
                    when ACK1 => 
                        o_buffer_clear <= '1';     -- set `done`
                        if(i_buffer_clear = '1') then
                            o_buffer_clear <= '0';     -- set `done`
                        end if;
                        
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= not s_SCL_int;
                            s_SDA_EN <= '1';
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            s_SCL_int <= not s_SCL_int;
                            s_SDA_EN <= '1';
                            s_SCL_int <= not s_SCL_int;
                            
--                            if(total_bytes=0) then
--                                o_buffer_clear <= '1';     -- set `done`
--                            else 
--                                o_buffer_clear <= '1';     -- set `done`
--                            end if;
                            
--                            current_byte <= i_tx_byte;
--                            s_SDA_int <= current_byte(7);
--                            data_buf <= shift_left(unsigned(current_byte), 1);
                            
                        end if;
                        
                        current_byte <= i_tx_byte;
                        s_SDA_int <= current_byte(7);
                        data_buf <= shift_left(unsigned(current_byte), 1);
                        
                    when ACKN =>
                        if(i_buffer_clear = '1') then
                            o_buffer_clear <= '0';     -- set `done`
                        end if;
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= not s_SCL_int;
                            s_SDA_EN <= '1';
--                            o_buffer_clear <= '1';     -- set `done`
                            
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            s_SCL_int <= not s_SCL_int;
                            s_SDA_EN <= '1';
                            
                            if (byte_cnt < total_bytes) then
                                --o_buffer_clear <= '0';     -- reset OLD
                                
                                current_byte <= i_tx_byte;
                                s_SDA_int <= current_byte(7);
                                data_buf <= shift_left(unsigned(current_byte), 1);
                            end if;
                        end if;

                    when ADDR | ADDR2 | ADDR3 | ADDR4 | ADDR5 | ADDR6 | ADDR7 | RW => 
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= not s_SCL_int;   
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            s_SCL_int <= not s_SCL_int;
                            
                            if(current_state = RW) then
--                                s_SDA_int <= 'Z';
                                s_SDA_EN <= '0';
                            else 
                                s_SDA_int <= addr_buf(6);
                                addr_buf <= shift_left(addr_buf, 1);
                            end if;
                        end if;
                    when DATA1 | DATA2 | DATA3 | DATA4 | DATA5 | DATA6 | DATA7 | DATA8 =>
                        if(current_state = DATA1) then
                            --o_buffer_clear <= '0';     -- reset OLD
                        end if;
                        
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= not s_SCL_int;
--                            s_SDA_EN <= '1';
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            s_SCL_int <= not s_SCL_int;
                            
                            if(current_state = DATA8) then
--                                s_SDA_int <= 'Z';
                                s_SDA_EN <= '0';
                                
                                if (byte_cnt < total_bytes)  then
                                    current_byte <= i_tx_byte;
                                end if;
                                o_buffer_clear <= '1';     -- set `done`
                                
                            else 
                                s_SDA_int <= data_buf(7);
                                data_buf <= shift_left(data_buf, 1);
                            end if;
                            
                            
                        end if;
                    when STOP => 
                        if(cycle_cnt = 0) then -- SCL output
                            --s_SCL_int <= not s_SCL_int;
                            s_SDA_EN <= '1';
                            o_buffer_clear <= '0';     -- reset
                            
                        end if;
                        if(cycle_cnt = 1) then -- SDA output
                            --s_SCL_int <= not s_SCL_int;
                            s_SDA_int <= '1';
                        end if;
                    when STOP2 => 
                        if(cycle_cnt = 0) then -- SCL output
                            s_SCL_int <= '1'; -- RESET SCL
                            s_SDA_int <= '1';
                        end if;
                    when STOP3 => 
                        if(cycle_cnt = 0) then -- SCL output
                            s_SDA_int <= '1';
                        end if;
                        
                        o_busy <= '0';
                    when others =>
                        if(cycle_cnt = 0) then -- SCL output
                            s_SDA_EN <= '1';    -- enable SDA output 
                        end if;
                end case;
            end if;
            
    end process;
    
    -- Tri-State buffer control
--    io_SCL   <= s_SCL_int when s_SCL_EN = '1' else 'Z';
--    io_SDA   <= s_SDA_int when s_SDA_EN = '1' else 'Z';

     o_SCL   <= s_SCL_int when s_SCL_EN = '1' else 'Z';
     o_SDA   <= s_SDA_int when s_SDA_EN = '1' else 'Z';
     

    
end architecture;
