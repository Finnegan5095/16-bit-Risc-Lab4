----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2022 05:09:09 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  Port (clk : in STD_LOGIC;
        ReadData1   : in STD_LOGIC_VECTOR(15 downto 0);
        RegToALUMuxIn   : in STD_LOGIC_VECTOR(15 downto 0);
        ALUctrOpCode  : in STD_LOGIC_VECTOR(3 downto 0);
        Zero    : out std_logic;
        Overflow    : out std_logic;
        Carryout    : out std_logic;
        ALUResultOut  : out STD_LOGIC_VECTOR(15 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

    process(clk)
    Variable Result_Adder1 : signed(31 downto 0);
    Variable Adder_Zero1 : std_logic := '0';
    Variable Adder_Overflow1 : std_logic := '0';
    Variable Adder_Carryout1 : std_logic := '0';
    Variable Divisor : Integer := 0;
    Variable Mult1 : Integer := 0;
    Variable Mult2 : Integer := 0;
    Variable MultTotal : Integer := 0;
    Variable QuotientToInt : Integer := 0;
    Variable TempDiv : Integer := 0;
    Variable TempInv : signed(15 downto 0);
    Variable iTypeConstant : std_logic_vector(15 downto 0) := "0000000000000000";
    begin
        if rising_edge(clk) then
        --Case statements to determine ALUs operation and set the output with correct output signals.
         iTypeConstant(3 downto 0) := RegToALUMuxIn(3 downto 0);
        case(ALUctrOpCode) IS
            --iTypeConstant(3 downto 0) := RegToALUMuxIn(3 downto 0);
            -- Adder case
            When "0000" =>
                  ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(RegToALUMuxIn));
                  if (STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(RegToALUMuxIn))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                     
            -- Subtraction case
            When "0001" =>
                  ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(RegToALUMuxIn));
                  if (STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(RegToALUMuxIn))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
            -- Bitwise or case
            When "0010" =>
                  ALUResultOut <= (ReadData1 or RegToALUMuxIn);         
                  if (ReadData1 or RegToALUMuxIn) = "0000000000000000" then -- If less than zero goes high meaning we will branch.
                        Zero <= '1';
                  else 
                        Zero <= '0';
                  end if; 
            
            -- Exclusive or case        
            When "0011" =>        
                  ALUResultOut <= ReadData1 xor RegToALUMuxIn;
                  if (ReadData1 xor RegToALUMuxIn) = "0000000000000000" then -- If less than zero goes high meaning we will branch.
                        Zero <= '1';
                  else 
                        Zero <= '0';
                  end if; 
                  
                
            -- Multiply
            When "0100" =>
                Mult1 := to_integer(signed(ReadData1));
                Mult2 := to_integer(signed(iTypeConstant));
                MultTotal := 0;
                for i in 1 to Mult2 loop
                    MultTotal := MultTotal + Mult1;
                end loop;
                
                ALUResultOut <= STD_LOGIC_VECTOR(to_signed(MultTotal, ReadData1'length));
                
                if (STD_LOGIC_VECTOR(to_signed(MultTotal, ReadData1'length))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
            -- Divide
            When "0101" =>
                QuotientToInt := to_integer(signed(ReadData1));
                Divisor := to_integer(signed(iTypeConstant));
                TempDiv := 0;
                TempInv := "0000000000000000";
                --While TempDiv < QuotientToInt loop
                --       TempDiv := TempDiv + Divisor;
                --        if (TempDiv >= QuotientToInt) then
                --            exit;
                --        end if;
                --end loop;
                
                --if ((QuotientToInt < 0) or  (Divisor < 0)) then
                --    TempInv := not(to_signed(TempDiv, TempInv'length)) + "0000000000000001";
                --end if;
                --ALUResultOut <= STD_LOGIC_VECTOR(TempInv);
                --R <= std_logic_vector(to_signed(to_integer(signed(X) / signed(Y)),32));
                ALUResultOut <= std_logic_vector(to_signed(TO_INTEGER(signed(ReadData1) / signed(iTypeConstant)) , 16));
                --ALUResultOut <= (signed(ReadData1)) / (signed(RegToALUMuxIn));
                
                if (STD_LOGIC_VECTOR(TempINV)) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
                
            
            -- Add Immediate
            When "0110" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant));
                if (STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
            -- Sub Immediate
            When "0111" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(iTypeConstant));
                if (STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(iTypeConstant))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
              -- Load Word
            When "1000" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant));
                if (STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
                  -- Store word
            When "1001" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant));
                if (STD_LOGIC_VECTOR(SIGNED(ReadData1) + SIGNED(iTypeConstant))) = "0000000000000000" then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                
                  -- Branch on equal
            When "1010" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(RegToALUMuxIn));
                  if ((SIGNED(ReadData1) - SIGNED(RegToALUMuxIn)) = "0000000000000000") then
                    Zero <= '1';
                  else 
                    Zero <= '0';
                  end if;
                         
                -- Branch on less than
            When "1011" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(RegToALUMuxIn));
                if ((SIGNED(ReadData1) < SIGNED(RegToALUMuxIn))) then -- If less than zero goes high meaning we will branch.
                    Zero <= '1';
                else 
                    Zero <= '0';
                end if;
                               
                 -- Branch on greater than
            When "1100" =>
                ALUResultOut <= STD_LOGIC_VECTOR(SIGNED(ReadData1) - SIGNED(RegToALUMuxIn));
                if ((SIGNED(ReadData1) > SIGNED(RegToALUMuxIn))) then -- If less than zero goes high meaning we will branch.
                    Zero <= '1';
                else 
                    Zero <= '0';
                end if; 
                
                 -- Jump
            When "1101" =>
                -- We don't need these values so we just set to zeros.
                ALUResultOut <= "0000000000000000";
                Zero <= '0';
                
                 -- Shift Left Logical
            When "1110" =>
                ALUResultOut <= std_logic_vector(unsigned(ReadData1) sll to_integer(unsigned(iTypeConstant)));
                --ALUResultOut <= std_logic_vector(shift_left(unsigned(ReadData1), to_integer(unsigned(iTypeConstant))));                 
                    
                 -- Jump Return
            When "1111" =>
                 -- We don't need these values so we just set to zeros.
                ALUResultOut <= "0000000000000000";
                Zero <= '0';
                
            When others =>
                ALUResultOut <= "0000000000000000";
                Zero <= '0';
            
        end case;
        end if;
    end process;
end Behavioral;
