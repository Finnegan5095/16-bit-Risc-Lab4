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

type InstMem is array (0 to 43) of STD_LOGIC_VECTOR(15 downto 0); --Declaring array type that will store all 16-bit instructions vectors.

signal Memory : InstMem := (
        "1110000000000000",   --pc = 0  0000   Nop insertion
        "1110000000000000",   --pc = 1  0001   Nop insertion
        "1110000000000000",   --pc = 2  0010   Nop insertion
        "1110000000000000",   --pc = 3  0011   Nop insertion
        "1110000000000000",   --pc = 4  0100   Nop insertion
        "1100011000000001",   --pc = 5  0101   bgt a0 zero ZeroLine  branch 1 line (pc incremented by 2*1)
        "1101000001111111",   --pc = 6  0110   j Exit                jump 40 lines (pc incremented by 2*40)
        "0111011001100001",   --pc = 7  0111   subi a1 a1 1          subtract 1 from a1
        "1000010101110000",   --pc = 8  1000   lw t0 0(a0)           put contents of a0 into t0
        "1110100010000100",   --pc = 9  1001   sll t1 t1 4           shift t1 left four
        "0110100010000000",   --pc = 10 1010   addi t1 t1 0x0        add 0000 to t1
        "1110100010000100",   --pc = 11 1011   sll t1 t1 4           shift t1 left four
        "0110100010001111",   --pc = 12 1100   addi t1 t1 0xF        add 1111 to t1
        "1110100010000100",   --pc = 13 1101   sll t1 t1 4           shift t1 left four
        "0110100010000000",   --pc = 14 1110   addi t1 t1 0x0        add 0000 to t1
        "1110100010000100",   --pc = 15 1110   sll t1 t1 4           shift t1 left four
        "0110100010000000",   --pc = 16 10000  addi t1 t1 0x0        add 0000 to t1
        "1011011110000001",   --pc = 17 10001  bgt t0 t1 SkipIfJump  branch to SkipIfJump if t0 > t1, skip 1 lines (pc incremented by 2*1)
        "1101000000011010",   --pc = 18 10010  j Else                jump to else to avoid if statement
        "0101000100011000",   --pc = 19 10011  div v0 v0 0b1000      divide v0 by 8
        "0010001000100001",   --pc = 20 10100  or v1 v1 v0           or v1 and v0
        "1110100110010100",   --pc = 21 10101  sll t2 t2 4           shift t2 left four
        "0110100110011111",   --pc = 22 10110  addi t2 t2 0xF        add 1111 to t2
        "1110100110010100",   --pc = 23 10111  sll t2 t2 4           shift t2 left four
        "0110100110011111",   --pc = 24 11000  addi t2 t2 0xF        add 1111 to t2
        "1110100110010100",   --pc = 25 11001  sll t2 t2 4           shift t2 left four
        "0110100110010000",   --pc = 26 11010  addi t2 t2 0x0        add 0000 to t2
        "1110100110010100",   --pc = 27 11011  sll t2 t2 4           shift t2 left four
        "0110100110010000",   --pc = 28 11100  addi t2 t2 0x0        add 0000 to t2
        "1001100101010000",   --pc = 29 11101  sw t2 0(a0)           store t2 into a0
        "1101000000100101",   --pc = 30 11110  j Endif               jump endif to avoid else statement
        "0100001100110100",   --pc = 31 11111  mul v2 v2 4           multiply v2 by four
        "0011010001000011",   --pc = 32 100000  xor v3 v3 v2          xor v3 and v2
        "1110100110010100",   --pc = 33 100001  sll t2 t2 4           shift l2 left four
        "0110100110010000",   --pc = 34 100010  addi t2 t2 0x0        add 0000 to t2
        "1110100110010100",   --pc = 35 100011  sll t2 t2 4           shift l2 left four
        "0110100110010000",   --pc = 36 100100  addi t2 t2 0x0        add 0000 to t2
        "1110100110010100",   --pc = 37 100101  sll t2 t2 4           shift l2 left four
        "0110100110011111",   --pc = 38 100110  addi t2 t2 0xF        add 1111 to t2
        "1110100110010100",   --pc = 39 100111  sll t2 t2 4           shift l2 left four
        "0110100110011111",   --pc = 40 101000  addi t2 t2 0xF        add 1111 to t2
        "1001100101010000",   --pc = 41 101001  sw t2 0(a0)           store t2 into ao
        "0110010101010010",   --pc = 42 101010  addi a0 a0 2          add 2 to ao
        "1101000000000000"    --pc = 43 101011  j Loop                jump to Loop -40 lines
         );


begin

   process (InstAddress) 
   begin
   
        if (to_integer(unsigned(InstAddress)) < 43) then
            InstData <= Memory(to_integer(unsigned(InstAddress))); 
        else
--            InstData <= Memory(0);
              InstData <= "1110000000000000"; --Nop insertion.
        end if;   
       
--        InstData <= Memory(to_integer(unsigned(InstAddress))) 
--        WHEN to_integer(unsigned(InstAddress)) < 64 
--        ELSE Memory(0); 
   
   end process;
   
end Behavioral;
