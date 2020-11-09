library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity twoMux5_tb is 
end twoMux5_tb;

architecture Behavioral of twoMux5_tb is

component twoMux5 is  
    Port (
	  clk : in     std_logic;
      rst : in     std_logic;
      sel : in     std_logic;
      d1   : in     std_logic_vector(4 downto 0);
      d2   : in     std_logic_vector(4 downto 0);
      q  : out    std_logic_vector(4 downto 0) := "00000"
    );
end component;

	signal 	  clk :      std_logic;
	signal    rst :      std_logic;
	signal    sel :      std_logic;
	signal    d1  :    std_logic_vector(4 downto 0);
	signal    d2  :    std_logic_vector(4 downto 0);
	signal    q  :    std_logic_vector(4 downto 0);

begin
REG: twoMux5 port map (clk,rst,sel,d1,d2,q);

	process
	begin
		--Test 1--	
		  clk <= '0';
		        rst <= '0';	
		        sel <= '1';	
				d1 <= "00000";
				d2 <= "11111";
			    
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= '0';	
				d1 <= "00000";
				d2 <= "11111";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= '0';	
				d1 <= "00000";
				d2 <= "11111";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= '1';	
				d1 <= "00000";
				d2 <= "11111";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
	wait;
	end process;

end Behavioral;