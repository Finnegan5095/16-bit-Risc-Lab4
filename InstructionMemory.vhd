----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 04:16:17 PM
-- Design Name: 
-- Module Name: InstructionMemory - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionMemory is
  Port (InstAddress : in STD_LOGIC_VECTOR(15 downto 0);
        InstData    : out STD_LOGIC_VECTOR(15 downto 0));
end InstructionMemory;

architecture Behavioral of InstructionMemory is

type InstMem is array (0 to 31) of STD_LOGIC_VECTOR(15 downto 0); --Declaring array type that will store all 16-bit instructions vectors.

signal Memory : InstMem := (
    "0000000000000001",
    "0000000000000010"
    );


begin

   InstData <= Memory(to_integer(unsigned(InstAddress))/2) 
   WHEN to_integer(unsigned(InstAddress)) < 64 
   ELSE Memory(0); 
   
end Behavioral;
