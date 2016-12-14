----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:25:47 12/13/2016 
-- Design Name: 
-- Module Name:    TimerAdjuster - Behavioral 
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

entity TimerAdjuster is
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           M : in  STD_LOGIC;
           H : in  STD_LOGIC;
			  s_counter : in  STD_LOGIC_VECTOR (3 downto 0);
           m_counter : in  STD_LOGIC_VECTOR (3 downto 0);
           h_pulse : out  STD_LOGIC;
           m_pulse : out  STD_LOGIC);
end TimerAdjuster;

architecture Behavioral of TimerAdjuster is

	procedure vector_change(signal clk, rst: in STD_LOGIC;
									signal x: in STD_LOGIC_VECTOR (3 downto 0);
									signal f1_x: out STD_LOGIC_VECTOR (3 downto 0))
	is begin
		if (rst = '1') then
			f1_x <= (others => '0');
		elsif (clk'event and clk = '1') then
			f1_x <= x;
		end if;
	end vector_change;
	
	signal f1_s, f1_m: STD_LOGIC_VECTOR (3 downto 0):= "0000";
	signal tmp_mc, tmp_mp, tmp_hc, tmp_hp: STD_LOGIC;

begin
	process (clk, rst, s_counter) begin
		if (rst = '1') then
			tmp_mc <= '0';
		elsif (clk'event and clk = '1') then
			if (not ((s_counter xor f1_s) = "0000") and s_counter = "0000") then
				tmp_mc <= '1';
			else
				tmp_mc <= '0';
			end if;
		end if;
	end process;
	
	process (clk, rst, m_counter) begin
		if (rst = '1') then
			tmp_hc <= '0';
		elsif (clk'event and clk = '1') then
			if (not ((m_counter xor f1_m) = "0000") and m_counter = "0000") then
				tmp_hc <= '1';
			else
				tmp_hc <= '0';
			end if;
		end if;
	end process;
	
	process (clk, rst, M, H) begin
		if (rst = '1') then
			tmp_mp <= '0';
			tmp_hp <= '0';
		elsif (clk'event and clk = '1') then
			tmp_mp <= M;
			tmp_hp <= H;
		end if;
	end process;
	
	process (clk, rst, s_counter, f1_s, m_counter, f1_m) begin
		vector_change(clk, rst, s_counter, f1_s);
		vector_change(clk, rst, m_counter, f1_m);
	end process;
	
	m_pulse <= tmp_mp or tmp_mc;
	h_pulse <= tmp_hp or tmp_hc;

end Behavioral;

