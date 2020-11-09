LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY flipflop IS
   PORT( 
      CLK : IN     std_logic;
      D   : IN     std_logic_vector(63 downto 0) := x"0000000000000000";
      EN  : IN     std_logic;
      RST : IN     std_logic;
      Q   : OUT    std_logic_vector(63 downto 0) := x"0000000000000000"
   );

-- Declarations

END flipflop ;

--
ARCHITECTURE flipflop OF flipflop IS
BEGIN
     CLKD : process(CLK, RST)
     begin
        if(RST = '1') then
           Q <= "0000000000000000000000000000000000000000000000000000000000000000";
        elsif(rising_edge(CLK)) then
           if(EN = '1') then
              Q <= D;
           end if;
        end if;
     end process CLKD;
END flipflop;
