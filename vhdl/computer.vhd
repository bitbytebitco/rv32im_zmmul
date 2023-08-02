library IEEE;
use IEEE.std_logic_1164.all; 

--entity computer is
--    port   ( clock          : in   std_logic;
--             reset          : in   std_logic;
--             port_in_00  : in std_logic_vector(31 downto 0);
--             port_in_01  : in std_logic_vector(31 downto 0);
--             port_in_02  : in std_logic_vector(31 downto 0);
--             port_in_03  : in std_logic_vector(31 downto 0);
--             port_in_04  : in std_logic_vector(31 downto 0)
--            )
--end entity;

entity computer is
    port( 
        clock : in std_logic;
        reset : in std_logic;
        i_load_imem : in std_logic := '0';
        i_uart_rx_00 : in std_logic := '0';
        port_in_00  : in std_logic_vector(7 downto 0) := x"00";
        o_port_out_00 : out std_logic_vector(15 downto 0);
        o_SCL : out std_logic := 'Z';
        i_SDA : in std_logic := 'Z';
        o_SDA : out std_logic := 'Z'
    );
end entity;

architecture computer_arch of computer is

    -- signals
    signal w_write : std_logic;
    signal w_byte_sel : std_logic_vector(2 downto 0);
    signal w_address, data_in, data_out, r_PC, r_inst: std_logic_vector( 31 downto 0) := x"00000000";
    signal r_port_out_00 : std_logic_vector(15 downto 0);
    
    -- clock div
    signal w_clk_div, w_clk_div1 : std_logic;
    signal r_div_int : integer;
    
    
    --- CPU
    component rv32i
        port(
            clock : in std_logic;
            reset : in std_logic;
            i_inst: in std_logic_vector(31 downto 0);
            i_load_imem : in std_logic;
            o_address : out std_logic_vector( 31 downto 0);
            o_write : out std_logic;
            o_byte_sel : out std_logic_vector(2 downto 0);
            o_PC : out std_logic_vector(31 downto 0);
            to_memory : out std_logic_vector( 31 downto 0);
            from_memory : in std_logic_vector( 31 downto 0)
        );
    end component;
    
    component memory_mapper
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
            port_in_00  : in std_logic_vector(7 downto 0);
            port_out_00  : out std_logic_vector(15 downto 0);
            o_inst : out std_logic_vector(31 downto 0);
            o_data : out std_logic_vector(31 downto 0); 
            o_SCL : out std_logic;
            i_SDA : in std_logic;
            o_SDA : out std_logic
        );
    end component;

    begin
    
        -- Clock Division
--        CLK_DIV : process(reset, clock, w_clk_div)
--            begin
--                if(reset = '0') then
--                    r_div_int <= 0;
--                    w_clk_div <= '0';
--                elsif(rising_edge(clock)) then
--                    r_div_int <= r_div_int + 1;
--                    if(r_div_int = 4) then
--                        w_clk_div <= not w_clk_div;
--                        r_div_int <= 0;
--                    end if;
--                end if;
--        end process;
        
        CLK_DIV : process(reset, clock, w_clk_div)
            begin
                if(reset = '0') then
                    w_clk_div <= '0';
                elsif(rising_edge(clock)) then
                    w_clk_div <= not w_clk_div;
                end if;
        end process;
        
        CLK_DIV1 : process(reset, w_clk_div, w_clk_div1)
            begin
                if(reset = '0') then
                    w_clk_div1 <= '0';
                elsif(rising_edge(w_clk_div)) then
                    w_clk_div1 <= not w_clk_div1;
                end if;
        end process;
    
        o_port_out_00 <= r_port_out_00;
    
        -- CPU Init
        CPU_0 : rv32i port map(
                clock => w_clk_div1, 
                reset => reset, 
                i_inst => r_inst,
                i_load_imem => i_load_imem,
                o_address => w_address,
                o_write => w_write,
                o_byte_sel => w_byte_sel,
                o_PC => r_PC,
                to_memory => data_in,
                from_memory => data_out
             );
            
            
        -- Memory Device
        MEM_MAPPER : memory_mapper port map(
                clock => w_clk_div, 
                reset => reset, 
                i_PC => r_PC,
                i_SDA => i_SDA,
                i_address => w_address,
                i_write => w_write,
                i_data => data_in,
                i_byte_sel => w_byte_sel,
                i_uart_rx_00 => i_uart_rx_00,
                i_load_imem => i_load_imem,
                o_data => data_out, 
                port_in_00 => port_in_00,
                port_out_00 => r_port_out_00, 
                o_inst => r_inst,
                o_SCL => o_SCL,
                o_SDA => o_SDA
             );
end architecture;


