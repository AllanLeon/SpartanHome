----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:47 12/14/2016 
-- Design Name: 
-- Module Name:    BeepCtrl - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BeepCtrl is
    Port ( clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           d : in  STD_LOGIC;
           beep : out  STD_LOGIC);
end BeepCtrl;

architecture Behavioral of BeepCtrl is

	type state is (s0, s1);
	signal current_state, next_state: state;
	signal count: integer range 0 to 10;

begin

	process (clk, rst) begin
		if (rst = '1') then
			current_state <= s0;
		elsif (clk'event and clk = '1') then
			current_state <= next_state;
		end if;
	end process;

	process (current_state, d) begin
		beep<='0';
		case current_state is
			when s0 =>
				beep<='0';
				if (count <= 10) then
					if (d='0') then
						next_state <= s0;
					else
						count <= count + 1;
						next_state <= s1;
					end if;
				end if;
			when s1=>
				beep<='1';
				if (d='0') then
					next_state <= s1;
				else
					next_state <= s0;
				end if;
		end case;
	end process;

end Behavioral;

