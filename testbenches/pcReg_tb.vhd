library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity pcReg_tb is 
end pcReg_tb;

architecture Behavioral of pcReg_tb is

component pcReg is  
    Port (
	  clk : in     std_logic;
      rst : in     std_logic;
      write : in     std_logic;
      d   : in     std_logic_vector(31 downto 0);
      q  : out    std_logic_vector(31 downto 0) := x"00000000"
    );
end component;

	signal 	  clk :      std_logic;
	signal    rst :      std_logic;
	signal    write : std_logic;
	signal    d  :    std_logic_vector(31 downto 0);
	signal    q  :    std_logic_vector(31 downto 0);

begin
REG: pcReg port map (clk,rst,write,d,q);

	process
	begin
		--Test 1--	
		  clk <= '0';
		        rst <= '0';			
				write <= '1';
				d <= x"00000001";
			    
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
				write <= '0';
				d <= x"0FF00001";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				d <= x"00000000";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				write <= '1';
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
	wait;
	end process;

end Behavioral;