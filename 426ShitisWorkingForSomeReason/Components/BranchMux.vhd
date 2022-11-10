----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 06:55:12 PM
-- Design Name: 
-- Module Name: BranchMux - Behavioral
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

entity BranchMux is
  Port (PCPlusFour : in STD_LOGIC_VECTOR(15 downto 0);
        BranchALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        PCSrc  : in STD_LOGIC;
        NextPC   : out STD_LOGIC_VECTOR(15 downto 0));
end BranchMux;

architecture Behavioral of BranchMux is

begin

process (PCPlusFour, PCSrc, BranchALUResult) 
   begin
    if (PCSrc = '0') then
        NextPC <= PCPlusFour;
    elsif (PCSrc = '1') then
        NextPC <= BranchALUResult;
    else
        NextPC <= "HHHHHHHHHHHHHHHH";
    end if;
   
    end process;

end Behavioral;
