library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
--use ieee.std_logic_unsigned.all;

entity alu is
	port(
		in_A : in std_logic_vector(31 downto 0);
		in_B : in std_logic_vector(31 downto 0);
		in_ALUSel : in std_logic_vector(3 downto 0);
		out_ALUResult : out std_logic_vector(31 downto 0)
	);
end entity;

architecture alu_arch of alu is 

    -- Signal declarations
    constant n : integer := 32; -- # of Bits in Multiplier
    signal w_A, w_B : std_logic_vector( (n-1) downto 0);
    signal w_HL, w_SU : std_logic;
    signal w_P : std_logic_vector(31 downto 0);
    signal w_P64 : std_logic_vector(63 downto 0);
    
    -- Component declarations
    component UnsignedNBitMultiplier
        generic (
            bits_wide : integer := 32
        );
        port(
            i_A : in std_logic_vector( (n-1) downto 0);
            i_B : in std_logic_vector( (n-1) downto 0);
            i_SU : in std_logic; -- 0: unsigned, 1: signed
            i_HL : in std_logic := '1';
            o_prod64 : out std_logic_vector( ((2*bits_wide)-1) downto 0);
            o_prod : out std_logic_vector( (bits_wide-1) downto 0)
        );
    end component;

    begin
    
--        MUL : UnsignedNBitMultiplier
--        generic map(
--            bits_wide => n
--        ) 
--        port map(
--            i_A => w_A, 
--            i_B => w_B,
--            i_SU => w_SU,
--            i_HL => w_HL,
--            o_prod64 => w_P64,
--            o_prod => w_P); 
            
        
        ALU_PROCESS : process(in_A, in_B, in_ALUSel, w_P)
            variable Sum_signed : signed(31 downto 0);
            variable Sum_uns : unsigned(32 downto 0);
            variable diff_uns : unsigned(31 downto 0);

            begin

                case in_ALUSel is
                    when "0000" =>  -- pass A 
                        out_ALUResult <= in_A;
                    when "0001" =>  -- pass B
                        out_ALUResult <= in_B;
                    when "0010" =>  -- ADD Operation
                        -- Sum Calculation
--                        Sum_uns := unsigned('0' & in_A) + unsigned('0' & in_B);
--                        out_ALUResult <= std_logic_vector(Sum_uns(31 downto 0));
                        Sum_signed := signed(in_A) + signed(in_B);
                        out_ALUResult <= std_logic_vector(Sum_signed);
                    when "0011" =>  -- SUB Operation
                        -- Difference Calculation
--                        diff_uns := unsigned(in_A) - unsigned(in_B);
--                        out_ALUResult <= std_logic_vector(diff_uns);
                        out_ALUResult <= std_logic_vector(signed(in_A) - signed(in_B));
                    when "0100" =>  -- SLL Operation
                        -- Shift Logic Left
                        out_ALUResult <= std_logic_vector(shift_left(unsigned(in_A),to_integer(unsigned(in_B))));     
                    when "0101" =>  -- SLT Operation
                        -- Set Less Than
                        if(signed(in_A) < signed(in_B)) then
                            out_ALUResult <= x"00000001";
                        else 
                            out_ALUResult <= x"00000000";
                        end if;
                    when "0110" =>  -- SLTU Operation
                        -- Set Less Than Unsigned
                        if(unsigned(in_A) < unsigned(in_B)) then
                            out_ALUResult <= x"00000001";
                        else 
                            out_ALUResult <= x"00000000";
                        end if;  
                    when "0111" =>  -- XOR Operation
                        -- XOR
                        out_ALUResult <= in_A xor in_B;
                    when "1000" =>  -- SRL Operation
                        -- Shift Right Logical
                        out_ALUResult <= std_logic_vector(shift_right(unsigned(in_A),to_integer(unsigned(in_B))));
                    when "1001" =>  -- SRA Operation  
                        -- Shift Right Arithmetic
                        out_ALUResult <= std_logic_vector(shift_right(signed(in_A),to_integer(signed(in_B)))); 
                    when "1010" => -- MUL 
                        
                        -- IMPORTANT: both of these methods don't seem to finish in 1 cycle, this will need pipelining or stall signal
                    
                        -- Using NBitMultiplier (Sum of Partial Products with CLA)
                        w_SU <= '0'; -- 0: unsigned, 1: signed
                        w_HL <= '0'; -- currently hardcoded to only return bottom 32-bits --> 0: low, 1: high
                        
                        w_A <= in_A;
                        w_B <= in_B;

--                        w_B <= "11111111111111111111111111011000";
--                        w_A <= "00000000000000000000000000010100";
                        
--                        w_A <= "00000000000000000000000000101000";
--                        w_B <= "00000000000000000000000000010100";
--                        w_B <= in_B;
                        out_ALUResult <= w_P;
                        
                        -- Alt. method using `ieee.std_logic_unsigned.all`
--                        w_P64 <= in_A * in_B;
--                        out_ALUResult <= w_P64(31 downto 0);
                    when "1011" =>  -- OR Operation
                        -- OR
                        out_ALUResult <= in_A or in_B;
                    when "1100" =>  -- AND Operation
                        -- AND
                        out_ALUResult <= in_A and in_B;
                    when "1101" => -- Unsigned Integer Divide -- NEEDS WORK 
                        out_ALUResult <= std_logic_vector(unsigned(in_A) / unsigned(in_B));
                    when others => 
                        out_ALUResult <= (others => 'X');
                end case;
                
                
        end process;
end architecture;
