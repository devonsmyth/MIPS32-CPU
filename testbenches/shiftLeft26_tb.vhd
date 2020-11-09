library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity shiftLeft26_tb is 
end shiftLeft26_tb;

architecture Behavioral of shiftLeft26_tb is

component shiftLeft26 is  
    Port (
	    d   : IN     std_logic_vector(25 downto 0);
      q   : OUT    std_logic_vector(27 downto 0) := x"0000000"
    );
end component;

signal d: std_logic_vector(25 downto 0);
signal q: std_logic_vector(27 downto 0);

begin
	LS: shiftLeft26 port map (d,q);
	process
	begin
		d <= "00000000000000000000000011";
		wait for 10ns;
		d <= "11000000000000000000000000";

	wait;
	end process;

end Behavioral;