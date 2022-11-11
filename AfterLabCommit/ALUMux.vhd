----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 06:45:00 PM
-- Design Name: 
-- Module Name: ALUMux - Behavioral
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

entity ALUMux is
  Port (ReadData2 : in STD_LOGIC_VECTOR(15 downto 0);
        SignExtend : in STD_LOGIC_VECTOR(15 downto 0);
        ALUSrc  : in STD_LOGIC;
        ALUMuxOut   : out STD_LOGIC_VECTOR(15 downto 0));
end ALUMux;

architecture Behavioral of ALUMux is

begin
process (ReadData2, ALUSrc, SignExtend) 
   begin
    if (ALUSrc = '0') then
        ALUMuxOut <= ReadData2;
    elsif (ALUSrc = '1') then
        ALUMuxOut <= SignExtend;
    else
        ALUMuxOut <= "HHHHHHHHHHHHHHHH";
    end if;
    end process;
    -- ALUMuxOut gets ReadReg2 when ALUSrc is low and SignExtend when high.
    --ALUMuxOut <= ReadData2 WHEN ALUSrc = '0' ELSE SignExtend;

end Behavioral;
