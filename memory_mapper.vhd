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
        port_out_00  : out std_logic_vector(15 downto 0);
        o_SCL : out std_logic;
        i_SDA : in std_logic;
        o_SDA : out std_logic
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
    
    
    -- I2C component declaration
    component i2c_module_write
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
            o_buffer_clear : out std_logic; 
            o_busy : out std_logic;
            o_done : out std_logic;
            o_SCL : out std_logic;
            o_SDA : out std_logic	
        );
    end component;
    
    
 
    signal r_i2c_current_data : std_logic_vector(7 downto 0) := x"00";
    signal w_i2c_start : std_logic;
    signal r_i2c_byte_cnt : std_logic_vector(7 downto 0);
    signal w_i2c_buffer_clear : std_logic := '0';
    signal w_i2c_done_clear : std_logic := '0';
    signal w_i2c_i_buffer_clear : std_logic;
    signal w_i2c_busy : std_logic := '0'; 
    signal w_i2c_done : std_logic := '0';
    signal r_i2c_stat : std_logic_vector(7 downto 0) := x"00";
    signal r_i2c_ctrl : std_logic_vector(7 downto 0);
    signal r_i2c_addr : std_logic_vector(6 downto 0);
    
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
        
    -- I2C port mapping
    I2C : i2c_module_write 
    generic map (
        g_CLK_RATE => 50_000_000
    )
    port map (
        i_reset_n => reset,
        i_CLK => clock,
        i_en => w_i2c_start,
        i_addr => r_i2c_addr,
        i_tx_byte => r_i2c_current_data,
        i_byte_cnt => r_i2c_byte_cnt,
        i_done_clear => w_i2c_done_clear,
        i_buffer_clear => w_i2c_i_buffer_clear,
        i_SDA => i_SDA,
        o_buffer_clear => w_i2c_buffer_clear,
        o_busy => w_i2c_busy,
        o_done => w_i2c_done,
        o_SCL => o_SCL,
        o_SDA => o_SDA
    );
    
    
    ---- I2C Routing
    r_i2c_stat(0) <= w_i2c_done;
    r_i2c_stat(1) <= w_i2c_buffer_clear;
    r_i2c_stat(2) <= w_i2c_busy;
    
    
    w_i2c_start <= r_i2c_ctrl(0);     
    w_i2c_i_buffer_clear <= r_i2c_ctrl(1);
    w_i2c_done_clear <= r_i2c_ctrl(2);

    
    I2C_PROC : process(clock, reset, i_address, i_data, i_write, w_i2c_busy)
        constant  addr_current_data : std_logic_vector(31 downto 0) := x"00000400";
        constant  addr_byte_cnt : std_logic_vector(31 downto 0) := x"00000401";
        constant  addr_stat : std_logic_vector(31 downto 0) := x"00000402";
        constant  addr_ctrl : std_logic_vector(31 downto 0) := x"00000403";
        constant  addr_device : std_logic_vector(31 downto 0) := x"00000404";
      begin
            if(reset = '0') then
                r_i2c_current_data <= x"00";
            --elsif(rising_edge(clock) and i_write = '1' and i_data(0) = '1') then
            elsif(rising_edge(clock) and i_write = '1') then
            
                if(i_address = addr_current_data) then
                
                    -- i2c_current_byte
                    r_i2c_current_data <= i_data(7 downto 0);  
                    
                elsif(i_address = addr_byte_cnt ) then
                
                    -- i2c_byte_cnt
                    r_i2c_byte_cnt <= i_data(7 downto 0);
                    
                elsif(i_address = addr_ctrl) then   
                
                    -- i2c_ctrl_wrd
                    r_i2c_ctrl <= i_data(7 downto 0);
                    
                elsif(i_address = addr_device) then   
                
                    -- i2c_addr
                    r_i2c_addr <= i_data(6 downto 0);
                    
                end if;
                      
            end if;
    end process;
    
        
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
    MEM_MUX: process(i_address, w_o_data, port_in_00, r_i2c_stat)
	   begin
	    -- Program Memory (address range 0 to 127)
--	    if(to_integer(unsigned(address)) >= 0 and 
--		to_integer(unsigned(address)) <= 127) then 
--		data_out <= rom_data_out;
	    
	    -- Data Memory 
	    if(to_integer(unsigned(i_address)) >= 512 and to_integer(unsigned(i_address)) <= 2047) then 
	    	
	    	
            -- i2c
            if(i_address = x"00000402") then
                o_data <= x"000000" & r_i2c_stat;
            else 
                o_data <= w_o_data;
            end if;   
            
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
