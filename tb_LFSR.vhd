library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_LFSR is
end entity tb_LFSR;

architecture RTL of tb_LFSR is
	constant t    : time := 10 ns;
	signal clk    : std_logic;
	signal output : std_logic_vector(3 downto 0);
	signal rst    : std_logic;

begin
	top_level_inst : entity work.top_level
		--		generic map(
		--			s0 => s0,
		--			s1 => s1,
		--			s2 => s2,
		--			s3 => s3,
		--			f0 => f0,
		--			f1 => f1,
		--			f2 => f2,
		--			f3 => f3
		--		)
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
		wait for 10 * t;
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
