library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity threeMux32_tb is 
end threeMux32_tb;

architecture Behavioral of threeMux32_tb is

component threeMux32 is  
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

	signal 	  clk :      std_logic;
	signal    rst :      std_logic;
	signal    sel :      std_logic_vector(1 downto 0);
	signal    d1  :    std_logic_vector(31 downto 0);
	signal    d2  :    std_logic_vector(31 downto 0);
	signal    d3  :    std_logic_vector(31 downto 0);
	signal    q  :    std_logic_vector(31 downto 0);

begin
REG: threeMux32 port map (clk,rst,sel,d1,d2,d3,q);

	process
	begin
		--Test 1--	
		  clk <= '0';
		        rst <= '0';	
		        sel <= "00";	
				d1 <= x"00000000";
				d2 <= x"11111111";
				d3 <= x"22222222";
			    
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= "01";	
				d1 <= x"00000000";
				d2 <= x"11111111";
				d3 <= x"22222222";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= "10";
				d1 <= x"00000000";
				d2 <= x"11111111";
				d3 <= x"22222222";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				sel <= "00";
				d1 <= x"00000000";
				d2 <= x"11111111";
				d3 <= x"22222222";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
	wait;
	end process;

end Behavioral;