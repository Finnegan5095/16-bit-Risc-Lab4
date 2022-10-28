----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 06:52:22 PM
-- Design Name: 
-- Module Name: MemToRegMux - Behavioral
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

entity MemToRegMux is
  Port (ReadDataMem : in STD_LOGIC_VECTOR(15 downto 0);
        ALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        MemToReg  : in STD_LOGIC;
        MemToRegMuxOut   : out STD_LOGIC_VECTOR(15 downto 0));
end MemToRegMux;

architecture Behavioral of MemToRegMux is

begin
    -- MemToRegMuxOut gets ReadDataMem when MemToReg control is low and ALUResult when high.
    MemToRegMuxOut <= ReadDataMem WHEN MemToReg = '0' ELSE ALUResult;

end Behavioral;
