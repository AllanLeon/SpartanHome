----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:25:36 12/13/2016 
-- Design Name: 
-- Module Name:    SpartanHome - Behavioral 
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

entity SpartanHome is
    Port ( clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC;
           M : in  STD_LOGIC;
           H : in  STD_LOGIC;
           E : inout  STD_LOGIC;
           RS : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           SF_CE0 : out  STD_LOGIC;
           DB : out  STD_LOGIC_VECTOR (3 downto 0);
           alarm : out  STD_LOGIC;
           lights : out  STD_LOGIC;
           music : out  STD_LOGIC);
end SpartanHome;

architecture Behavioral of SpartanHome is

component CtrlLogic is
		Port ( H1 : in  STD_LOGIC_VECTOR (3 downto 0);
           H2 : in  STD_LOGIC_VECTOR (3 downto 0);
           M1 : in  STD_LOGIC_VECTOR (3 downto 0);
           M2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           E : inout  STD_LOGIC;
           RS : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           SF_CE0 : out  STD_LOGIC;
           DB : out  STD_LOGIC_VECTOR (3 downto 0);
           alarm : out  STD_LOGIC;
           lights : out  STD_LOGIC;
           music : out  STD_LOGIC);
end component;

component Timer is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           M : in  STD_LOGIC;
           H : in  STD_LOGIC;
           h1 : out  STD_LOGIC_VECTOR (3 downto 0);
           h0 : out  STD_LOGIC_VECTOR (3 downto 0);
           m1 : out  STD_LOGIC_VECTOR (3 downto 0);
           m0 : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal h1, h0, m1, m0: STD_LOGIC_VECTOR (3 downto 0);
signal m_pulse, h_pulse, clk_10hz: STD_LOGIC;

begin
	
	divider_button: FrequencyDivider_10Hz port map (clk, clk_10hz);
	filter_minutes: NoiseFilter port map (M, clk_10hz, rst, m_pulse);
	filter_hours: NoiseFilter port map (H, clk_10hz, rst, h_pulse);
	lcd_display: CtrlLogic port map (h1, h0, m1, m0, clk, rst, E, RS, RW, SF_CE0, DB, alarm, lights, music);
	timer_ctrl: Timer port map (clk, rst, m_pulse, h_pulse, h1, h0, m1, m0);

end Behavioral;

