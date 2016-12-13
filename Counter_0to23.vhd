----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:59:27 12/13/2016 
-- Design Name: 
-- Module Name:    Counter_0to23 - Behavioral 
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

entity Counter_0to23 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           d : in  STD_LOGIC;
           x1 : out  STD_LOGIC_VECTOR (3 downto 0);
           x0 : out  STD_LOGIC_VECTOR (3 downto 0));
end Counter_0to23;

architecture Behavioral of Counter_0to23 is

	type state is (q0, q1, q2, q3, q4, q5, q6, q7, q8, q9,
						q10, q11, q12, q13, q14, q15, q16, q17, q18, q19,
						q20, q21, q22, q23);
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
				x1 <= "0000";
				x0 <= "0000";
				if (d = '1') then
					next_state <= q1;
				elsif (d = '0') then
					next_state <= q0;
				end if;
				
			when q1 =>
				x1 <= "0000";
				x0 <= "0001";
				if (d = '1') then
					next_state <= q2;
				elsif (d = '0') then
					next_state <= q1;
				end if;
				
			when q2 =>
				x1 <= "0000";
				x0 <= "0010";
				if (d = '1') then
					next_state <= q3;
				elsif (d = '0') then
					next_state <= q2;
				end if;
				
			when q3 =>
				x1 <= "0000";
				x0 <= "0011";
				if (d = '1') then
					next_state <= q4;
				elsif (d = '0') then
					next_state <= q3;
				end if;
			
			when q4 =>
				x1 <= "0000";
				x0 <= "0100";
				if (d = '1') then
					next_state <= q5;
				elsif (d = '0') then
					next_state <= q4;
				end if;
				
			when q5 =>
				x1 <= "0000";
				x0 <= "0101";
				if (d = '1') then
					next_state <= q6;
				elsif (d = '0') then
					next_state <= q5;
				end if;
			
			when q6 =>
				x1 <= "0000";
				x0 <= "0110";
				if (d = '1') then
					next_state <= q7;
				elsif (d = '0') then
					next_state <= q6;
				end if;
			
			when q7 =>
				x1 <= "0000";
				x0 <= "0111";
				if (d = '1') then
					next_state <= q8;
				elsif (d = '0') then
					next_state <= q7;
				end if;
			
			when q8 =>
				x1 <= "0000";
				x0 <= "1000";
				if (d = '1') then
					next_state <= q9;
				elsif (d = '0') then
					next_state <= q8;
				end if;
			
			when q9 =>
				x1 <= "0000";
				x0 <= "1001";
				if (d = '1') then
					next_state <= q10;
				elsif (d = '0') then
					next_state <= q9;
				end if;
				
			when q10 =>
				x1 <= "0001";
				x0 <= "0000";
				if (d = '1') then
					next_state <= q11;
				elsif (d = '0') then
					next_state <= q10;
				end if;
				
			when q11 =>
				x1 <= "0001";
				x0 <= "0001";
				if (d = '1') then
					next_state <= q12;
				elsif (d = '0') then
					next_state <= q11;
				end if;
				
			when q12 =>
				x1 <= "0001";
				x0 <= "0010";
				if (d = '1') then
					next_state <= q13;
				elsif (d = '0') then
					next_state <= q12;
				end if;
				
			when q13 =>
				x1 <= "0001";
				x0 <= "0011";
				if (d = '1') then
					next_state <= q14;
				elsif (d = '0') then
					next_state <= q13;
				end if;
			
			when q14 =>
				x1 <= "0001";
				x0 <= "0100";
				if (d = '1') then
					next_state <= q15;
				elsif (d = '0') then
					next_state <= q14;
				end if;
				
			when q15 =>
				x1 <= "0001";
				x0 <= "0101";
				if (d = '1') then
					next_state <= q16;
				elsif (d = '0') then
					next_state <= q15;
				end if;
			
			when q16 =>
				x1 <= "0001";
				x0 <= "0110";
				if (d = '1') then
					next_state <= q17;
				elsif (d = '0') then
					next_state <= q16;
				end if;
			
			when q17 =>
				x1 <= "0001";
				x0 <= "0111";
				if (d = '1') then
					next_state <= q18;
				elsif (d = '0') then
					next_state <= q17;
				end if;
			
			when q18 =>
				x1 <= "0001";
				x0 <= "1000";
				if (d = '1') then
					next_state <= q19;
				elsif (d = '0') then
					next_state <= q18;
				end if;
			
			when q19 =>
				x1 <= "0001";
				x0 <= "1001";
				if (d = '1') then
					next_state <= q20;
				elsif (d = '0') then
					next_state <= q19;
				end if;
				
			when q20 =>
				x1 <= "0010";
				x0 <= "0000";
				if (d = '1') then
					next_state <= q21;
				elsif (d = '0') then
					next_state <= q20;
				end if;
				
			when q21 =>
				x1 <= "0010";
				x0 <= "0001";
				if (d = '1') then
					next_state <= q22;
				elsif (d = '0') then
					next_state <= q21;
				end if;
				
			when q22 =>
				x1 <= "0010";
				x0 <= "0010";
				if (d = '1') then
					next_state <= q23;
				elsif (d = '0') then
					next_state <= q22;
				end if;
				
			when q23 =>
				x1 <= "0010";
				x0 <= "0011";
				if (d = '1') then
					next_state <= q0;
				elsif (d = '0') then
					next_state <= q23;
				end if;
		end case;
	end process;


end Behavioral;

