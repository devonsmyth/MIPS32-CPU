library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity comparator is
  GENERIC(
	n : Integer :=32
		); 
  
    Port (
    A_31, B_31, S_31, CO: in  STD_LOGIC;
    ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);  
    R		  : out  STD_LOGIC_VECTOR(n-1 downto 0):= x"00000000"
    );
end comparator ;

architecture Behavioral of comparator is
	signal slt : std_logic; 
begin

slt <= (A_31 and (not(B_31))) or (A_31 and S_31) or ((not(B_31)) and S_31);

R <= "0000000000000000000000000000000" & '0' when (ALUOp = "00") else
	 "0000000000000000000000000000000" & '0' when (ALUOp = "01") else
	 "0000000000000000000000000000000" & slt when (ALUOp = "10") else
	 "0000000000000000000000000000000" & not(CO) when (ALUOp = "11") else
	 "00000000000000000000000000000000";

end Behavioral;