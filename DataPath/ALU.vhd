library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
    Port (
    	A, B 	 : in STD_LOGIC_VECTOR(31 downto 0);
    	ALUOp	 : in  STD_LOGIC_VECTOR(3 downto 0);  
    	SHAMT	 : in  STD_LOGIC_VECTOR(4 downto 0);  
    	FUNCT    : in  STD_LOGIC_VECTOR(5 downto 0); 
    	opcode   : in  STD_LOGIC_VECTOR(5 downto 0);  
    	R	 	 : out STD_LOGIC_VECTOR(31 downto 0):= x"00000000";
    	Zero	 : out STD_LOGIC := '0';
    	Overflow : out STD_LOGIC
    );
end ALU ;

architecture Behavioral of ALU is
	component comparator is
           GENERIC(
				n : Integer :=32
			); 
  			Port (
			    A_31, B_31, S_31, CO: in  STD_LOGIC;
			    ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);  
			    R		  : out  STD_LOGIC_VECTOR(31 downto 0)
			);
	end component ;
	component Arith_Unit is
	   PORT( 
      A       : IN     std_logic_vector (31 DOWNTO 0);
      B       : IN     std_logic_vector (31 DOWNTO 0);
      C_op    : IN     std_logic_vector (1 DOWNTO 0);
      CO      : OUT    std_logic;
      OFL     : OUT    std_logic;
      S       : OUT    std_logic_vector (31 DOWNTO 0):= x"00000000";
      Z       : OUT    std_logic
   );
	end component ;
	component logical is
        GENERIC(
		n : Integer :=32
		); 
	   port (
		  A, B     : in std_logic_vector(n-1 downto 0);
		  Op        : in std_logic_vector(1 downto 0);
		  R     : out std_logic_vector(n-1 downto 0):= x"00000000"
	   );
	end component;
	component shifter is
          GENERIC(
				n : Integer :=32
			); 
  
		    Port (
			    A 		: in  STD_LOGIC_VECTOR(n-1 downto 0);  
			    SHAMT   : in  STD_LOGIC_VECTOR(4 downto 0);  
			    ALUOp   : in  STD_LOGIC_VECTOR(1 downto 0);  
			    R		: out  STD_LOGIC_VECTOR(n-1 downto 0):= x"00000000"
		    );
	end component ;

	constant n 		: Integer :=32;
	signal shiftInput: STD_LOGIC_VECTOR(n-1 downto 0);
	signal LogicalR : STD_LOGIC_VECTOR(n-1 downto 0);
	signal ArithR   : STD_LOGIC_VECTOR(n-1 downto 0);
	signal CompR    : STD_LOGIC_VECTOR(n-1 downto 0);
	signal compB    : STD_LOGIC;
	signal ShiftR   : STD_LOGIC_VECTOR(n-1 downto 0):= x"00000000";
	signal SHAMTfinal : std_logic_vector(4 downto 0);
	signal COs		: std_logic;
	signal zeroArith: std_logic;

begin

shiftInput <= B when ((FUNCT = "000000")or(FUNCT = "000011")or(opcode = "001111")) else A;

shamtFinal <= A(4 downto 0) when (FUNCT = "000100") else
              "10000" when (opcode = "001111") else SHAMT;
compB <= '0' when (opcode = "000001") else B(31);   
Zero <= '0' when ((opcode = "000001")and(CompR(0)='1')) else zeroArith;

Block1: logical
		generic map (
			n => n
		)
		port map (A, B, ALUOp(1 downto 0), LogicalR);

Block2: Arith_Unit port map (A => A, B=> B, C_op => ALUOp(1 downto 0), CO=> COs, S => ArithR, OFL => Overflow , Z=> zeroArith);


Block3: comparator
		generic map (
			n => n
		)
		port map (A(31), compB, ArithR(31), COs, ALUOp(1 downto 0), CompR);

Block4: shifter
		generic map (
			n => n
		)
		port map (shiftInput, SHAMTfinal, ALUOp(1 downto 0), ShiftR);

R <= A when (funct = "001000") else
     LogicalR when (ALUOp(3 downto 2) = "00") else
	 ArithR when (ALUOp(3 downto 2) = "01") else
	 CompR  when (ALUOp(3 downto 2) = "10") else
	 ShiftR when (ALUOp(3 downto 2) = "11") else
	 "00000000000000000000000000000000";

end Behavioral;