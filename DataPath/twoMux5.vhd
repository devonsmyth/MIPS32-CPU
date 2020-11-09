LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY twoMux5 IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in     std_logic;
      d1   : in     std_logic_vector(4 downto 0);
      d2   : in     std_logic_vector(4 downto 0);
      q  : out    std_logic_vector(4 downto 0) := "00000"
   );
END twoMux5;

ARCHITECTURE behav OF twoMux5 IS
BEGIN
     q <= d1 when (sel = '0') else
       d2 when (sel = '1') else
       "00000";
END behav;
