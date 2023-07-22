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
        port_in_00  : in std_logic_vector(7 downto 0) := x"00";
        o_port_out_00 : out std_logic_vector(15 downto 0) 
    );
end entity;

architecture computer_arch of computer is

    -- signals
    signal w_write : std_logic;
    signal w_byte_sel : std_logic_vector(2 downto 0);
    signal w_address, data_in, data_out : std_logic_vector( 31 downto 0);
    signal r_port_out_00 : std_logic_vector(15 downto 0);
    
    -- clock div
    signal w_clk_div : std_logic;
    signal r_div_int : integer;
    
    -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF w_clk_div : SIGNAL IS "true";
    
    
    --- CPU
    component rv32i
        port(
            clock : in std_logic;
            reset : in std_logic;
            o_address : out std_logic_vector( 31 downto 0);
            o_write : out std_logic;
            o_byte_sel : out std_logic_vector(2 downto 0);
            to_memory : out std_logic_vector( 31 downto 0);
            from_memory : in std_logic_vector( 31 downto 0)
        );
    end component;
    
    component memory_mapper
        port(
            clock : in std_logic;
            reset : in std_logic;
            i_write : in std_logic;
            i_address : in std_logic_vector(31 downto 0);
            i_data : in std_logic_vector(31 downto 0);
            i_byte_sel : in std_logic_vector(2 downto 0);
            port_in_00  : in std_logic_vector(7 downto 0);
            port_out_00  : out std_logic_vector(15 downto 0);
            o_data : out std_logic_vector(31 downto 0)
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
--                    if(r_div_int = 1) then
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
    
        o_port_out_00 <= r_port_out_00;
    
        -- CPU Init
        CPU_0 : rv32i port map(
                clock => w_clk_div, 
                reset => reset, 
                o_address => w_address,
                o_write => w_write,
                o_byte_sel => w_byte_sel,
                to_memory => data_in,
                from_memory => data_out
             );
            
            
        -- Memory Device
        MEM_MAPPER : memory_mapper port map(
                clock => w_clk_div, 
                reset => reset, 
                i_address => w_address,
                i_write => w_write,
                i_data => data_in,
                i_byte_sel => w_byte_sel,
                o_data => data_out, 
                port_in_00 => port_in_00,
                port_out_00 => r_port_out_00
             );
end architecture;


