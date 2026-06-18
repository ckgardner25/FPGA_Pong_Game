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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GardnerChristopher_input_buffer is
Port (
    clk_in : in  STD_LOGIC;
    game_clk_in: in  STD_LOGIC;
    reset : in  STD_LOGIC;
    player1 : in  STD_LOGIC;
    player2 : in  STD_LOGIC;
    p1Buf : out STD_LOGIC;
    p2Buf : out STD_LOGIC;
    reset_out : out STD_LOGIC
    );
end GardnerChristopher_input_buffer;

architecture Behavioral of GardnerChristopher_input_buffer is

begin

process(clk_in, reset)
begin
if rising_edge(clk_in) then
    if reset = '1' then
        p1Buf <= '0';
        p2Buf <= '0';
        reset_out <= '1';
    else
        reset_out <= '0';
        if game_clk_in = '1' then
            p1Buf <= player1;
            p2Buf <= player2;
        end if;

        if player1 = '1' then
            p1Buf <= '1';
        else
            p1Buf <= '0';
        end if;

        if player2 = '1' then
            p2Buf <= '1';
        else
            p2Buf <= '0';
        end if;
    end if;
end if;
end process;

end Behavioral;
