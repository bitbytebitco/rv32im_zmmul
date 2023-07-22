library ieee;
use ieee.std_logic_1164.all;

entity half_adder is 
   port(ha_A : in std_logic;
	ha_B : in std_logic;
	ha_Sum: out std_logic;
	ha_Cout : out std_logic);
end entity;

architecture half_adder_arch of half_adder is
    begin
        ha_Sum <= ha_A xor ha_B;
        ha_Cout <= ha_A and ha_B;
end architecture;
