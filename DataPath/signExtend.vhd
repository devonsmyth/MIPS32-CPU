library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity signExtend is  
    Port (
	    A 		: in  STD_LOGIC_VECTOR(15 downto 0);   
	    op      : in  STD_LOGIC_VECTOR(5 downto 0);   
	    R		: out  STD_LOGIC_VECTOR(31 downto 0):= x"00000000"
    );
end signExtend;

architecture Behavioral of signExtend is
	signal b15: std_logic; 
	signal a1: std_logic_vector(15 downto 0); 
	signal a2: std_logic_vector(15 downto 0); 
	signal r1: std_logic_vector(31 downto 0);
	signal r2: std_logic_vector(31 downto 0);
begin

b15 <= A(15);
a1 <= b15 & b15 & b15 & b15 & b15 & b15 &
	 b15 & b15 & b15 & b15 & b15 & b15 & 
	 b15 & b15 & b15 & b15;
a2 <= "0000000000000000"; 
r1 <= a1 & A;
r2 <= a2 & A; --dont se

R <= r2 when (op="001101") else r1;


end Behavioral;