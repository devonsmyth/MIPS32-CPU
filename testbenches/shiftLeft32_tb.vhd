library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity shiftLeft32_tb is 
end shiftLeft32_tb;

architecture Behavioral of shiftLeft32_tb is

component shiftLeft32 is  
   PORT( 
      d   : IN     std_logic_vector(31 downto 0);
      q   : OUT    std_logic_vector(31 downto 0) := x"00000000"
   );
end component;

signal d: std_logic_vector(31 downto 0);
signal q: std_logic_vector(31 downto 0);

begin
	LS: shiftLeft32 port map (d,q);
	process
	begin
		d <= x"00000003";
		wait for 10ns;
		d <= x"30000000";

	wait;
	end process;

end Behavioral;