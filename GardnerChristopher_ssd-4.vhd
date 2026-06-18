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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GardnerChristopher_ssd is
Port (
    p1Score : in  STD_LOGIC_VECTOR (3 downto 0);
    p2Score : in  STD_LOGIC_VECTOR (3 downto 0);
    clk : in  STD_LOGIC;
    seg : out STD_LOGIC_VECTOR (6 downto 0);
    cat : out STD_LOGIC_VECTOR (1 downto 0)
    );
end GardnerChristopher_ssd;

architecture Behavioral of GardnerChristopher_ssd is

signal dig1 : STD_LOGIC_VECTOR(6 downto 0);
signal dig2 : STD_LOGIC_VECTOR(6 downto 0);
signal current_dig : STD_LOGIC_VECTOR(6 downto 0);
signal current_cat : STD_LOGIC_VECTOR(1 downto 0) := "10";

begin

with p1Score select
dig1 <=
    "1111110" when "0000",
    "0110000" when "0001",
    "1101101" when "0010",
    "1111001" when "0011",
    "0110011" when "0100",
    "1011011" when "0101",
    "1011111" when "0110",
    "1110000" when "0111",
    "1111111" when "1000",
    "1110011" when "1001",
    "0000000" when others;

with p2Score select
dig2 <=
    "1111110" when "0000",
    "0110000" when "0001",
    "1101101" when "0010",
    "1111001" when "0011",
    "0110011" when "0100",
    "1011011" when "0101",
    "1011111" when "0110",
    "1110000" when "0111",
    "1111111" when "1000",
    "1110011" when "1001",
    "0000000" when others;

process(clk)
begin
    if rising_edge(clk) then
        if current_cat = "10" then
            current_dig <= dig1;
            current_cat <= "01";
        else
            current_dig <= dig2;
            current_cat <= "10";
        end if;
    end if;
end process;

seg <= current_dig;
cat <= not current_cat;

end Behavioral;
