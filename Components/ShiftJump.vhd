----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 12:24:19 AM
-- Design Name: 
-- Module Name: ShiftJump - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftJump is
  Port (ShiftAddress : in STD_LOGIC_VECTOR(11 downto 0);
        ShiftOut    : out STD_LOGIC_VECTOR(12 downto 0));
end ShiftJump;

architecture Behavioral of ShiftJump is

begin

--ShiftOut <= ShiftAddress & '0'; --Move bits over one and concatenate with 0 on LSB.
ShiftOut <= '0' & ShiftAddress; -- Shouldn't need to shift.
end Behavioral;
