library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control is

	port(
		A : in std_logic_vector(31 downto 0); -- mcand
		B : in std_logic_vector(31 downto 0); -- mplier
		clk	 : in	std_logic;
		rst	 : in	std_logic;
		R	 : out	std_logic_vector(63 downto 0);
		done : out	std_logic
	);
	
end entity;

architecture rtl of control is

	component multiplier is
    port ( 
      Multiplicand : IN std_logic_vector(31 downto 0);
      Multiplier   : IN std_logic_vector(31 downto 0);
      clk  : IN     std_logic;
      rst : IN     std_logic;
      load : IN std_logic;
      shift: IN std_logic;
      enable: std_logic;
      product   : OUT    std_logic_vector(63 downto 0);
      MultiplierShift   : OUT std_logic_vector(31 downto 0)
      );
 	end component;

	type state_type is (s0, s1, s2, s3, s4);	
	signal state   : state_type;
	signal nextstate: state_type;
	signal load	   : std_logic;
	signal shift   : std_logic;
	signal mplierO : std_logic_vector(31 downto 0);
	signal enable      : std_logic;
	signal count : std_logic_vector(4 downto 0) := "00000";
	signal one   : std_logic_vector(4 downto 0);

begin

	DP: multiplier port map (Multiplicand => A, Multiplier => B, clk => clk, rst => rst, load => load, shift => shift, enable => enable, product => R, MultiplierShift => mplierO);
	process (clk, rst)
	begin
		if rst = '1' then
			nextstate <= s0;
		elsif (CLK'event AND CLK = '1') then
			case state is
				when s0=>
					nextstate <= s1;
				when s1=>
				    nextstate <= s2;
				when s2=>
					nextstate <= s3;
				when s3=>
					count <= std_logic_vector(unsigned(count) + unsigned(one));
					if (count = "11111") then
						nextstate <= s4;
					else
						nextstate <= s2;
					end if;
				when s4 =>
					
			end case;
		end if;
		state <= nextstate;
	end process;
	one <= "00001";
	-- Output depends solely on the current state
	process (state)
	begin
	
		case state is
			when s0 =>
				load <= '0';
				shift <= '0';
				enable <= '0';
				done <= '0';
			when s1 =>
				load <= '1';
				shift <= '0';
				enable <= '0';
				done <= '0';
			when s2 =>
				if mplierO(0) = '1' then
						enable <= '1';
				else	
				        enable <= '0';
				end if;
				load <= '0';
				shift <= '0';
				done <= '0';
			when s3 =>
				load <= '0';
				enable <= '0';
				shift <= '1';
				done <= '0';
			when s4 =>
				done <= '1';
				load <= '0';
				shift <= '0';
				enable <= '0';
		end case;
	end process;
	
end rtl;
