LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY pcReg IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      write : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
END pcReg;

ARCHITECTURE behav OF pcReg IS

BEGIN
     process(clk, rst)
     begin
        if(rst = '1') then
           q <= x"00000000";
        elsif(rising_edge(clk) and (write = '1')) then
           q <= d;
        end if;
     end process;
END behav;
