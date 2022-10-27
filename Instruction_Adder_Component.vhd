----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2022 04:12:25 PM
-- Design Name: 
-- Module Name: Instruction_Adder_Component - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Adder_Component is
  Port (InstIn : in STD_LOGIC_VECTOR(15 downto 0);
        InstOut : out STD_LOGIC_VECTOR(15 downto 0));
end Instruction_Adder_Component;

architecture Behavioral of Instruction_Adder_Component is

begin
process(InstIn)
    begin
        InstOut <= InstIn + x"0002"; --Incrementing by 2 bytes in hex.
        
 end process;  
    
end Behavioral;
