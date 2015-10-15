-- feedback logic
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity XOR_ING is
	port(
		xor_out : out STD_LOGIC;
		r_in    : in  STD_LOGIC;
		f_in    : in  STD_LOGIC;
		xor_in  : in  STD_LOGIC
	);
end entity XOR_ING;

architecture RTL of XOR_ING is
begin
	xor_out <= ((r_in and f_in) xor xor_in);
end architecture RTL;
