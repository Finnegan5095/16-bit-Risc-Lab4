----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 04:51:27 PM
-- Design Name: 
-- Module Name: RegFile - Behavioral
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

entity RegFile is
  Port (clk : in STD_LOGIC;
        ReadReg1 : in STD_LOGIC_VECTOR(3 downto 0);
        ReadReg2 : in STD_LOGIC_VECTOR(3 downto 0);
        WriteReg : in STD_LOGIC_VECTOR(3 downto 0);
        WriteData : in STD_LOGIC_VECTOR(15 downto 0);
        RegWriteCtrl : in STD_LOGIC;
        ReadData1 : out STD_LOGIC_VECTOR(15 downto 0);
        ReadData2 : out STD_LOGIC_VECTOR(15 downto 0));
end RegFile;

architecture Behavioral of RegFile is

 type RegMemArray is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
 signal Reg_File : RegMemArray := (
    "0000000000000000", --$Zero
    "0000000001000000", --$v0
    "0001000000010000", --$v1
    "0000000000001111", --$v2
    "0000000011110000", --$v3
    "0000000000010000", --$a0
    "0000000000000101", --$a1
    "0000000000000000", --$t0
    "0000000000000000", --$t1
    "0000000000000000", --$t2
    "0000000000000000", --$t3
    "0000000000000000", --$t4
    "0000000000000000", --$t5
    "0000000000000000", --$s0
    "0000000000000000", --$s1
    "0000000000000000" -- $ra
 );
 
 
begin

    -- Outputting the Register data by converting the ReadReg 4 bits to an integer index.
    ReadData1 <= Reg_File(to_integer(unsigned(ReadReg1))); 
    ReadData2 <= Reg_File(to_integer(unsigned(ReadReg2)));

process(clk)
    begin
    --Check if we are at the rising edge of the clock and that the Reg write enable signal is '1'.
    if (Rising_edge(clk) and RegWriteCtrl = '1') then
        Reg_File(to_integer(unsigned(WriteReg))) <= WriteData;
    --else
        --Reg_File(to_integer(unsigned(WriteReg))) <= Reg_File(to_integer(unsigned(WriteReg)));
    end if;
end process;
end Behavioral;
