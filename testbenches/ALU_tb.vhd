library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity;

architecture behav of ALU_tb is
	component ALU is
	port (
    	A, B 	 : in STD_LOGIC_VECTOR(31 downto 0);
    	ALUOp	 : in  STD_LOGIC_VECTOR(3 downto 0);  
    	SHAMT	 : in  STD_LOGIC_VECTOR(4 downto 0);  
    	R	 	 : out STD_LOGIC_VECTOR(31 downto 0);
    	Zero	 : out STD_LOGIC;
    	Overflow : out STD_LOGIC
    );
end component ;

	signal A 	: STD_LOGIC_VECTOR(31 downto 0);
	signal B 	: STD_LOGIC_VECTOR(31 downto 0);
	signal ALUOp   : STD_LOGIC_VECTOR(3 downto 0); 
	signal SHAMT   : STD_LOGIC_VECTOR(4 downto 0); 
	signal R       : STD_LOGIC_VECTOR(31 downto 0);
    signal Zero	   : STD_LOGIC;
    signal Overflow: STD_LOGIC;
begin

	DUT: ALU port map (A, B, ALUOp, SHAMT, R, Zero, Overflow);

	process  
	begin

	--Test 1-- ADD
			 A <= x"80000000";
			 B <= x"80000001";
			 ALUOp <= "0100";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"50000002") report "Test 1 Failed";
	--Test 2-- ADDU
			 A <= x"80000000";
			 B <= x"80000001";
			 ALUOp <= "0101";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"10000002") report "Test 1 Failed";
	--Test 3-- AND
			 A <= x"10000001";
			 B <= x"10000001";
			 ALUOp <= "0000";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"10000001") report "Test 1 Failed";
	--Test 4-- NOR
			 A <= x"00000001";
			 B <= x"00000001";
			 ALUOp <= "0011";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"FFFFFFFE") report "Test 1 Failed";
	--Test 5-- OR
			 A <= x"10000001";
			 B <= x"00000001";
			 ALUOp <= "0001";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"10000001") report "Test 1 Failed";
	--Test 6-- SLT
			 A <= x"80000001";
			 B <= x"00000001";
			 ALUOp <= "1010";
			 wait for 10 ns;
			 assert(R = x"00000001") report "Test 1 Failed";
	--Test 7-- SLTU
			 A <= x"00000001";
			 B <= x"00000001";
			 ALUOp <= "1011";
			 wait for 10 ns;
			 assert(R = x"00000000") report "Test 1 Failed";
	--Test 8-- SLL
			 A <= X"FEDCBA98";
			 SHAMT <= "11000";
			 ALUOp <= "1100";
			 wait for 10 ns;
			 assert(R = X"98000000") report "Test 2 Failed";
	--Test 9-- SRA
			 A <= x"FEDCBA98";
			 ALUOp <= "1111";
			 SHAMT <= "10010";
			 wait for 10 ns;
			 assert(R = x"FFFFFFB7") report "Test 1 Failed";
	--Test 10-- SRL
			 A <= x"FEDCBA98";
			 ALUOp <= "1110";
			 SHAMT <= "11100";
			 wait for 10 ns;
			 assert(R = x"0000000F") report "Test 1 Failed";
	--Test 11-- SUB
			 A <= x"000E0001";
			 B <= x"80000001";
			 ALUOp <= "0110";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"800E0000") report "Test 1 Failed";
	--Test 12-- SUBU
			 A <= x"000E0001";
			 B <= x"80000001";
			 ALUOp <= "0111";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"800E0000") report "Test 1 Failed";
	--Test 13-- XOR
			 A <= x"10000001";
			 B <= x"00000001";
			 ALUOp <= "0010";
			 SHAMT <= "00000";
			 wait for 10 ns;
			 assert(R = x"10000000") report "Test 1 Failed";
    wait;
end process;

end architecture;

