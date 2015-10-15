--***************************************************************************************************
 --*	Author: Tsotne Putkaradze, tsotnep@gmail.com
 --*	University: Tallinn Technical University
 --*	Description of Software:
 --*		VHDL code of Parameterizable Linear Feedback Shift Register
 --*
 --* 	copyright: open source

library ieee;
use ieee.std_logic_1164.all;
--LFSR shifts to the left
--so, if feedback==1101, it means: x^3 + x^2 + 1
entity top_level_LFSR is
	generic(
		size : integer                             := 8;	--size of Polynomial
		s    : std_logic_vector(8 - 1 downto 0) := "01101001";	--S_eeds
		f    : std_logic_vector(8 - 1 downto 0) := "11111011"	--F_eedback
	);
	port(
		output : out std_logic_vector(size - 1 downto 0);
		clk    : in  std_logic;
		rst    : in  std_logic
	);
end entity top_level_LFSR;

--! @brief Architecture definition of the LFSR
architecture RTL of top_level_LFSR is
	signal xor_values : std_logic_vector(size downto 0) := (others => '0');
	signal r          : std_logic_vector(size - 1 downto 0); --registers
begin
	output <= r;

	generate_feedback : for I in 0 to size - 1 generate
		XOR_ING_inst : entity work.XOR_ING
			port map(xor_values(I + 1), r(I), f(I), xor_values(I));
	end generate generate_feedback;
	
	-- The logic is following for 4 bit, not that we have 5 bit of xor_values for  that.
	--	xor_values(1) <= ((r(0) and f(0)) xor xor_values(0)); where xor(0) is always 0. 
	--	xor_values(2) <= ((r(1) and f(1)) xor xor_values(1)); first part means:
	--	xor_values(3) <= ((r(2) and f(2)) xor xor_values(2)); if corresponding feedback f is 1
	--	xor_values(4) <= ((r(3) and f(3)) xor xor_values(3)); then it bypasses corresponding r

	shift_reset_p : process(clk, rst)
	begin
		if rst = '1' then
			r <= s;
		elsif rising_edge(clk) then
			r(size - 1)   <= xor_values(size); --last xor_value in 4 bit LFSR's case, xor_values(4)
			r(size - 2 downto 0) <= r(size - 1 downto 1);
		end if;
	end process;
end architecture RTL;
