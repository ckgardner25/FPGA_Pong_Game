----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2025 01:25:22 AM
-- Design Name: 
-- Module Name: GardnerChristopher_clk2Hz - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GardnerChristopher_clk2Hz is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end GardnerChristopher_clk2Hz;

architecture Behavioral of GardnerChristopher_clk2Hz is
    signal temporal: STD_LOGIC;
    signal counter : integer range 0 to 3000000 := 0;
begin

    frequency_divider: process (reset, clk) begin
    if (reset = '1') then
        temporal <= '0';
        counter <= 0;
    elsif rising_edge(clk) then
        if (counter = 3000000) then
            temporal <= NOT(temporal);
            counter <= 0;
    else
        counter <= counter + 1;
      end if;
    end if;
end process;

clk_out <= temporal;
end Behavioral;
