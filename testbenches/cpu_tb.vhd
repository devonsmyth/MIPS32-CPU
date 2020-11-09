library ieee;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity cpu_tb is
	port (
    	reset: in std_logic;
		clock: in std_logic;
    );
end cpu_tb;

architecture behav of cpu_tb is
	component control_unit is
		port (
	    	Reset: in std_logic;
			Clock: in std_logic;
			MemoryDataIn : in std_logic_vector(31 downto 0);
			MemoryAdress: out std_logic_vector(31 downto 0);
			MemoryDataOut: out std_logic_vector(31 downto 0);
			MemWrite     : out std_logic
	    );
	end component ;

	component CPU_memory is
		port (
	    	Clk      : IN     std_logic;
		    MemWrite : IN     std_logic;
		    addr     : IN     std_logic_vector (31 DOWNTO 0);
		    dataIn   : IN     std_logic_vector (31 DOWNTO 0);
		    dataOut  : OUT    std_logic_vector (31 DOWNTO 0)
	    );
	end component ;

		signal MemoryDataIn  :  std_logic_vector(31 downto 0); 
		signal MemoryAdress :  std_logic_vector(31 downto 0); 
		signal MemoryDataOut : 	std_logic_vector(63 downto 0);
		signal MemWrite : 	std_logic;
begin

	U_0: control_unit port map (reset, clock, MemoryDataIn, MemoryAdress, MemoryDataOut, MemWrite);

	U_1: CPU_memory port map (clock, MemWrite, MemoryAdress, MemoryDataIn, MemoryDataOut);


end architecture;

