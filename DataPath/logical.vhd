library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity logical is
  GENERIC(
	n : Integer :=32
		); 
  
    Port (
    A, B       : in  STD_LOGIC_VECTOR(n-1 downto 0);  
    Op	: in  STD_LOGIC_VECTOR(1 downto 0);  
    R	: out  STD_LOGIC_VECTOR(n-1 downto 0):= x"00000000"
    );
end logical;

architecture Behavioral of logical is
begin
   process(A,B,Op)
 begin
  case(Op) is
  when "00" => -- Logical and 
   R<= A and B;
  when "01" => -- Logical or
   R<= A or B;
  when "10" => -- Logical xor 
   R<= A xor B;
  when "11" => -- Logical nor
   R <= A nor B;
  when others => 
   R <= "00000000000000000000000000000000";
  end case;
 end process;
end Behavioral;