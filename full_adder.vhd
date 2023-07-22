library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(fa_A   : in std_logic;
	 fa_B   : in std_logic; 
	 fa_Cin : in std_logic;
	 fa_Sum : out std_logic;
	 fa_Cout: out std_logic);
end entity;

architecture full_adder_arch of full_adder is
    signal S0, C0, S1, C1 : std_logic;

    component half_adder
	port(ha_A : in std_logic;
	     ha_B : in std_logic;
	     ha_Sum: out std_logic;
	     ha_Cout : out std_logic);
    end component;

    begin
        HA0 : half_adder port map(fa_A, fa_B, S0, C0);
        HA1 : half_adder port map(S0, fa_Cin, fa_Sum, C1);
        fa_Cout <= C0 or C1;
end architecture;
