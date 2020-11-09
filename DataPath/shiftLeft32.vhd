library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY shiftLeft32 IS
   PORT( 
      d   : IN     std_logic_vector(31 downto 0);
      q   : OUT    std_logic_vector(31 downto 0) := x"00000000"
   );
END shiftLeft32 ;

ARCHITECTURE behav OF shiftLeft32 IS
signal t: std_logic_vector(31 downto 0);

BEGIN
   t <= d(29 downto 0) & "00";
   q <= t;
end behav;
