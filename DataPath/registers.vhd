LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY registers IS
   PORT( 
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
END registers;

ARCHITECTURE behav OF registers IS

  type arr is array(0 to 31) of std_logic_vector(31 downto 0);  
  signal regs: arr;

BEGIN

     process(clk, rst, r1, r2, wr, wd)
     begin
        if(rst = '1') then
           q1 <= x"00000000";
           q2 <= x"00000000";
           regs(0) <= x"00000000";
           regs(1) <= x"00000000";
           regs(2) <= x"00000000";
           regs(3) <= x"00000000";
           regs(4) <= x"00000000";
           regs(5) <= x"00000000";
           regs(6) <= x"00000000";
           regs(7) <= x"00000000";
           regs(8) <= x"00000000";
           regs(9) <= x"00000000";
           regs(10) <= x"00000000";
           regs(11) <= x"00000000";
           regs(12) <= x"00000000";
           regs(13) <= x"00000000";
           regs(14) <= x"00000000";
           regs(15) <= x"00000000";
           regs(16) <= x"00000000";
           regs(17) <= x"00000000";
           regs(18) <= x"00000000";
           regs(19) <= x"00000000";
           regs(20) <= x"00000000";
           regs(21) <= x"00000000";
           regs(22) <= x"00000000";
           regs(23) <= x"00000000";
           regs(24) <= x"00000000";
           regs(25) <= x"00000000";
           regs(26) <= x"00000000";
           regs(27) <= x"00000000";
           regs(28) <= x"00000000";
           regs(29) <= x"00000000";
           regs(30) <= x"00000000";
           regs(31) <= x"00000000";
        else 
           q1 <= regs(to_integer(unsigned(r1)));
           q2 <= regs(to_integer(unsigned(r2)));
           if((regwrite = '1') and (rising_edge(clk))) then
              if(opcode = "000001") then
                    regs(31) <= wd;
              else
                     regs(to_integer(unsigned(wr))) <= wd;
                     if(opcode = "100001") then
                        regs(to_integer(unsigned(wr))) <= "0000000000000000" &(wd(15 downto 0));
                     end if;
                     if(opcode = "100000") then
                        regs(to_integer(unsigned(wr))) <= "000000000000000000000000" &(wd(7 downto 0));
                     end if;
                     if(wr = r1) then
                        q1 <= wd;
                     end if;
                     if(wr = r2) then
                        q2 <= wd;
                     end if;
               end if;
           end if;
        end if;
     end process;

END behav;




--LIBRARY ieee;
--USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all;

--ENTITY registers IS
--   PORT( 
--      clk : in     std_logic;
--      rst : in     std_logic;
--      regwrite : in std_logic;
--      r1  : in     std_logic_vector(4 downto 0) := "00000";
--      r2  : in     std_logic_vector(4 downto 0) := "00001";
--      wr  : in     std_logic_vector(4 downto 0);
--      wd  : in     std_logic_vector(31 downto 0);
--      q1  : out    std_logic_vector(31 downto 0) := x"00000000";
--      q2  : out    std_logic_vector(31 downto 0) := x"00000000"
--   );
--END registers;

--ARCHITECTURE behav OF registers IS

--  type arr is array(0 to 31) of std_logic_vector(31 downto 0);  
--  signal regs: arr;

--BEGIN

--     process(clk, rst)
--     begin
--        if(rst = '1') then
--           q1 <= x"00000000";
--           q2 <= x"00000000";
--        elsif(rising_edge(clk)) then
--           if(regwrite = '1') then
--                 regs(to_integer(unsigned(wr))) <= wd;
--                 if(wr = r1) then
--                    q1 <= wd;
--                 end if;
--                 if(wr = r2) then
--                    q2 <= wd;
--                 end if;
--           else
--             q1 <= regs(to_integer(unsigned(r1)));
--             q2 <= regs(to_integer(unsigned(r2)));
--           end if;
--        end if;
--     end process;

--END behav;