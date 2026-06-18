----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2025 01:30:22 AM
-- Design Name: 
-- Module Name: GardnerChristopher_mux - Behavioral
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

entity GardnerChristopher_mux is
    Port ( sw : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           X : out STD_LOGIC);
end GardnerChristopher_mux;

architecture Behavioral of GardnerChristopher_mux is

begin
   X <= A when (sw = '1') else B;

end Behavioral;
