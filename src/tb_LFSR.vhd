--***************************************************************************************************
 --*	Author: Tsotne Putkaradze, tsotnep@gmail.com
 --*	University: Tallinn Technical University
 --*	Description of Software:
 --*		VHDL code for simulating Parameterizable Linear Feedback Shift Register
 --*
 --* 	copyright: open source
 
library ieee;
use ieee.std_logic_1164.all;

entity tb_LFSR is
end entity tb_LFSR;

architecture RTL of tb_LFSR is
	constant t    : time := 10 ns;
	signal clk    : std_logic;
	signal output : std_logic_vector(8-1 downto 0);
	signal rst    : std_logic;

begin
top_level_LFSR_inst : entity work.top_level_LFSR
--	generic map(
--		size => size,
--		s    => s,
--		f    => f
--	)
	port map(
		output => output,
		clk    => clk,
		rst    => rst
	);
	srimul : process
	begin
		rst <= '1';
		wait for t;
		rst <= '0';
		wait for 32 * t;
		
		wait;
	end process;

	clock_driver : process
	begin
		clk <= '0';
		wait for t / 2;
		clk <= '1';
		wait for t / 2;
	end process clock_driver;

end architecture RTL;

