--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:41:31 12/13/2016
-- Design Name:   
-- Module Name:   D:/UPB/8vo Semestre/Electronica Digital/Xilinx/ProyectoFinal/SpartanHome/test_timer_adjuster.vhd
-- Project Name:  SpartanHome
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TimerAdjuster
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_timer_adjuster IS
END test_timer_adjuster;
 
ARCHITECTURE behavior OF test_timer_adjuster IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TimerAdjuster
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         M : IN  std_logic;
         H : IN  std_logic;
         s_counter : IN  std_logic_vector(3 downto 0);
         m_counter : IN  std_logic_vector(3 downto 0);
         h_pulse : OUT  std_logic;
         m_pulse : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal M : std_logic := '0';
   signal H : std_logic := '0';
   signal s_counter : std_logic_vector(3 downto 0) := (others => '0');
   signal m_counter : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal h_pulse : std_logic;
   signal m_pulse : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TimerAdjuster PORT MAP (
          clk => clk,
          rst => rst,
          M => M,
          H => H,
          s_counter => s_counter,
          m_counter => m_counter,
          h_pulse => h_pulse,
          m_pulse => m_pulse
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	seconds_process :process
	begin
		s_counter <= "0000";
		wait for clk_period/2 * 4;
		s_counter <= "0001";
		wait for clk_period/2 * 4;
		s_counter <= "0010";
		wait for clk_period/2 * 4;
		s_counter <= "0011";
		wait for clk_period/2 * 4;
		s_counter <= "0100";
		wait for clk_period/2 * 4;
		s_counter <= "0101";
		wait for clk_period/2 * 4;
	end process;
	
	minutes_process :process
	begin
		m_counter <= "0000";
		wait for clk_period/2 * 8;
		m_counter <= "0001";
		wait for clk_period/2 * 8;
		m_counter <= "0010";
		wait for clk_period/2 * 8;
		m_counter <= "0011";
		wait for clk_period/2 * 8;
		m_counter <= "0100";
		wait for clk_period/2 * 8;
		m_counter <= "0101";
		wait for clk_period/2 * 8;
	end process;
	
	mh_process :process
	begin
		M <= '0';
		H <= '0';
		wait for clk_period/2 * 100;
		M <= '1';
		H <= '0';
		wait for clk_period/2 * 8;
		M <= '1';
		H <= '0';
		wait for clk_period/2 * 10;
		M <= '0';
		H <= '1';
		wait for clk_period/2 * 8;
		M <= '0';
		H <= '0';
		wait for clk_period/2 * 10;
		M <= '1';
		H <= '1';
		wait for clk_period/2 * 8;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
