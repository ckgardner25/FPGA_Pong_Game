----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2025 09:27:17 PM
-- Design Name: 
-- Module Name: n - Behavioral
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

entity GardnerChristopher_clk60Hz is
    Port ( sysclk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end GardnerChristopher_clk60Hz;

architecture Behavioral of GardnerChristopher_clk60Hz is
signal temporal: STD_LOGIC;
signal counter : integer range 0 to 100000 := 0; 

begin

frequency_divider: process (rst, sysclk)
begin
if (rst = '1') then
    temporal <= '0';
    counter <= 0;
elsif rising_edge(sysclk) then
    if (counter = 100000) then
        temporal <= NOT(temporal);
        counter <= 0;
    else
        counter <= counter + 1;
        end if;
    end if;
end process;

clk_out <= temporal;
end Behavioral;
