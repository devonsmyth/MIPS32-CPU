library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity control_tb is
end entity;

architecture behav of control_tb is
	component control is
	port (
    	A : in std_logic_vector(31 downto 0); -- mcand
		B : in std_logic_vector(31 downto 0); -- mplier
		clk	 : in	std_logic;
		rst	 : in	std_logic;
		R	 : out	std_logic_vector(63 downto 0);
		done : out	std_logic
    );
end component ;

		signal A :  std_logic_vector(31 downto 0); -- mcand
		signal B :  std_logic_vector(31 downto 0); -- mplier
		signal clk	 : 	std_logic;
		signal rst	 : 	std_logic;
		signal R	 : 	std_logic_vector(63 downto 0);
		signal done : 	std_logic;
begin

	CPOT: control port map (A, B, clk, rst, R, done);

	process  
	begin

	--Test 1--
	         rst <= '1';
			 A <= "11111111111111111111111111111111";
			 B <= "00000000000000000000000000000001";
			 clk <= '0';
			 wait for 10 ns;
			 clk <= '1';
			 wait for 10 ns;
			 rst <= '0';
			 clk <= '0';
			 for i in 0 to 68 loop
			     wait for 10 ns;
			     clk <= '1';
			     wait for 10 ns;
			     clk <= '0';
			 end loop;
			 assert(R = x"00000000FFFFFFFF") report "Test 1 Failed";
	--Test 2-- 
	         rst <= '1';
			 A <= "11111111111111111111111111111111";
			 B <= "11111111111111111111111111111111";
			 clk <= '0';
			 wait for 10 ns;
			 clk <= '1';
			 wait for 10 ns;
			 rst <= '0';
			 clk <= '0';
			 for i in 0 to 68 loop
			     wait for 10 ns;
			     clk <= '1';
			     wait for 10 ns;
			     clk <= '0';
			 end loop;
			 assert(R = x"fffffffe00000001") report "Test 1 Failed";
	--Test 3-- 
	         rst <= '1';
			 A <= "00000000000000000000000000001111";
			 B <= "00000000000000000000000000001111";
			 clk <= '0';
			 wait for 10 ns;
			 clk <= '1';
			 wait for 10 ns;
			 rst <= '0';
			 clk <= '0';
			 for i in 0 to 68 loop
			     wait for 10 ns;
			     clk <= '1';
			     wait for 10 ns;
			     clk <= '0';
			 end loop;
			 assert(R = x"00000000000000E1") report "Test 1 Failed";
	--Test 4-- 
	         rst <= '1';
			 A <= "00000000000000000000000000001111";
			 B <= "00000000000000000000000000000000";
			 clk <= '0';
			 wait for 10 ns;
			 clk <= '1';
			 wait for 10 ns;
			 rst <= '0';
			 clk <= '0';
			 for i in 0 to 68 loop
			     wait for 10 ns;
			     clk <= '1';
			     wait for 10 ns;
			     clk <= '0';
			 end loop;
			 assert(R = x"0000000000000000") report "Test 1 Failed";
    wait;
end process;

end architecture;

