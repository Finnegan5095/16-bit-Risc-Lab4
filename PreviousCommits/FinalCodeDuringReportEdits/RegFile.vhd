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
        InstData : in STD_LOGIC_VECTOR(15 downto 0);
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
    "0000000000000000", --$Zero 0 0000
    "0000000001000000", --$v0   1 0001
    "0001000000010000", --$v1   2 0010
    "0000000000001111", --$v2   3 0011
    "0000000011110000", --$v3   4 0100
    "0000000000010000", --$a0   5 0101
    "0000000000000101", --$a1   6 0110
    "0000000000000000", --$t0   7 0111
    "0000000000000000", --$t1   8 1000
    "0000000000000000", --$t2   9 1001
    "0000000000000000", --$t3   10
    "0000000000000000", --$t4   11
    "0000000000000000", --$t5   12
    "0000000000000000", --$s0   13
    "0000000000000000", --$s1   14
    "0000000000000000" -- $ra   15
 );
 
 
begin

    -- Outputting the Register data by converting the ReadReg 4 bits to an integer index.
    process (InstData)
    begin
        --if (rising_edge(clk)) then
            ReadData1 <= Reg_File(to_integer(unsigned(ReadReg1))); 
            ReadData2 <= Reg_File(to_integer(unsigned(ReadReg2)));
        --end if;
    end process;

process(WriteData)
    begin
    --Check if we are at the rising edge of the clock and that the Reg write enable signal is '1'.
    --if (rising_edge(clk) and RegWriteCtrl = '1' and not(WriteReg = "0000")) then
    --    Reg_File(to_integer(unsigned(WriteReg))) <= WriteData after 49ns;
    --else
    --    Reg_File(to_integer(unsigned(WriteReg))) <= Reg_File(to_integer(unsigned(WriteReg)));
    --end if;
    if (RegWriteCtrl = '1' and not(WriteReg = "0000")) then             
        Reg_File(to_integer(unsigned(WriteReg))) <= WriteData after 49ns;                    
    else                                                                                     
        Reg_File(to_integer(unsigned(WriteReg))) <= Reg_File(to_integer(unsigned(WriteReg)));
end if;                                                                                  
end process;
end Behavioral;
