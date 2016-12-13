----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:31 12/13/2016 
-- Design Name: 
-- Module Name:    FrequencyDivider_10Hz - Behavioral 
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

entity FrequencyDivider_10Hz is
    Port ( clk : in  STD_LOGIC;
           clkout : out  STD_LOGIC);
end FrequencyDivider_10Hz;

architecture Behavioral of FrequencyDivider_10Hz is

	constant max: integer := 50000000 / 10;
   constant half: integer := max / 2;
   SIGNAL count: integer range 0 to max;
	
begin

	process (clk)
	begin
		if (clk'event and clk = '1') then
		 if count < max - 1 then 
				count <= count + 1;
			else 
				count <= 0;
		 end if;
		 if count < half then 
			 clkout <= '1';
			else 
			 clkout <= '0';
		 end if;
	  end if;
	end process;

end Behavioral;

