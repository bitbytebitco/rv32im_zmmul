library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;
 
entity memory_mapper is
    port(
        clock : in std_logic;
        reset : in std_logic;
        i_PC : in std_logic_vector(31 downto 0);
        i_write : in std_logic;
        i_address : in std_logic_vector(31 downto 0);
        i_data : in std_logic_vector(31 downto 0);
        i_byte_sel : in std_logic_vector(2 downto 0);
        i_uart_rx_00 : in std_logic;
        i_load_imem : in std_logic;
        o_data : out std_logic_vector(31 downto 0);
        port_in_00  : in std_logic_vector(7 downto 0);
        port_out_00  : out std_logic_vector(15 downto 0);
        o_inst : out std_logic_vector(31 downto 0);
        o_SCL : out std_logic;
        i_SDA : in std_logic;
        o_SDA : out std_logic
    );   
end entity;

architecture memory_mapper_rtl of memory_mapper is
    
    signal w_o_data, w_inst : std_logic_vector(31 downto 0);
    signal r_port_out_00 : std_logic_vector(15 downto 0) := x"0000";
    
    --attribute dont_touch : string;
    --attribute dont_touch of memory_mapper_rtl : architecture is "yes";
    
        -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF i_PC : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF i_data : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF o_data : SIGNAL IS "true";
    

    --IMEM
    component instruction_memory
        port(
            clock : in std_logic;
            in_reset_imem : in std_logic;
            in_addr: in std_logic_vector(31 downto 0);
            in_data : in std_logic_vector(31 downto 0);
            in_rw : in std_logic;
            out_inst : out std_logic_vector(31 downto 0)
        );
    end component;
    
    -----------------------------------
    -- DMEM
    -----------------------------------
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
    
    -----------------------------------
    -- UART
    -----------------------------------
    component uart_rx is
      generic (
        g_CLKS_PER_BIT : integer := 217    -- Needs to be set correctly    (434 when  100 MHz, 87 when 10 MHz, 108 for 25 MHz)
        );
      port (
        i_Clk       : in  std_logic;
        i_RX_Serial : in  std_logic;
        o_RX_DV     : out std_logic;
        o_RX_Byte   : out std_logic_vector(7 downto 0)
        );
    end component;
  
    
    -----------------------------------
    -- I2C
    -----------------------------------
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
    
    -----------------------------------
    -- Floating-Point 
    -----------------------------------
    component accel_wrap 
        generic (
            BITS_WIDE : integer := 32;
            CYCLE_CNT : integer := 2
        );
        port(
            i_fp_clock         : in std_logic;
            i_fp_reset         : in std_logic;
            i_fp_start         : in std_logic;
            i_fp_A             : in std_logic_vector(BITS_WIDE-1 downto 0);
            i_fp_B             : in std_logic_vector(BITS_WIDE-1 downto 0);
            i_fp_done_clear    : in std_logic;
            o_fp_R             : out std_logic_vector(31 downto 0);
            o_fp_busy          : out std_logic;
            o_fp_done          : out std_logic
        );
    end component;
    
        -- floating point
    signal w_fp_start, w_fp_done_clear, w_fp_busy, w_fp_done : std_logic;
    signal r_fp_A : std_logic_vector(31 downto 0);
    signal r_fp_B : std_logic_vector(31 downto 0);
    signal r_fp_result : std_logic_vector(31 downto 0);
    
    ATTRIBUTE MARK_DEBUG OF r_fp_A : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF r_fp_B : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF r_fp_result : SIGNAL IS "true";
    
    
    -- i2c 
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
    
    -- uart
    signal w_i_uart_rx_00 : std_logic;
    signal w_uart_rx_dv : std_logic;
    signal r_uart_rx_byte : std_logic_vector(7 downto 0);
    
    -- imem 
    signal r_imem_data, w_muxed_addr : std_logic_vector(31 downto 0);
    signal w_imem_rw, w_imem_dv : std_logic;
    signal byte_cnt : integer range 0 to 511 := 0;
    signal bcnt : integer range 0 to 3 := 0;
    
    ATTRIBUTE MARK_DEBUG OF r_imem_data : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF w_imem_rw : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF byte_cnt : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF bcnt : SIGNAL IS "true";
    
    
 begin
 
    
 
    p_FLOATING : process(clock, reset, i_address, i_write, i_data)
      begin
        if(reset = '0') then
            -- w_fp_start <= '1';
            r_fp_A <= x"00000000";
            r_fp_B <= x"00000000";
        elsif(rising_edge(clock)) then 
            if(i_write = '1') then
            
                case i_address is
                    when x"00000FF1" =>  --- SET A & CLEAR B
                        -- w_fp_start <= '1';
                        r_fp_A <= i_data;
                        r_fp_B <= x"00000000";
                    when x"00000FF2" =>  --- SET B
                        r_fp_B <= i_data;
                    when others =>
                        r_fp_A <= x"00000000";
                        r_fp_B <= x"00000000";
                end case;        
               

            end if;
        end if;
    end process;
    

    
 
--      port_out_00 <= r_port_out_00; 
     
--    port_out_00 <= x"00" & r_uart_rx_byte when w_uart_rx_dv = '1' else x"0000";
    
    p_PC_MUX : process(i_load_imem, i_PC, byte_cnt, w_muxed_addr) 
        begin
            if(i_load_imem = '1') then 
                w_muxed_addr <= std_logic_vector(to_unsigned(byte_cnt , w_muxed_addr'length));
            else 
                w_muxed_addr <= i_PC;
            end if;
    end process;
    
    -- testing reading uart rx
    p_MEM_WRITE : process(reset, w_uart_rx_dv, r_uart_rx_byte, i_load_imem)
        begin
              
            if(reset = '0') then
                byte_cnt <= 0;
                bcnt <= 0;
                w_imem_dv <= '0';
                r_imem_data <= x"00000000";
            elsif (rising_edge(w_uart_rx_dv)) then
                
                if(i_load_imem = '1') then                
                    case bcnt is
                        when 0 => 
                            r_imem_data(7 downto 0) <= r_uart_rx_byte;
                            
                            bcnt <= 1;
                            w_imem_dv <= '0';
                        when 1 => 
                            r_imem_data(15 downto 8) <= r_uart_rx_byte;
                            bcnt <= 2;
                            w_imem_dv <= '0';
                        when 2 => 
                            r_imem_data(23 downto 16) <= r_uart_rx_byte;
                            bcnt <= 3;
                            w_imem_dv <= '0';
                        when 3 => 
                            r_imem_data(31 downto 24) <= r_uart_rx_byte;
                            bcnt <= 0;
                            w_imem_dv <= '1';
                            byte_cnt <= byte_cnt + 4;
                        when others => 
                            r_imem_data <= x"00000000";
                            bcnt <= 0;
                            w_imem_dv <= '0';
                    end case;
                end if; 


            end if;
    end process;
      
    
    w_i_uart_rx_00 <= i_uart_rx_00;
    
    o_inst <= w_inst;
    
    
    w_imem_rw <= '1' when (i_load_imem = '1' and w_imem_dv = '1') else '0';
    
    -- UART mapping
    UART_RX_00: uart_rx 
        port map(
            i_Clk => clock,
            i_RX_Serial => w_i_uart_rx_00,
            o_RX_DV => w_uart_rx_dv,
            o_RX_Byte => r_uart_rx_byte
        );
        
        
    -- IMEM init
    IMEM : instruction_memory 
        port map(
            clock => clock,
            in_reset_imem => reset,
            in_addr => w_muxed_addr,
            in_data => r_imem_data,
            in_rw => w_imem_rw,
            out_inst => w_inst
        );
      
    
       
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
    
    
    --------------------------------
    ---- I2C Routing
    --------------------------------
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
    --------------------------------
    ---  end I2C Routing
    --------------------------------
    
     
    --------------------------------
    ---  Floating-Point 
    --------------------------------
    p_ACCEL_WRAPPER : accel_wrap
        generic map (
            BITS_WIDE => 32,
            CYCLE_CNT => 1
        )
        port map (
            i_fp_clock => clock,
            i_fp_reset => reset,
            i_fp_start => '1',
            i_fp_A => r_fp_A,
            i_fp_B => r_fp_B,
            i_fp_done_clear => w_fp_done_clear,
            o_fp_R => r_fp_result,
            o_fp_busy => w_fp_busy,
            o_fp_done => w_fp_done
        );
    
        
    --- TEMP COMMENTED
    -- port_out_00 : ADDRESS x"00000FF0"
--    P0 : process(clock, reset, i_address, i_write, i_data)
--      begin
--        if(reset = '0') then
--            r_port_out_00 <= x"0000";
--        elsif(rising_edge(clock)) then 
--            if(i_address = x"00000FF0" and i_write = '1') then
--                r_port_out_00 <= i_data(15 downto 0);
--            end if;
--        end if;
--    end process;
    
    
        
    -- Memory Multiplexer Init
    MEM_MUX: process(i_address, w_o_data, port_in_00, r_i2c_stat, r_fp_result)
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

        -- Read Floating-point
	    elsif(i_address = x"00000FE1") then 
            o_data <= r_fp_result;        
                 
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