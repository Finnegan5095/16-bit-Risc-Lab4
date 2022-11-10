----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2022 05:02:03 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
  Port (InstOpCode : in STD_LOGIC_VECTOR(3 downto 0);
        RegDst  : out STD_LOGIC;
        Jump  : out STD_LOGIC;
        Branch  : out STD_LOGIC;
        MemRead  : out STD_LOGIC;
        MemToReg  : out STD_LOGIC;
        ALUOpCode  : out STD_LOGIC_VECTOR(3 downto 0);
        MemWrite  : out STD_LOGIC;
        ALUSrc  : out STD_LOGIC;
        RegWrite  : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

Process(InstOpCode) is
begin
    
    CASE InstOpCode is   
        When "0000" => -- Add (R-type)
            RegDst <= '1';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '1';
            ALUOpCode <= "0000";
        
        When "0001" => -- Sub (R-type)
            RegDst <= '1';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '1';
            ALUOpCode <= "0001";
        When "0010" => -- Or (R-type)
             RegDst <= '1';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '1';
            ALUOpCode <= "0010";
        When "0011" => -- Xor (R-type)
            RegDst <= '1';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '1';
            ALUOpCode <= "0011";
        When "0100" => -- mul (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "0100";
        When "0101" => -- div (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "0101";
        When "0110" => -- addi (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "0110";
        When "0111" => -- subi (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "0111";
        When "1000" => -- lw (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '1';
            MemToReg <= '1';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "1000";
        When "1001" => -- sw (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '1';
            ALUSrc <= '1';
            RegWrite <= '0';
            ALUOpCode <= "1001";
        When "1010" => -- beq (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '1';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '0';
            ALUOpCode <= "1010";
        When "1011" => --blt (I-type)
             RegDst <= '0';
            Jump <= '0';
            Branch <= '1';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '0';
            ALUOpCode <= "1011";
        When "1100" => --bgt (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '1';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '0';
            ALUOpCode <= "1100";
        When "1101" => -- sll (I-type)
            RegDst <= '0';
            Jump <= '0';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOpCode <= "1101";
        When "1110" => -- j (J-type)
            RegDst <= '0';
            Jump <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '0';
            ALUOpCode <= "1110";
        When "1111" => -- jr (J-type)
            RegDst <= '0';
            Jump <= '1';
            Branch <= '0';
            MemRead <= '0';
            MemToReg <= '0';
            MemWrite <= '0';
            ALUSrc <= '0';
            RegWrite <= '0';
            ALUOpCode <= "1111";
        When Others =>
            RegDst <= 'X';
            Jump <= 'X';
            Branch <= 'X';
            MemRead <= 'X';
            MemToReg <= 'X';
            MemWrite <= 'X';
            ALUSrc <= 'X';
            RegWrite <= 'X';
            ALUOpCode <= "XXXX";
    end CASE;
end process;

end Behavioral;
