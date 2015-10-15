library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
	generic(
		--S_eed
		s0 : std_logic := '1';
		s1 : std_logic := '0';
		s2 : std_logic := '1';
		s3 : std_logic := '0';

		--F_eedback
		f0 : std_logic := '1';
		f1 : std_logic := '1';
		f2 : std_logic := '1';
		f3 : std_logic := '1'
	);
	port(
		output : out std_logic_vector(3 downto 0);
		clk    : in  std_logic;
		rst    : in  std_logic
	);
end entity top_level;

architecture RTL of top_level is
	signal xor3, xor2, xor1 : STD_LOGIC;
	signal r0, r1, r2, r3   : STD_LOGIC;
begin
	xor1 <= r1 xor r0 when (f1 = '1' and f0 = '1')
		else r1 when f1 = '1'
		else r0 when f0 = '1'
		else '0';                       --f1=f0=0
	xor2 <= r2 xor xor1 when f2 = '1' else xor1;
	xor3 <= r3 xor xor2 when f3 = '1' else xor2;

	output <= r3 & r2 & r1 & r0;

	process(clk, rst)
	begin
		if rst = '1' then
			r0 <= s0;
			r1 <= s1;
			r2 <= s2;
			r3 <= s3;
		elsif rising_edge(clk) then
			r3 <= xor3;
			r2 <= r3;
			r1 <= r2;
			r0 <= r1;
		end if;
	end process;

end architecture RTL;
