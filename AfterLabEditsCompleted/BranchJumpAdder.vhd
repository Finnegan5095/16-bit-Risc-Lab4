----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 12:46:54 AM
-- Design Name: 
-- Module Name: BranchJumpAdder - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BranchJumpAdder is
   Port (ShiftInput : in STD_LOGIC_VECTOR(15 downto 0);
         PCAddress : in STD_LOGIC_VECTOR(15 downto 0);
         ALUResult  : out STD_LOGIC_VECTOR(15 downto 0));
end BranchJumpAdder;

architecture Behavioral of BranchJumpAdder is

begin

    process(PCAddress)
    begin
         ALUResult <= ShiftInput + PCAddress; --Adding the two 16-bit addresses.
    end process;

end Behavioral;
