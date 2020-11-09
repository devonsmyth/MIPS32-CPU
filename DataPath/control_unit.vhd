library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
port (
  Reset: in std_logic;
  Clock: in std_logic;
  MemoryDataIn : in std_logic_vector(31 downto 0);
  MemoryAdress: out std_logic_vector(31 downto 0);
  MemoryDataOut: out std_logic_vector(31 downto 0):= x"00000000";
  MemWrite     : out std_logic
 );
end control_unit;

architecture Behavioral of control_unit is

  component dataPath is
    port( 
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
      MemoryDataOut: out std_logic_vector(31 downto 0):= x"00000000"
   );
  end component; 

  component ALUcontrol is
    port( 
    ovr    : in std_logic_vector(3 downto 0);
    opcode : in std_logic_vector(5 downto 0);
    funct  : in std_logic_vector(5 downto 0);
    ALUOp  : out std_logic_vector(3 downto 0)
   );
  end component; 

    --SIGNALS--
    type state_type is (s0, s1, s2, s3, s4,s5,s6,s7,s8,s9,s10,s11,s12);  
    signal state   : state_type;
    signal nextstate: state_type;
    signal opcode: std_logic_vector(5 downto 0);
    signal funct: std_logic_vector(5 downto 0);
    signal PCWrite  :  std_logic;
    signal PCWriteCond  :  std_logic;
    signal PCWriteOVR  :  std_logic;
    signal IorD     :  std_logic;
    signal MemtoReg :  std_logic_vector(1 downto 0);
    signal IRWrite  :  std_logic;
    signal RegDst   :  std_logic;
    signal RegWrite :  std_logic;
    signal ALUSrcA  :  std_logic;
    signal ALUSrcB  : std_logic_vector(1 downto 0);
    signal ALUOp    : std_logic_vector(3 downto 0);
    signal PCSource : std_logic_vector(1 downto 0);
    signal zero     : std_logic := '0';
    signal done     : std_logic := '0';
    signal multrst     : std_logic := '0';

begin
  DP: dataPath port map (MemoryDataIn=>MemoryDataIn, clk=>Clock, rst=>Reset, PCWrite=>PCWriteOVR, IorD=>IorD, MemtoReg=>MemtoReg, IRWrite=>IRWrite, RegDst=>RegDst, RegWrite=>RegWrite, ALUSrcA=>ALUSrcA, ALUSrcB=>ALUSrcB, ALUOp=>ALUOp, PCSource=>PCSource, multrst=>multrst, I31=>opcode, I5=>funct, zero=>zero, done=>done, MemoryAddress=>MemoryAdress, MemoryDataOut=>MemoryDataOut);

  PCWriteOVR  <= (PCWriteCond and not(zero)) or PCWrite;


  process (Clock, Reset)
  begin
    if Reset = '1' then
      nextstate <= s0;
    elsif (Clock'event AND Clock = '1') then
      case state is
        when s0=>
            nextstate <= s1;
        when s1=>
            if((opcode = "000000") and (funct="011000")) then --mult
              nextstate <= s10;
            elsif ((opcode = "000000") and ((funct="010010")or(funct ="010000"))) then --mflo mfhi
              nextstate <= s11;
            elsif(opcode = "000010" or ((opcode="000000") and (funct="001000"))) then --J or jr
              nextstate <= s12;
            elsif((opcode = "000000")or(opcode = "001000")or(opcode="001101")or(opcode="001010")or(opcode="001111")or(opcode="011100"))then -- R-type,ADDI,ORI,slti,lui,clo
              nextstate <= s6;
            elsif((opcode="100011")or(opcode="101011")or(opcode="100001")or(opcode="100000")) then  --LW or SW or LHorLB
              nextstate <= s2;
            elsif((opcode = "000001") or (opcode = "000101")) then --BLTZAL or BNE
              nextstate <= s8;
            end if;
        when s2=>
            if((opcode = "100011") or (opcode = "100001")or(opcode="100000")) then
                nextstate <= s3;
            elsif(opcode = "101011") then
                nextstate<= s5;
            end if;
        when s3=>
            nextstate <= s4;
        when s4 =>
            nextstate <= s0;
        when s5 =>
            nextstate <= s9;
        when s6 =>  -- R-type, Immediate
            nextstate <= s7;
        when s7 =>
            nextstate <= s0;
        when s8 =>
            nextstate <= s0;
        when s9 => --stall til dataIn is instruction again
            nextstate <= s0;
        when s10 => 
            if done = '1' then
              nextstate <= s0;
            else
              nextstate <= s10;
            end if;
        when s11 =>
            nextstate <= s0;
        when s12 =>
            nextstate <= s0;
      end case;
    end if;
    state <= nextstate;
  end process;

  -- Output depends solely on the current state
  process (state)
  begin
    case state is --IF
      when s0 =>
        PCWrite  <= '1';
        PCWriteCond <= '0'; --for branch
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '1';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '0'; 
        ALUSrcB  <= "01";
        ALUOp    <= "0101";
        PCSource <= "00";
      when s1 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '0'; 
        ALUSrcB  <= "11";
        PCSource <= "00";
        multrst <= '1';
      when s2 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '1';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "10";
        PCSource <= "00";
      when s3 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '1';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "10";
        PCSource <= "00";
      when s4 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "01";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '1';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "10";
        PCSource <= "00";
      when s5 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '1';
        MemWrite <= '1';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "10";
        PCSource <= "00";
      when s6 =>
        ALUSrcA  <= '1'; 
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegWrite <= '0';
        if(opcode = "000000") then --R type
            ALUSrcB  <= "00";
            RegDst   <= '1';
            case funct is
					when "100001" => ALUOp <= "0101";  --addu
					when "100100" => ALUOp <= "0000";  --and
					when "100010" => ALUOp <= "0110";  --sub
					when "000011" => ALUOp <= "1111";  --sra
					when "000100" => ALUOp <= "1100";  --sllv
					when "000000" => ALUOp <= "1100";  --sll
					when others => ALUOp <= "0101";
			end case;
        else
            case opcode is
                when "001000" =>  --addi
                 ALUOp <= "0101";
                when "001101" =>  --ori
                 ALUOp <= "0001";
                when "001010" =>  --slti
                 ALUOp <= "1010";
                when "001111" =>  --lui
                 ALUOp <= "1100";
                 when "011100" =>  --clo
                 ALUOp <= "1110";
                when others => ALUOp <= "0101";
             end case;
           if(opcode="011100") then
            ALUSrcB  <= "00"; --Immediate source
            RegDst   <= '1';
           else 
            ALUSrcB  <= "10"; --Immediate source
            RegDst   <= '0';
           end if;
        end if;
        PCSource <= "01";
      when s7 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        if((opcode = "000000") or (opcode="011100")) then --R type
            RegDst   <= '1';
        else
            RegDst   <= '0'; --Immediate
        end if;
        RegWrite <= '1';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "00";
        PCSource <= "00";
      when s8 =>
        if (opcode = "000001")then
            ALUOp <= "1010";
        else
            ALUOp <= "0110";
        end if;
        PCWriteCond <= '1'; --for branch
        if ((opcode = "000001"))then 
            PCWrite  <= '1';
        else
            PCWrite  <= '0';
        end if;
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "11";
        IRWrite  <= '0';
        RegDst   <= '0';
        if ((opcode = "000001"))then 
            RegWrite <= '1';
        else
            RegWrite <= '0';
        end if;
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "00";
        PCSource <= "01";
      when s9 =>
        PCWrite  <= '0';
        PCWriteCond <= '0'; --for branch
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '0'; 
        ALUSrcB  <= "01";
        ALUOp    <= "0101";
        PCSource <= "00";
      when s10 =>
        multrst <= '0';
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '0'; 
        ALUSrcB  <= "11";
        PCSource <= "00";
      when s11 => --(funct="010010")or(funct ="010000")
        multrst <= '0';
        ALUOp    <= "0101";
        PCWriteCond <= '0'; 
        PCWrite  <= '0';
        IorD     <= '0';
        MemWrite <= '0';
        if funct="010010" then
            MemtoReg <= "10";
        else
            MemtoReg <= "11";
        end if;
        IRWrite  <= '0';
        RegDst   <= '1';
        RegWrite <= '1';
        ALUSrcA  <= '0'; 
        ALUSrcB  <= "11";
        PCSource <= "00";
      when s12 =>
        ALUOp    <= "0101";
        PCWriteCond <= '0'; --for branch
        PCWrite  <= '1';
        IorD     <= '0';
        MemWrite <= '0';
        MemtoReg <= "00";
        IRWrite  <= '0';
        RegDst   <= '0';
        RegWrite <= '0';
        ALUSrcA  <= '1'; 
        ALUSrcB  <= "11";
        if(opcode = "000010") then   
            PCSource <= "10";
        else
            PCSource <= "00";
        end if;
        multrst <= '1';
        
    end case;
  end process;
  
end Behavioral;