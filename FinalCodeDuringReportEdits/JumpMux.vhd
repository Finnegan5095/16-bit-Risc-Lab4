----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 07:13:55 PM
-- Design Name: 
-- Module Name: JumpMux - Behavioral
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

entity JumpMux is
  Port (Jump : in STD_LOGIC;
        ShiftJumpSignalOut : in std_logic_vector(12 downto 0);
        PCMostSig : in std_logic_vector(2 downto 0);
        --JumpAddressIn : in STD_LOGIC_VECTOR(15 downto 0);
        BranchMuxIn : in STD_LOGIC_VECTOR(15 downto 0);
        PCOut   : out STD_LOGIC_VECTOR(15 downto 0));
end JumpMux;

architecture Behavioral of JumpMux is
signal JumpAddressIn : std_logic_vector(15 downto 0);
begin
JumpAddressIn <= PCMostSig & ShiftJumpSignalOut;
process (JumpAddressIn, BranchMuxIn) 
--Variable TempInv : std_logic_vector(15 downto 0);
   begin
    if (Jump = '0') then
        PCOut <= BranchMuxIn;
    elsif (Jump = '1') then
        PCOut <= JumpAddressIn;
    else
        --PCOut <= "HHHHHHHHHHHHHHHH";
        PCOut <= "0000000000000000";
    end if;
    end process;
    
end Behavioral;
