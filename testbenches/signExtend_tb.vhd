library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity signExtend_tb is 
end signExtend_tb;

architecture Behavioral of signExtend_tb is

component signExtend is  
    Port (
	    A 		: in  STD_LOGIC_VECTOR(15 downto 0);   
	    R		: out  STD_LOGIC_VECTOR(31 downto 0):= x"00000000"
    );
end component;

signal a: std_logic_vector(15 downto 0);
signal r: std_logic_vector(31 downto 0);

begin
	SE: signExtend port map (a,r);
	process
	begin
		a <= "0000000000000001";
		wait for 10ns;
		a <= "1000000000000001";

	wait;
	end process;

end Behavioral;