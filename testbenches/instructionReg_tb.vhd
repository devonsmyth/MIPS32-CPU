library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity instructionReg_tb is 
end instructionReg_tb;

architecture Behavioral of instructionReg_tb is

component instructionReg is  
    Port (
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

	signal 	  clk :      std_logic;
	signal    rst :      std_logic;
	signal    write : std_logic;
	signal    d  :    std_logic_vector(31 downto 0);
	signal    q31  :    std_logic_vector(5 downto 0);
	signal    q25  :    std_logic_vector(4 downto 0);
	signal    q20  :    std_logic_vector(4 downto 0);
	signal    q15  :    std_logic_vector(15 downto 0);

begin
REG: instructionReg port map (clk,rst,write,d,q31,q25,q20,q15);

	process
	begin
		--Test 1--	
		  clk <= '0';
		        rst <= '0';			
				write <= '1';
				d <= x"FFFFFFFF";
			    
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
				write <= '0';
				d <= x"00000000";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
				d <= x"11111111";
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