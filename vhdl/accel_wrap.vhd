library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity accel_wrap is
    generic (
        BITS_WIDE : integer := 32;
        CYCLE_CNT : integer := 10
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
end entity;

architecture accel_wrap_rtl of accel_wrap is
    
        -- signal and constant declarations
        type state_type is (IDLE, BUSY, VALID_WAIT);
        signal current_state, next_state : state_type;
        
        signal clk_cnt: integer := 0;
        constant n : integer := BITS_WIDE;
        
        signal w_A, w_B : std_logic_vector(n-1 downto 0);
        signal w_R : std_logic_vector(31 downto 0);
        
             
        -- component declaration
        component floating_point_add
            generic (
                bits_wide : integer := 32
            );
            port(
                 A, B: in std_logic_vector((bits_wide-1) downto 0);
                 Result : out std_logic_vector((bits_wide-1) downto 0));
        end component;
    


    begin
    
        w_A <= i_fp_A;
        w_B <= i_fp_B;    
        o_fp_R <= w_R;    

        ------------------------------------------------------------------------------------------------------------------------------------
        -- COMPONENT INSTANTIATION
        ------------------------------------------------------------------------------------------------------------------------------------ 
        p_FP_ADD : floating_point_add 
            generic map (
                bits_wide => n
            )
            port map(
                A => w_A, 
                B => w_B,
                Result => w_R
        );    
            
    
        ------------------------------------------------------------------------------------------------------------------------------------
        -- STATE MEMORY
        ------------------------------------------------------------------------------------------------------------------------------------
        p_SM : process(i_fp_clock, i_fp_reset, current_state)
            begin
                if(i_fp_reset = '0') then
                    -- default
                    current_state <= IDLE;
                    clk_cnt <= 0;
                elsif(rising_edge(i_fp_clock)) then
                    current_state <= next_state;
                    
                    if(current_state = BUSY) then
                        clk_cnt <= clk_cnt + 1;
                    end if;
                    
                    if(current_state = VALID_WAIT) then
                        clk_cnt <= 0;
                    end if;
                end if;
        end process;
        
        
        ------------------------------------------------------------------------------------------------------------------------------------
        -- NEXT STATE LOGIC
        ------------------------------------------------------------------------------------------------------------------------------------
        p_NSM : process(current_state, i_fp_start, i_fp_done_clear, clk_cnt)
            begin
                case current_state is
                    when IDLE => 
                        if(i_fp_start = '1') then
                            next_state <= BUSY;
                        else 
                            next_state <= IDLE;
                        end if;
                    when BUSY =>
                        if(clk_cnt >= CYCLE_CNT) then
                            next_state <= VALID_WAIT;
                        else 
                            next_state <= BUSY;
                        end if;     
                    when VALID_WAIT => 
                        if(i_fp_done_clear = '1') then
                            next_state <= IDLE;
                        else 
                            next_state <= VALID_WAIT;
                        end if;
                    when others => next_state <= IDLE;
                end case;
        end process;
        
        
        
        ------------------------------------------------------------------------------------------------------------------------------------
        -- OUTPUT LOGIC
        ------------------------------------------------------------------------------------------------------------------------------------
        p_OL : process(clk_cnt, current_state, next_state)
            begin
                case current_state is
                    when IDLE => 
--                        o_fp_busy <= '0';
                        o_fp_done <= '0';
--                        w_R(8 downto -23) <= (others => 'U');
                        
                    when BUSY | VALID_WAIT =>
                        
                        if(current_state = BUSY) then
--                            o_fp_busy <= '1';
                            o_fp_done <= '0';
                        elsif(current_state = VALID_WAIT) then
--                            o_fp_busy <= '0';
                            o_fp_done <= '1';
--                        else 
--                            o_fp_busy <= 'U';
--                           o_fp_done <= 'U';
                        end if;                                                      
                        
                    when others => 
--                        o_fp_busy <= '0';
                        o_fp_done <= '0';
--                        w_R(8 downto -23) <= (others => 'U');
                end case;
        end process;
    
    
end architecture;
