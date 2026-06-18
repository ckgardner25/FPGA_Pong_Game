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

entity GardnerChristopher_clkdivider is
    Port ( frq : in STD_LOGIC;
           clk_1Hz : out STD_LOGIC;
           clk_2Hz : out STD_LOGIC;
           sw : in std_logic;
           clk_out : out STD_LOGIC);
end GardnerChristopher_clkdivider;

architecture Behavioral of GardnerChristopher_clkdivider is

component GardnerChristopher_clk1Hz is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component GardnerChristopher_clk2Hz is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component GardnerChristopher_mux is
    Port ( sw : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           X : out STD_LOGIC);
end component;

signal clk1 : std_logic;
signal clk2 : std_logic;
signal reset : std_logic := '0'; 

begin

clk1Hz : GardnerChristopher_clk1Hz port map (clk => frq, reset => reset, clk_out => clk1);

clk2Hz : GardnerChristopher_clk2Hz port map (clk => frq, reset => reset, clk_out => clk2);

mux: GardnerChristopher_mux port map(sw => sw, A => clk1, B => clk2, X => clk_out);


end Behavioral;
