----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:28:37 12/13/2016 
-- Design Name: 
-- Module Name:    Timer - Behavioral 
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

entity Timer is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           M : in  STD_LOGIC;
           H : in  STD_LOGIC;
           h1 : out  STD_LOGIC_VECTOR (3 downto 0);
           h0 : out  STD_LOGIC_VECTOR (3 downto 0);
           m1 : out  STD_LOGIC_VECTOR (3 downto 0);
           m0 : out  STD_LOGIC_VECTOR (3 downto 0));
end Timer;

architecture Behavioral of Timer is

	component Counter_0to5 is
		 Port ( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  d : in  STD_LOGIC;
				  x : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component Counter_0to9 is
		 Port ( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  d : in  STD_LOGIC;
				  x : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component Counter_0to23 is
		 Port ( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  d : in  STD_LOGIC;
				  x1 : out  STD_LOGIC_VECTOR (3 downto 0);
				  x0 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component TimerAdjuster is
		Port (  clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  M : in  STD_LOGIC;
				  H : in  STD_LOGIC;
				  s_counter : in  STD_LOGIC_VECTOR (3 downto 0);
				  m_counter : in  STD_LOGIC_VECTOR (3 downto 0);
				  h_pulse : out  STD_LOGIC;
				  m_pulse : out  STD_LOGIC);
	end component;
	
	component FrequencyDivider_1hz is
    Port ( clk : in  STD_LOGIC;
           clkout : out  STD_LOGIC);
	end component;
	
	component FrequencyDivider_5000hz is
    Port ( clk : in  STD_LOGIC;
           clkout : out  STD_LOGIC);
	end component;
	
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
	
	signal f1_s, f1_m: STD_LOGIC_VECTOR (3 downto 0) := "0000";

	signal s1_pulse, m0_pulse, m1_pulse, h_pulse: STD_LOGIC;
	signal clk_1hz, clk_5000hz: STD_LOGIC;
	signal s0_tmp, s1_tmp, m0_tmp, m1_tmp: STD_LOGIC_VECTOR (3 downto 0);

begin

	process (s0_tmp, f1_s) begin
		if (not ((s0_tmp xor f1_s) = "0000") and s0_tmp = "0000") then
			s1_pulse <= '1';
		else 
			s1_pulse <= '0';
		end if;
	end process;
	
	process (m0_tmp, f1_m) begin
		if (not ((m0_tmp xor f1_m) = "0000") and m0_tmp = "0000") then
			m1_pulse <= '1';
		else 
			m1_pulse <= '0';
		end if;
	end process;
	
	process (clk_5000hz, rst, s0_tmp, f1_s, m0_tmp, f1_m) begin
		vector_change(clk_5000hz, rst, s0_tmp, f1_s);
		vector_change(clk_5000hz, rst, m0_tmp, f1_m);
	end process;
	
	divider_1hz: FrequencyDivider_1hz port map (clk, clk_1hz);
	divider_5000hz: FrequencyDivider_5000hz port map (clk, clk_5000hz);
	seconds_units: Counter_0to9 port map (clk_1hz, rst, '1', s0_tmp);
	seconds_tens: Counter_0to5 port map (s1_pulse, rst, '1', s1_tmp);
	minutes_units: Counter_0to9 port map (m0_pulse, rst, '1', m0_tmp);
	minutes_tens: Counter_0to5 port map (m1_pulse, rst, '1', m1_tmp);
	hours: Counter_0to23 port map (h_pulse, rst, '1', h1, h0);
	adjuster: TimerAdjuster port map (clk_5000hz, rst, M, H, s1_tmp, m1_tmp, h_pulse, m0_pulse);
	
	m0 <= m0_tmp;
	m1 <= m1_tmp;

end Behavioral;

