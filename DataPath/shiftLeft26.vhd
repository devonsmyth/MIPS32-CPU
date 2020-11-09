library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY shiftLeft26 IS
   PORT( 
      d   : IN     std_logic_vector(25 downto 0);
      q   : OUT    std_logic_vector(27 downto 0) := x"0000000"
   );
END shiftLeft26 ;

ARCHITECTURE behav OF shiftLeft26 IS
signal t: std_logic_vector(27 downto 0);

BEGIN
   t <= d(25 downto 0) & "00";
   q <= t;
end behav;
