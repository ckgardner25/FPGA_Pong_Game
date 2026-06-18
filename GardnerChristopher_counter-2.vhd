----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2025 09:27:17 PM
-- Design Name: 
-- Module Name: GardnerChristopher_MainStructure - Behavioral
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

entity GardnerChristopher_counter is
Port (
    clk : in  STD_LOGIC;
    reset : in  STD_LOGIC;
    state : in  STD_LOGIC_VECTOR (3 downto 0);
    output1 : out STD_LOGIC_VECTOR (3 downto 0);
    output2 : out STD_LOGIC_VECTOR (3 downto 0)
);
end GardnerChristopher_counter;

architecture Behavioral of GardnerChristopher_counter is

signal player1_score : unsigned(3 downto 0) := (others => '0');
signal player2_score : unsigned(3 downto 0) := (others => '0');
signal prev_state : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

process(clk, reset)
begin
    if reset = '1' then
        player1_score <= (others => '0');
        player2_score <= (others => '0');
        prev_state    <= "0000";
    elsif rising_edge(clk) then
        if state = "0010" and prev_state /= "0010" then
            player1_score <= player1_score + 1;
        elsif state = "0100" and prev_state /= "0100" then
            player2_score <= player2_score + 1;
        end if;
        prev_state <= state;
    end if;
end process;

output1 <= std_logic_vector(player1_score);
output2 <= std_logic_vector(player2_score);

end Behavioral;
