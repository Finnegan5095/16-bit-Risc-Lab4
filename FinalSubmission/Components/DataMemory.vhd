----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 09:05:16 PM
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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

entity DataMemory is
  Port (Zero : in STD_LOGIC;
        clk  : in STD_LOGIC;
        WriteData : in STD_LOGIC_VECTOR(15 downto 0);
        ALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        MemWrite    : in STD_LOGIC;
        MemRead     : in STD_LOGIC;
        ReadData    : out STD_LOGIC_VECTOR(15 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type DataMem is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal LongAssMemorySignal : DataMem := (
    x"0101",
    x"0101",
    x"0110",
    x"0011",
    x"00F0",
    x"00FF",
    x"0005",
    x"0006",
    x"0007",
    x"0008",
    x"0009",
    x"000A",
    x"000B",
    x"000C",
    x"000D",
    x"000E",
    x"0101", --0000000100000001
    x"0101",
    x"0110", --
    x"00F0",
    x"0011", --
    x"0000",
    x"00F0", --
    x"0016",
    x"0000", --
    x"0018",
    x"0019",
    x"001A",
    x"001B",
    x"001C",
    x"001D",
    x"001E",
    x"001F",
    x"0020",
    x"0021",
    x"0022",
    x"0023",
    x"0024",
    x"0025",
    x"0026",
    x"0027",
    x"0028",
    x"0029",
    x"002A",
    x"002B",
    x"002C",
    x"002D",
    x"002E",
    x"002F",
    x"0030",
    x"0031",
    x"0032",
    x"0033",
    x"0034",
    x"0035",
    x"0036",
    x"0037",
    x"0038",
    x"0039",
    x"003A",
    x"003B",
    x"003C",
    x"003D",
    x"003E",
    x"003F",
    x"0040",
    x"0041",
    x"0042",
    x"0043",
    x"0044",
    x"0045",
    x"0046",
    x"0047",
    x"0048",
    x"0049",
    x"004A",
    x"004B",
    x"004C",
    x"004D",
    x"004E",
    x"004F",
    x"0050",
    x"0051",
    x"0052",
    x"0053",
    x"0054",
    x"0055",
    x"0056",
    x"0057",
    x"0058",
    x"0059",
    x"005A",
    x"005B",
    x"005C",
    x"005D",
    x"005E",
    x"005F",
    x"0060",
    x"0061",
    x"0062",
    x"0063",
    x"0064",
    x"0065",
    x"0066",
    x"0067",
    x"0068",
    x"0069",
    x"006A",
    x"006B",
    x"006C",
    x"006D",
    x"006E",
    x"006F",
    x"0070",
    x"0071",
    x"0072",
    x"0073",
    x"0074",
    x"0075",
    x"0076",
    x"0077",
    x"0078",
    x"0079",
    x"007A",
    x"007B",
    x"007C",
    x"007D",
    x"007E",
    x"007F",
    x"0080",
    x"0081",
    x"0082",
    x"0083",
    x"0084",
    x"0085",
    x"0086",
    x"0087",
    x"0088",
    x"0089",
    x"008A",
    x"008B",
    x"008C",
    x"008D",
    x"008E",
    x"008F",
    x"0090",
    x"0091",
    x"0092",
    x"0093",
    x"0094",
    x"0095",
    x"0096",
    x"0097",
    x"0098",
    x"0099",
    x"009A",
    x"009B",
    x"009C",
    x"009D",
    x"009E",
    x"009F",
    x"00a0",
    x"00a1",
    x"00a2",
    x"00a3",
    x"00a4",
    x"00a5",
    x"00a6",
    x"00a7",
    x"00a8",
    x"00a9",
    x"00aa",
    x"00ab",
    x"00ac",
    x"00ad",
    x"00ae",
    x"00af",
    x"00b0",
    x"00b1",
    x"00b2",
    x"00b3",
    x"00b4",
    x"00b5",
    x"00b6",
    x"00b7",
    x"00b8",
    x"00b9",
    x"00ba",
    x"00bb",
    x"00bc",
    x"00bd",
    x"00be",
    x"00bf",
    x"00c0",
    x"00c1",
    x"00c2",
    x"00c3",
    x"00c4",
    x"00c5",
    x"00c6",
    x"00c7",
    x"00c8",
    x"00c9",
    x"00ca",
    x"00cb",
    x"00cc",
    x"00cd",
    x"00ce",
    x"00cf",
    x"00d0",
    x"00d1",
    x"00d2",
    x"00d3",
    x"00d4",
    x"00d5",
    x"00d6",
    x"00d7",
    x"00d8",
    x"00d9",
    x"00da",
    x"00db",
    x"00dc",
    x"00dd",
    x"00de",
    x"00df",
    x"00e0",
    x"00e1",
    x"00e2",
    x"00e3",
    x"00e4",
    x"00e5",
    x"00e6",
    x"00e7",
    x"00e8",
    x"00e9",
    x"00ea",
    x"00eb",
    x"00ec",
    x"00ed",
    x"00ee",
    x"00ef",
    x"00f0",
    x"00f1",
    x"00f2",
    x"00f3",
    x"00f4",
    x"00f5",
    x"00f6",
    x"00f7",
    x"00f8",
    x"00f9",
    x"00fa",
    x"00fb",
    x"00fc",
    x"00fd",
    x"00fe"
    --ffx"060F",
    --100x"060F"
    
    );
begin


process(clk)
begin
-- Write and read on the falling edge. 
if (MemRead = '1') then
    ReadData <= LongAssMemorySignal(to_integer(unsigned(ALUResult)));

elsif (MemWrite = '1' and Rising_edge(clk)) then
    LongAssMemorySignal(to_integer(unsigned(WriteData))) <= ALUResult;

else --?
    --ReadData <= x"0001";
end if;


end process;
end Behavioral;
