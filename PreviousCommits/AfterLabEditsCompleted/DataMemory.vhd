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
    x"000F",
    x"0010",
    x"0011",
    x"0012",
    x"0013",
    x"0014",
    x"0015",
    x"0016",
    x"0017",
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
    x"0100",
    x"0101",
    x"0102",
    x"0103",
    x"0104",
    x"0105",
    x"0106",
    x"0107",
    x"0108",
    x"0109",
    x"010A",
    x"010B",
    x"010C",
    x"010D",
    x"010E",
    x"010F",
    x"0200",
    x"0201",
    x"0202",
    x"0203",
    x"0204",
    x"0205",
    x"0206",
    x"0207",
    x"0208",
    x"0209",
    x"020A",
    x"020B",
    x"020C",
    x"020D",
    x"020E",
    x"020F",
    x"0300",
    x"0301",
    x"0302",
    x"0303",
    x"0304",
    x"0305",
    x"0306",
    x"0307",
    x"0308",
    x"0309",
    x"030A",
    x"030B",
    x"030C",
    x"030D",
    x"030E",
    x"030F",
    x"0400",
    x"0401",
    x"0402",
    x"0403",
    x"0404",
    x"0405",
    x"0406",
    x"0407",
    x"0408",
    x"0409",
    x"040A",
    x"040B",
    x"040C",
    x"040D",
    x"040E",
    x"040F",
    x"0500",
    x"0501",
    x"0502",
    x"0503",
    x"0504",
    x"0505",
    x"0506",
    x"0507",
    x"0508",
    x"0509",
    x"050A",
    x"050B",
    x"050C",
    x"050D",
    x"050E",
    x"050F",
    x"0600",
    x"0601",
    x"0602",
    x"0603",
    x"0604",
    x"0605",
    x"0606",
    x"0607",
    x"0608",
    x"0609",
    x"060A",
    x"060B",
    x"060C",
    x"060D",
    x"060E",
    x"060F"
    );
begin


process(MemWrite, MemRead, clk)
begin
-- Write and read on the falling edge. 
if (MemRead = '1') then
    ReadData <= LongAssMemorySignal(to_integer(unsigned(ALUResult)));

elsif (MemWrite = '1' and Rising_edge(clk)) then
    LongAssMemorySignal(to_integer(unsigned(ALUResult))) <= WriteData;

else --?
    --ReadData <= x"0001";
end if;


end process;
end Behavioral;
