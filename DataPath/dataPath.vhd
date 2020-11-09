LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY dataPath IS
   PORT( 
      MemoryDataIn : in std_logic_vector(31 downto 0);
      clk      : IN     std_logic;
      rst      : IN     std_logic;
      PCWrite  : IN     std_logic;
      IorD     : IN     std_logic;
      MemtoReg : IN     std_logic_vector(1 downto 0);
      IRWrite  : IN     std_logic;
      RegDst   : IN     std_logic;
      RegWrite : IN     std_logic;
      ALUSrcA  : IN     std_logic;
      ALUSrcB  : IN     std_logic_vector(1 downto 0);
      ALUOp    : IN     std_logic_vector(3 downto 0);
      PCSource : IN     std_logic_vector(1 downto 0);
      multrst  : IN     std_logic := '0';
      I31    : out    std_logic_vector(5 downto 0);
      I5     : out    std_logic_vector(5 downto 0);
      zero    : out    std_logic;
      done    : out    std_logic;
      MemoryAddress: out std_logic_vector(31 downto 0);
      MemoryDataOut: out std_logic_vector(31 downto 0) := x"00000000"
   );
END dataPath ;

ARCHITECTURE behav OF dataPath IS

  component pcReg is
    port( 
      clk : in     std_logic;
      rst : in     std_logic;
      write : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component twoMux32 is
    port( 
      clk : in     std_logic; --
      rst : in     std_logic;
      sel : in     std_logic;
      d1   : in     std_logic_vector(31 downto 0);
      d2   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component CPU_memory is
    port( 
      Clk      : IN     std_logic; --
      MemWrite : IN     std_logic;
      addr     : IN     std_logic_vector (31 DOWNTO 0);
      dataIn   : IN     std_logic_vector (31 DOWNTO 0);
      dataOut  : OUT    std_logic_vector (31 DOWNTO 0)
   );
  end component; 

  component instructionReg is
    port( 
      clk : in     std_logic;
      rst : in     std_logic;
      write : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q31  : out    std_logic_vector(5 downto 0) := "000000";
      q25  : out    std_logic_vector(4 downto 0) := "00000";
      q20  : out    std_logic_vector(4 downto 0) := "00000";
      q15  : out    std_logic_vector(15 downto 0) := x"0000"
   );
  end component; 

  component memDataReg IS
   port( 
      clk : in     std_logic;
      rst : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component;

  component twoMux5 IS
   port( 
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in     std_logic;
      d1   : in     std_logic_vector(4 downto 0);
      d2   : in     std_logic_vector(4 downto 0);
      q  : out    std_logic_vector(4 downto 0) := "00000"
   );
  end component; 

  component registers IS
   port( 
      clk : in     std_logic;
      rst : in     std_logic;
      regwrite : in std_logic;
      opcode: in     std_logic_vector(5 downto 0);
      r1  : in     std_logic_vector(4 downto 0) := "00000";
      r2  : in     std_logic_vector(4 downto 0) := "00000";
      wr  : in     std_logic_vector(4 downto 0);
      wd  : in     std_logic_vector(31 downto 0);
      q1  : out    std_logic_vector(31 downto 0) := x"00000000";
      q2  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component signExtend IS
   port( 
      A : in  STD_LOGIC_VECTOR(15 downto 0); 
      op : in  STD_LOGIC_VECTOR(5 downto 0);
    R : out  STD_LOGIC_VECTOR(31 downto 0):= x"00000000"
   );
  end component; 

  component abReg IS
   port( 
      clk : in     std_logic;
      rst : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component shiftLeft32 IS
   port( 
      d   : IN     std_logic_vector(31 downto 0);
      q   : OUT    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component fourMux32 IS
   port( 
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in      std_logic_vector(1 downto 0);
      d1   : in     std_logic_vector(31 downto 0);
      d2   : in     std_logic_vector(31 downto 0);
      d3   : in     std_logic_vector(31 downto 0);
      d4   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
   );
  end component; 

  component shiftLeft26 IS
   port( 
      d   : IN     std_logic_vector(25 downto 0);
      q   : OUT    std_logic_vector(27 downto 0) := x"0000000"
   );
  end component; 

  component ALU IS
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
  end component; 

  component threeMux32 IS
    Port (
      clk : in     std_logic;
      rst : in     std_logic;
      sel : in      std_logic_vector(1 downto 0);
      d1   : in     std_logic_vector(31 downto 0);
      d2   : in     std_logic_vector(31 downto 0);
      d3   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
    );
  end component; 

  component control IS
    Port (
        A : in std_logic_vector(31 downto 0); -- mcand
    B : in std_logic_vector(31 downto 0); -- mplier
    clk  : in std_logic;
    rst  : in std_logic;
    R  : out  std_logic_vector(63 downto 0);
    done : out  std_logic
    );
    end component; 
    
   component multReg IS
   PORT( 
      clk : in     std_logic;
      rst : in     std_logic;
      en : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
    );
    END component;
  

  --SIGNALS--
  signal pcIn: std_logic_vector(31 downto 0);
  signal pcOut: std_logic_vector(31 downto 0);
  signal aluOut: std_logic_vector(31 downto 0);
  signal mux1Out: std_logic_vector(31 downto 0);
  signal MDRout : std_logic_vector(31 downto 0);
  signal Q31: std_logic_vector(5 downto 0);
  signal Q25: std_logic_vector(4 downto 0);
  signal Q20: std_logic_vector(4 downto 0);
  signal Q15: std_logic_vector(15 downto 0);
  signal I25: std_logic_vector(25 downto 0);
  signal wReg: std_logic_vector(4 downto 0);
  signal wrData: std_logic_vector(31 downto 0);
  signal Ain: std_logic_vector(31 downto 0);
  signal Bin: std_logic_vector(31 downto 0);
  signal Aout: std_logic_vector(31 downto 0);
  signal Bout: std_logic_vector(31 downto 0);
  signal seOut: std_logic_vector(31 downto 0);
  signal sl32Out: std_logic_vector(31 downto 0);
  signal alu1: std_logic_vector(31 downto 0);
  signal alu2: std_logic_vector(31 downto 0);
  signal SHAMT: std_logic_vector(4 downto 0);
  signal sl26Out: std_logic_vector(27 downto 0);
  signal pcAndShift: std_logic_vector(31 downto 0);
  signal aluResult: std_logic_vector(31 downto 0);
  signal fullMult: std_logic_vector(63 downto 0);
  signal multLow: std_logic_vector(31 downto 0);
  signal multHigh: std_logic_vector(31 downto 0);
  signal lowReg: std_logic_vector(31 downto 0);
  signal highReg: std_logic_vector(31 downto 0);
  signal ofl:   std_logic;
  signal dones:   std_logic;

BEGIN
  MemoryAddress <= mux1Out;
  MemoryDataOut <= Bout;
  I25 <= Q25 & Q20 & Q15;
  pcAndShift <= pcOut(31 downto 28) & sl26Out; 
  multHigh<= fullMult(63 downto 32);
  multLow<= fullMult(31 downto 0);
  I5 <= Q15(5 downto 0);
  SHAMT <= Q15(10 downto 6);
  I31 <= Q31;
  done <= dones;
  

  PC    : pcReg port map (clk=>clk, rst=>rst, write=>PCWrite, d=>pcIn, q=>pcOut);
  mux1  : twoMux32 port map (clk=>clk, rst=>rst, sel=>IorD, d1=>pcOut, d2=>aluOut, q=>mux1Out);
  IReg  : instructionReg port map (clk=>clk, rst=>rst, write=>IRWrite, d=>MemoryDataIn, q31=>Q31, q25=>Q25, q20=>Q20, q15=>Q15);
  MDReg : memDataReg port map (clk=>clk, rst=>rst, d=>MemoryDataIn, q=>MDRout);
  mux2  : twoMux5 port map (clk=>clk, rst=>rst, sel=>RegDst, d1=>Q20, d2=>Q15(15 downto 11), q=>wReg);
  mux3  : fourMux32 port map (clk=>clk, rst=>rst, sel=>MemtoReg, d1=>aluOut, d2=>MDRout, d3=>lowReg, d4=>mux1Out, q=>wrData);
  regs  : registers port map (clk=>clk, rst=>rst, regwrite=>RegWrite, opcode=>Q31, r1=>Q25, r2=>Q20, wr=>wReg, wd=>wrData, q1=>Ain, q2=>Bin);
  SE    : signExtend port map (A=>Q15, op=>Q31, R=>seOut);
  Areg  : abReg port map (clk=>clk, rst=>rst, d=>Ain, q=>Aout);
  Breg  : abReg port map (clk=>clk, rst=>rst, d=>Bin, q=>Bout);
  sl32  : shiftLeft32 port map (d=>seOut, q=>sl32Out);
  mux4  : twoMux32 port map (clk=>'0', rst=>rst, sel=>ALUSrcA, d1=>pcOut, d2=>Aout, q=>alu1);
  mux5  : fourMux32 port map (clk=>clk, rst=>rst, sel=>ALUSrcB, d1=>Bout, d2=>x"00000004", d3=>seOut, d4=>sl32Out, q=>alu2);
  sl26  : shiftLeft26 port map (d=>I25, q=>sl26Out);
  alunit: ALU port map (A=>alu1, B=>alu2, ALUOp=>ALUOp, SHAMT=>SHAMT, FUNCT=>Q15(5 downto 0), opcode=>Q31, R=>aluResult, Zero=>zero, Overflow=>ofl);
  mux6  : threeMux32 port map (clk=>clk, rst=>rst, sel=>PCSource, d1=>aluResult, d2=>aluOut, d3=>pcAndShift, q=>pcIn);
  aluReg : memDataReg port map (clk=>clk, rst=>rst, d=>aluResult, q=>aluOut);
  mutli  : control port map (A=>Aout, B=>Bout, clk=>clk, rst=>multrst, R=>fullMult, done=>dones);
  HReg : multreg port map (clk=>clk, rst=>rst, en=>dones, d=>multHigh, q=>highReg);
  LReg : multreg port map (clk=>clk, rst=>rst, en=>dones, d=>multLow, q=>lowReg);

end behav;
