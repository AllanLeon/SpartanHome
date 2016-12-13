----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:52:56 12/13/2016 
-- Design Name: 
-- Module Name:    Counter_0to5 - Behavioral 
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

entity Counter_0to5 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           d : in  STD_LOGIC;
           x : out  STD_LOGIC_VECTOR (3 downto 0));
end Counter_0to5;

architecture Behavioral of Counter_0to5 is

	type state is (q0, q1, q2, q3, q4, q5);
	signal current_state, next_state: state;

begin

	process (clk, rst) begin
		if (rst = '1') then
			current_state <= q0;
		elsif (clk'event and clk = '1') then
			current_state <= next_state;
		end if;
	end process;
	
	process (d, current_state) begin
		case (current_state) is
			when q0 =>
				x <= "0000";
				if (d = '1') then
					next_state <= q1;
				elsif (d = '0') then
					next_state <= q0;
				end if;
				
			when q1 =>
				x <= "0001";
				if (d = '1') then
					next_state <= q2;
				elsif (d = '0') then
					next_state <= q1;
				end if;
				
			when q2 =>
				x <= "0010";
				if (d = '1') then
					next_state <= q3;
				elsif (d = '0') then
					next_state <= q2;
				end if;
				
			when q3 =>
				x <= "0011";
				if (d = '1') then
					next_state <= q4;
				elsif (d = '0') then
					next_state <= q3;
				end if;
			
			when q4 =>
				x <= "0100";
				if (d = '1') then
					next_state <= q5;
				elsif (d = '0') then
					next_state <= q4;
				end if;
				
			when q5 =>
				x <= "0101";
				if (d = '1') then
					next_state <= q0;
				elsif (d = '0') then
					next_state <= q5;
				end if;
		end case;
	end process;

end Behavioral;

