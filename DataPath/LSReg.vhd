library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LSREG IS
   PORT( 
      CLK : IN     std_logic;
      d   : IN     std_logic_vector(63 downto 0);
      load  : IN     std_logic;
      rst : IN     std_logic;
      shift: IN std_logic;
      q   : OUT    std_logic_vector(63 downto 0) := x"0000000000000000"
   );

-- Declarations

END LSREG ;

--
ARCHITECTURE behav OF LSREG IS
signal t: std_logic_vector(63 downto 0);
BEGIN
  process(CLK, rst)
    
     begin
        if(rst = '1') then
           t <= "0000000000000000000000000000000000000000000000000000000000000000";
        elsif(CLK'event AND CLK = '1') then
           if(load = '1') then
             t <= d;
           elsif(shift = '1') then
              t <= t(62 downto 0) & '0';
           end if;
        end if;
        
     end process;
      q <= t;
end behav;
