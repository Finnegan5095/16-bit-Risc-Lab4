----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 12:28:59 AM
-- Design Name: 
-- Module Name: ShiftBranch - Behavioral
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

entity ShiftBranch is
  Port (SignExtend : in STD_LOGIC_VECTOR(15 downto 0);
        ShiftOutBranch    : out STD_LOGIC_VECTOR(15 downto 0));
end ShiftBranch;

architecture Behavioral of ShiftBranch is

begin

ShiftOutBranch <= SignExtend(14 downto 0) & '0'; --Move bits over one and concatenate with 0 on LSB.

end Behavioral;
