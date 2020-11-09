LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY fourMux32 IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in      std_logic_vector(1 downto 0);
      d1   : in     std_logic_vector(31 downto 0);
      d2   : in     std_logic_vector(31 downto 0);
      d3   : in     std_logic_vector(31 downto 0);
      d4   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
END fourMux32;

ARCHITECTURE behav OF fourMux32 IS
BEGIN
     q <= d1 when (sel = "00") else
       d2 when (sel = "01") else
       d3 when (sel = "10") else
       d4 when (sel = "11") else
       x"00000000";
END behav;
