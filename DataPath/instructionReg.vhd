LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY instructionReg IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      write : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q31  : out    std_logic_vector(5 downto 0) := "000000";
      q25  : out    std_logic_vector(4 downto 0) := "00000";
      q20  : out    std_logic_vector(4 downto 0) := "00000";
      q15  : out    std_logic_vector(15 downto 0) := x"0000"
   );
END instructionReg;

ARCHITECTURE behav OF instructionReg IS

BEGIN
     process(clk, rst)
     begin
        if(rst = '1') then
           q31 <= "000000";
           q25 <= "00000";
           q20 <= "00000";
           q15 <= x"0000";
        elsif(rising_edge(clk) and (write = '1')) then
           q31 <= d(31 downto 26);
           q25 <= d(25 downto 21);
           q20 <= d(20 downto 16);
           q15 <= d(15 downto 0);
        end if;
     end process;
END behav;
