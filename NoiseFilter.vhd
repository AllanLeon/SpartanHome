----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:00 12/13/2016 
-- Design Name: 
-- Module Name:    NoiseFilter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NoiseFilter is
    Port ( pbsync : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pulse : out  STD_LOGIC);
end NoiseFilter;

architecture Behavioral of NoiseFilter is

	type state is (s0, s1);
	signal current_state, next_state: state;

begin

	process (clk, rst) begin
		if (rst = '1') then
			current_state <= s0;
		elsif (clk'event and clk = '1') then
			current_state <= next_state;
		end if;
	end process;

	process (current_state, pbsync) begin
		pulse<='0';
		case current_state is
			when s0 =>
				pulse<='0';
				if (pbsync='0') then
					next_state <= s0;
				else
					next_state <= s1;
				end if;
			when s1=>
				pulse<='1';
				if (pbsync='1') then
					next_state <= s1;
				else
					next_state <= s0;
				end if;
		end case;
	end process;

end Behavioral;

