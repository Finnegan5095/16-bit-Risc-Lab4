----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 06:16:24 PM
-- Design Name: 
-- Module Name: InstMemToRegMux - Behavioral
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

entity InstMemToRegMux is
  Port (RegDst : in STD_LOGIC;
        Inst1Rs   : in STD_LOGIC_VECTOR(3 downto 0);
        Inst2Rd   : in STD_LOGIC_VECTOR(3 downto 0);
        MuxOut  : out STD_LOGIC_VECTOR(3 downto 0));
        
end InstMemToRegMux;

architecture Behavioral of InstMemToRegMux is
begin

MuxOut <= Inst2Rd WHEN RegDst = '1' ELSE Inst1Rs; 

end Behavioral;
