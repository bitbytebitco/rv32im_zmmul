library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity imm_gen is
    port(
        i_inst : in std_logic_vector(31 downto 0);
        i_ImmSel : in std_logic_vector(2 downto 0);
        o_imm : out std_logic_vector(31 downto 0)
    );
end entity;

architecture imm_gen_rtl of imm_gen is

    signal funct3 : std_logic_vector(2 downto 0);
    signal funct7 : std_logic_vector(6 downto 0);
    
    begin
    
        process(i_ImmSel, i_inst)
            begin
                o_imm(31 downto 0) <= x"00000000";
            
                if(i_ImmSel = "000") then --------------------- I-type
                    if(i_inst(6 downto 0) = "0000011") then -- LB/LH/LW/LBU/LHU
                        
                        if(i_inst(14 downto 12) = "100" or i_inst(14 downto 12) = "101") then
                            -- unsigned extension for LBU,LHU
                            o_imm(31 downto 12) <= "00000000000000000000";
                        else
                            -- sign extension 
                            if(i_inst(31) = '0') then
                                 o_imm(31 downto 12) <= "00000000000000000000";
                            else
                                 o_imm(31 downto 12) <= "11111111111111111111";
                            end if;
                        end if;
                        -- lower 12-bits
                        o_imm(11 downto 0) <= i_inst(31 downto 20); 
                    elsif(i_inst(6 downto 0) = "0010011") then -- addi/slti/sltiu/xori/ori/andi/slli/srli/srai
                        
                        -- handling exception for shift-immediate instructions
                        if((i_inst(31 downto 25) = "0000000" and i_inst(14 downto 12) = "001") or 
                           (i_inst(31 downto 25) = "0000000" and i_inst(14 downto 12) = "101") or
                           (i_inst(31 downto 25) = "0100000" and i_inst(14 downto 12) = "101")) then 
                                o_imm(31 downto 0) <= "000000000000000000000000000" &  i_inst(24 downto 20);
                        else 
                            -- sign extension 
                            if(i_inst(31) = '0') then
                                o_imm(31 downto 12) <= "00000000000000000000";
                            else
                                o_imm(31 downto 12) <= "11111111111111111111";
                            end if;
                            o_imm(11 downto 0) <= i_inst(31 downto 20);
                        end if;
                    end if;
                elsif(i_ImmSel = "001") then --------------------- U-type
                    if(i_inst(6 downto 0) = "0110111") then -- LUI
                        o_imm(31 downto 0) <= i_inst(31 downto 12) & "000000000000";
                    elsif(i_inst(6 downto 0) = "0010111") then -- AUIPC
                        o_imm(31 downto 0) <= i_inst(31 downto 12) & "000000000000";
                    end if;   
                elsif(i_ImmSel = "010") then --------------------- S-type 
                    -- sign extension 
                    if(i_inst(31) = '0') then
                        o_imm(31 downto 11) <= "000000000000000000000";
                    else
                        o_imm(31 downto 11) <= "111111111111111111111";
                    end if;
                    o_imm(10 downto 5) <= i_inst(30 downto 25);
                    o_imm(4 downto 0) <= i_inst(11 downto 7);
                elsif(i_ImmSel = "011") then --------------------- B-type 
                    -- sign extension 
                    if(i_inst(31) = '0') then
                        o_imm(31 downto 12) <= "00000000000000000000";
                    else
                        o_imm(31 downto 12) <= "11111111111111111111";
                    end if;   
                    
                    o_imm(11) <= i_inst(7);
                    o_imm(10 downto 5) <= i_inst(30 downto 25);
                    o_imm(4 downto 1) <= i_inst(11 downto 8);
                    o_imm(0) <= '0';
                    
                end if;
        end process;
    
end architecture;
