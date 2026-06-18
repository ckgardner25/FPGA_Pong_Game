----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2025 02:30:00 PM
-- Design Name: 
-- Module Name: GardnerChristopher_State_Machine - Behavioral
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

entity GardnerChristopher_State_Machine is
Port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    player1 : in STD_LOGIC;
    player2 : in STD_LOGIC;
    state : out STD_LOGIC_VECTOR (3 downto 0);
    led : out STD_LOGIC_VECTOR (2 downto 0)
);
end GardnerChristopher_State_Machine;

architecture Behavioral of GardnerChristopher_State_Machine is

signal current_state : STD_LOGIC_VECTOR(3 downto 0) := "0001";
signal pos : unsigned(2 downto 0) := (others => '0');
signal p1_latched : STD_LOGIC := '0';
signal p2_latched : STD_LOGIC := '0';

begin

process(clk, reset)
begin
    if reset = '1' then
        current_state <= "0001";
        pos           <= (others => '0');
        p1_latched    <= '0';
        p2_latched    <= '0';
    elsif rising_edge(clk) then
        if player1 = '1' then
            p1_latched <= '1';
        end if;
        if player2 = '1' then
            p2_latched <= '1';
        end if;

        case current_state is

            when "0001" =>
                if pos < 7 then
                    pos <= pos + 1;
                else
                    current_state <= "0010";
                end if;

            when "0010" =>
                if p1_latched = '1' then
                    current_state <= "0011";
                    p1_latched <= '0';
                else
                    pos <= (others => '0');
                    current_state <= "0001";
                end if;

            when "0011" =>
                if pos > 0 then
                    pos <= pos - 1;
                else
                    current_state <= "0100";
                end if;

            when "0100" =>
                if p2_latched = '1' then
                    current_state <= "0001";
                    p2_latched <= '0';
                else
                    pos <= "111";
                    current_state <= "0011";
                end if;

            when others =>
                current_state <= "0001";
                pos <= (others => '0');
                p1_latched <= '0';
                p2_latched <= '0';

        end case;
    end if;
end process;

state <= current_state;
led   <= std_logic_vector(pos);

end Behavioral;
