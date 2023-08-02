library IEEE;
use IEEE.std_logic_1164.all; 

entity top is
    port( 
        CLK : in std_logic;
        RST : in std_logic;
        SW  : in std_logic_vector(7 downto 0);
        JA : out std_logic_vector(7 downto 0);
        led : out std_logic_vector(15 downto 0);
        i_uart_rx : in std_logic;
        o_uart_tx : out std_logic;
        io_SCL : inout std_logic;
        io_SDA : inout std_logic
    );
end entity;

architecture rtl of top is

  -- signal declarations
  signal port_in_00 : std_logic_vector(7 downto 0);
  signal P0 : std_logic_vector(15 downto 0);
  signal w_RST : std_logic;
  signal w_load_imem : std_logic;
  
    -- Declare vio_reset
    COMPONENT vio_reset
        PORT(
            CLK        : IN STD_LOGIC;
            PROBE_OUT0 : OUT STD_LOGIC
        );
    END COMPONENT;
    
  -- component declarations
  component computer
    port( 
        clock : in std_logic;
        reset : in std_logic;
        i_load_imem : in std_logic;
        i_uart_rx_00 : in std_logic;
        i_SDA : in std_logic;
        port_in_00  : in std_logic_vector(7 downto 0);
        o_port_out_00  : out std_logic_vector(15 downto 0);
        o_SCL : out std_logic;
        o_SDA : out std_logic
    );
  end component;
  
  begin
  
      -- switches
      port_in_00 <= SW(7 downto 0);
      
      w_load_imem <= SW(0); -- load imem switch
      
      -- led
      led(15 downto 8) <= port_in_00;
      led(7 downto 0) <= P0(7 downto 0);
      
        VIO: vio_reset
            port map(
                CLK => CLK, 
                PROBE_OUT0 => w_RST
            );
            
      
        -- component port mapping
        C0 : computer
            port map(
                clock => CLK,
                reset => w_RST,
                i_uart_rx_00 => i_uart_rx, 
                i_load_imem => w_load_imem,
                port_in_00 => port_in_00,
                o_port_out_00 => P0,
                o_SCL => io_SCL,
                i_SDA => io_SDA,
                o_SDA => io_SDA
            );


        -- JA Pmod
        JA <= P0(7 downto 0);



end architecture;

