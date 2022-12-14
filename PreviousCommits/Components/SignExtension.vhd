----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 06:29:49 PM
-- Design Name: 
-- Module Name: SignExtension - Behavioral
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

entity SignExtension is
  Port (DataIn : in STD_LOGIC_VECTOR(3 downto 0);
        ExtendedData : out STD_LOGIC_VECTOR(15 downto 0));
end SignExtension;

architecture Behavioral of SignExtension is

begin
process(DataIn) 
begin

    if (DataIn(3) = '1') then
        ExtendedData <= "111111111111" & DataIn; 
    else
        ExtendedData <= "000000000000" & DataIn;

    end if;
-- ExtendedData <= "111111111111" & DataIn WHEN DataIn(3) = '1' ELSE "000000000000" & DataIn;

end process;

end Behavioral;
