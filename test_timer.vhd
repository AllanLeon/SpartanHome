--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:51:14 12/13/2016
-- Design Name:   
-- Module Name:   D:/UPB/8vo Semestre/Electronica Digital/Xilinx/ProyectoFinal/SpartanHome/test_timer.vhd
-- Project Name:  SpartanHome
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Timer
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
 
ENTITY test_timer IS
END test_timer;
 
ARCHITECTURE behavior OF test_timer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Timer
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         M : IN  std_logic;
         H : IN  std_logic;
         h1 : OUT  std_logic_vector(3 downto 0);
         h0 : OUT  std_logic_vector(3 downto 0);
         m1 : OUT  std_logic_vector(3 downto 0);
         m0 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal M : std_logic := '0';
   signal H : std_logic := '0';

 	--Outputs
   signal h1 : std_logic_vector(3 downto 0);
   signal h0 : std_logic_vector(3 downto 0);
   signal m1 : std_logic_vector(3 downto 0);
   signal m0 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Timer PORT MAP (
          clk => clk,
          rst => rst,
          M => M,
          H => H,
          h1 => h1,
          h0 => h0,
          m1 => m1,
          m0 => m0
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	m_process :process
	begin
		M <= '0';
		wait for clk_period/2 * 100;
		M <= '1';
		wait for clk_period/2 * 4;
	end process;
	
	h_process :process
	begin
		H <= '0';
		wait for clk_period/2 * 200;
		H <= '1';
		wait for clk_period/2 * 4;
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
