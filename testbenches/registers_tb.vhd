library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity registers_tb is 
end registers_tb;

architecture Behavioral of registers_tb is

component registers is  
    Port (
	   	clk : in     std_logic;
	    rst : in     std_logic;
	    regwrite : in std_logic;
	    r1  : in     std_logic_vector(4 downto 0);
	    r2  : in     std_logic_vector(4 downto 0);
	    wr  : in     std_logic_vector(4 downto 0);
	    wd  : in     std_logic_vector(31 downto 0);
	    q1  : out    std_logic_vector(31 downto 0) := x"00000000";
	    q2  : out    std_logic_vector(31 downto 0) := x"00000000"
    );
end component;

	signal 	  clk :      std_logic;
	signal    rst :      std_logic;
	signal    regwrite : std_logic;
	signal    r1  :      std_logic_vector(4 downto 0);
	signal    r2  :    std_logic_vector(4 downto 0);
	signal    wr  :     std_logic_vector(4 downto 0);
	signal    wd  :      std_logic_vector(31 downto 0);
	signal    q1  :    std_logic_vector(31 downto 0);
	signal    q2  :     std_logic_vector(31 downto 0);

begin
REG: registers port map (clk,rst,regwrite,r1,r2,wr,wd,q1,q2);

	process
	begin
		--Test 1--	
		  clk <= '0';
		        rst <= '0';			
				wr <= "00000";
				regwrite <= '1';
				wd <= x"00000001";
				r1 <= "00000";
				r2 <= "00001";
			    
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
			    wr <= "00001";
			    wd <= x"00000008";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
			     wr <= "00000";
			    wd <= x"000000FF";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
			     r2 <= "00000";
			wait for 10 ns;      
            clk <= '1';
			wait for 10 ns;
			clk <= '0';
	wait;
	end process;

end Behavioral;