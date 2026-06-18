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

entity GardnerChristopher_MainStructure is
    Port ( clk_in : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           player1 : in  STD_LOGIC;
           player2 : in  STD_LOGIC;
           sw : in  STD_LOGIC; 
           led : out STD_LOGIC_VECTOR (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           cat : out STD_LOGIC_VECTOR (1 downto 0));
end GardnerChristopher_MainStructure;

architecture Behavioral of GardnerChristopher_MainStructure is

component GardnerChristopher_clkdivider is
    Port ( 
        frq : in  STD_LOGIC;
        clk_1Hz : out STD_LOGIC;
        clk_2Hz : out STD_LOGIC;
        sw : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end component;

component GardnerChristopher_clk60Hz is
    Port ( sysclk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component GardnerChristopher_State_Machine is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           player1 : in  STD_LOGIC;
           player2 : in  STD_LOGIC;
           state : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component GardnerChristopher_ssd is
    Port ( p1Score : in STD_LOGIC_VECTOR (3 downto 0);
           p2Score : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           cat : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component GardnerChristopher_led is
    Port ( led_array : in  STD_LOGIC_VECTOR (2 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component GardnerChristopher_4bit_mux is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           count1 : in STD_LOGIC_VECTOR (3 downto 0);
           count2 : in STD_LOGIC_VECTOR (3 downto 0);
           SEL : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component GardnerChristopher_input_buffer is
    Port ( clk_in : in STD_LOGIC;
           game_clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           player1 : in STD_LOGIC;
           player2 : in STD_LOGIC;
           p1Buf : out STD_LOGIC;
           p2Buf : out STD_LOGIC;
           reset_out : out STD_LOGIC);
end component;

component GardnerChristopher_counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           state : in STD_LOGIC_VECTOR (3 downto 0);
           output1 : out STD_LOGIC_VECTOR (3 downto 0);
           output2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal clk_1Hz, clk_2Hz : STD_LOGIC;
signal game_clk : STD_LOGIC;
signal clk60 : STD_LOGIC;
signal clk : STD_LOGIC;
signal leds : STD_LOGIC_VECTOR (2 downto 0);
signal state : STD_LOGIC_VECTOR (3 downto 0);
signal cat_internal : STD_LOGIC_VECTOR (1 downto 0);
signal p1Score : std_logic_vector(3 downto 0);
signal p2Score : std_logic_vector(3 downto 0);
signal p1Buf : std_logic;
signal p2Buf : std_logic;
signal resetbuf : std_logic;

begin

clkdiv: GardnerChristopher_clkdivider port map (frq => clk_in, clk_1Hz => clk_1Hz, clk_2Hz => clk_2Hz, sw => sw, clk_out => game_clk);

clk60Hz: GardnerChristopher_clk60Hz port map (sysclk => clk_in, rst => reset, clk_out => clk60);

state_machine: GardnerChristopher_State_Machine port map (clk => game_clk, reset => resetbuf, player1 => p1Buf, player2 => p2Buf, state => state, led => leds);

ssd: GardnerChristopher_ssd port map (p1Score => p1Score, p2Score => p2Score, clk => clk60, seg => seg, cat => cat_internal);

led_show: GardnerChristopher_led port map (led_array => leds, led => led);

mux_4bit: GardnerChristopher_4bit_mux port map (clk => clk, reset => reset, SEL => clk60, count1 => p1Score, count2 => p2Score, Y => open);

input_buffer: GardnerChristopher_input_buffer port map (clk_in => clk_in, game_clk_in => game_clk, reset => resetbuf, player1 => player1, player2 => player2, p1Buf => p1Buf, p2Buf => p2Buf, reset_out => resetbuf);

counter: GardnerChristopher_counter port map (clk => game_clk, reset => reset, state => state, output1 => p1Score, output2 => p2Score);

cat <= cat_internal;

end Behavioral;
