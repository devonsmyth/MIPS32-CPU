library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RSREG IS
   PORT( 
      CLK : IN     std_logic;
      d   : IN     std_logic_vector(31 downto 0);
      load  : IN     std_logic;
      rst : IN     std_logic;
      shift: IN std_logic;
      q   : OUT    std_logic_vector(31 downto 0)
   );

-- Declarations

END RSREG ;

--
ARCHITECTURE behav OF RSREG IS
   signal t: std_logic_vector(31 downto 0);
BEGIN
  process(CLK, rst)
     begin
        if(rst = '1') then
           t <= "00000000000000000000000000000000";
        elsif(CLK'event AND CLK = '1') then
           if(load = '1') then
             t <= d;
           elsif(shift = '1') then
            t <= '0' & t(31 downto 1);
           end if;
        end if;
   end process;
   q <= t;  
end behav;
