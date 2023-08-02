library IEEE;
use IEEE.std_logic_1164.all;

library IEEE_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;


entity floating_point_add is 
    generic (
        bits_wide : integer := 32
    );
    port(
         A, B : in std_logic_vector((bits_wide-1) downto 0);
         Result : out std_logic_vector((bits_wide-1) downto 0));
end entity;

architecture floating_point_add_rtl of floating_point_add is

    begin
    
    FPADD: process(A, B)
        variable  f_A, f_B, f_R : float32;
        
        begin
            f_A := to_float(A);
            f_B := to_float(B);
            
            -- Perform the Addition using the add() function
            f_R := add (l => f_A, r => f_B);

  
            Result <= to_std_logic_vector(f_R);  
    end process;
    
end architecture;
