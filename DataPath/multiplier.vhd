library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multiplier IS
   PORT( 
      Multiplicand : IN std_logic_vector(31 downto 0);
      Multiplier   : IN std_logic_vector(31 downto 0);
      clk  : IN     std_logic;
      rst : IN     std_logic;
      load : IN std_logic;
      shift: IN std_logic;
      enable: std_logic;
      product   : OUT    std_logic_vector(63 downto 0);
      MultiplierShift   : OUT std_logic_vector(31 downto 0)
   );
END multiplier;

ARCHITECTURE behav OF multiplier IS

  component RSReg is
    port ( CLK : IN     std_logic;
      d   : IN     std_logic_vector(31 downto 0);
      load  : IN     std_logic;
      rst : IN     std_logic;
      shift: IN std_logic;
      q   : OUT    std_logic_vector(31 downto 0)
      );
  end component; 

  component LSReg is
    port (  
      CLK : IN     std_logic;
      d   : IN     std_logic_vector(63 downto 0);
      load  : IN     std_logic;
      rst : IN     std_logic;
      shift: IN std_logic;
      q   : OUT    std_logic_vector(63 downto 0)
      );
  end component;

  component adder64 is
  port (
    A     : in std_logic_vector(63 downto 0);
    B     : in std_logic_vector(63 downto 0);
    S     : out std_logic_vector(63 downto 0)
    );
  end component;

  component flipflop is
    port ( 
      CLK : IN     std_logic;
      D   : IN     std_logic_vector(63 downto 0);
      EN  : IN     std_logic;
      RST : IN     std_logic;
      Q   : OUT    std_logic_vector(63 downto 0)
      );
  end component;

  constant n    : Integer :=64;
  signal sub: std_logic;
  signal multiplicandI: std_logic_vector(63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";
  signal multiplicandO: std_logic_vector(63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";
  signal op1: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  signal productO: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  signal adderO: std_logic_vector(63 downto 0);
  signal carry: std_logic;

BEGIN
    sub <= '0';
 multiplicandI <= "00000000000000000000000000000000" & Multiplicand;
 mcand: LSReg port map (clk => clk, d=> multiplicandI, load=>load, rst=>rst , shift=>shift, q=>multiplicandO);

 mplier: RSReg port map (clk => clk, d=>Multiplier, load=>load, rst=>rst , shift=>shift, q=>MultiplierShift);

 alu: adder64 port map ( A=>productO, B=>multiplicandO, S=>adderO);

 reg: flipflop port map (CLK => clk, D=> adderO, EN=> enable, RST=> rst, Q=>productO);

 product <= productO;
end behav;