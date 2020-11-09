LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY twoMux32 IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in     std_logic;
      d1   : in     std_logic_vector(31 downto 0);
      d2   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0)
   );
END twoMux32;

ARCHITECTURE behav OF twoMux32 IS
BEGIN
     q <= d1 when (sel = '0') else
       d2 when (sel = '1') else
       x"00000000";
END behav;
