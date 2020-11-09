library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity shifter is
  GENERIC(
	n : Integer :=32
		); 
  
    Port (
    A 		: in  STD_LOGIC_VECTOR(n-1 downto 0);  
    SHAMT   : in  STD_LOGIC_VECTOR(4 downto 0);  
    ALUOp   : in  STD_LOGIC_VECTOR(1 downto 0);  
    R		: out  STD_LOGIC_VECTOR(n-1 downto 0):= x"00000000"
    );
end shifter ;

architecture Behavioral of shifter is
	signal L_0 : std_logic_vector(n-1 downto 0); 
	signal L_1 : std_logic_vector(n-1 downto 0); 
	signal L_2 : std_logic_vector(n-1 downto 0); 
	signal L_3 : std_logic_vector(n-1 downto 0); 
	signal L_4 : std_logic_vector(n-1 downto 0); 

	signal Fill: std_logic_vector(n-1 downto 0);
	signal R_0 : std_logic_vector(n-1 downto 0); 
	signal R_1 : std_logic_vector(n-1 downto 0); 
	signal R_2 : std_logic_vector(n-1 downto 0); 
	signal R_3 : std_logic_vector(n-1 downto 0); 
	signal R_4 : std_logic_vector(n-1 downto 0); 
	signal CLO: std_logic_vector(31 downto 0);
	signal count : unsigned(4 downto 0) := "11010";

begin

Fill <= (others => ALUOp(0) and A(31));

L_0 <= A(30 downto 0) & '0' when (SHAMT(0) = '1') else A;
L_1 <= L_0(29 downto 0) & "00" when (SHAMT(1) = '1') else L_0;
L_2 <= L_1(27 downto 0) & "0000" when (SHAMT(2) = '1') else L_1;
L_3 <= L_2(23 downto 0) & "00000000" when (SHAMT(3) = '1') else L_2;
L_4 <= L_3(15 downto 0) & "0000000000000000" when (SHAMT(4) = '1') else L_3;

R_0 <= Fill(0) & A(31 downto 1) when (SHAMT(0) = '1') else A;
R_1 <= Fill(1 downto 0) & R_0(31 downto 2) when (SHAMT(1) = '1') else R_0;
R_2 <= Fill(3 downto 0) & R_1(31 downto 4) when (SHAMT(2) = '1') else R_1;
R_3 <= Fill(7 downto 0) & R_2(31 downto 8) when (SHAMT(3) = '1') else R_2;
R_4 <= Fill(15 downto 0) & R_3(31 downto 16) when (SHAMT(4) = '1') else R_3;

process(A, ALUOp)
     begin
      lo: for i in 31 to 0 loop
            if (A(i) = '0') then
                exit lo;
            end if;
            count <= count + "1";
      end loop;
      CLO <= "000000000000000000000000000" & std_logic_vector(count);
end process;


R <= L_4 when (ALUOp(1) = '0') else 
     CLO when (ALUOp = "10") else R_4;

end Behavioral;