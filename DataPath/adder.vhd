library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder64 is
	port (
		A     : in std_logic_vector(63 downto 0);
		B     : in std_logic_vector(63 downto 0) ;
		S     : out std_logic_vector(63 downto 0) := x"0000000000000000"
	);
end adder64;

architecture behavior of adder64 is
begin

	S <= std_logic_vector(unsigned(A) + unsigned(B));

end behavior;