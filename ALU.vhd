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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  Port (ReadData1   : in STD_LOGIC_VECTOR(15 downto 0);
        RegToALUMuxIn   : in STD_LOGIC_VECTOR(15 downto 0);
        ALUctr  : in STD_LOGIC_VECTOR(2 downto 0);
        Zero    : out std_logic;
        Overflow    : out std_logic;
        Carryout    : out std_logic;
        ALUResultOut  : out STD_LOGIC_VECTOR(15 downto 0));
end ALU;

architecture structural of ALU is

-- Declare all ALU operation Components here.
    Component Adder
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic );
    END Component;

    Component Subtraction
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic);
    END Component;
    
    Component BitwiseAnd
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic); 
    END Component;
    
    Component BitwiseOr
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic);
    END Component;
    
    Component LogicalLeftShift
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic );     
    END Component;
    
    Component LogicalRightShift
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic );    
    END Component;
    
    Component ArithmeticLeftShift
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic ); 
    END Component;
    
    Component ArithmeticRightShift
        PORT(Bus_A  : in signed(31 downto 0);
             Bus_B  : in signed(31 downto 0);
             Result : out signed(31 downto 0);
             Zero:       out std_logic;
             Overflow:   out std_logic;
             CarryOut:   out std_logic );
    END Component;

    FOR ALL : Adder USE ENTITY work.Adder(Behavioral);
    FOR ALL : Subtraction USE ENTITY work.Subtraction(Behavioral);
    FOR ALL : BitwiseAnd USE ENTITY work.BitwiseAnd(Behavioral);
    FOR ALL : BitwiseOr USE ENTITY work.BitwiseOr(Behavioral);
    FOR ALL : LogicalLeftShift USE ENTITY work.LogicalLeftShift(Behavioral);
    FOR ALL : LogicalRightShift USE ENTITY work.LogicalRightShift(Behavioral);
    FOR ALL : ArithmeticLeftShift USE ENTITY work.ArithmeticLeftShift(Behavioral);
    FOR ALL : ArithmeticRightShift USE ENTITY work.ArithmeticRightShift(Behavioral);
    
    
    signal Result_Adder : signed(31 downto 0);
    signal Adder_Zero : std_logic;
    signal Adder_Overflow : std_logic;
    signal Adder_Carryout : std_logic;
    
    signal Result_Subtraction : signed(31 downto 0);
    signal Subtraction_Zero : std_logic;
    signal Subtraction_Overflow : std_logic;
    signal Subtraction_Carryout : std_logic;
    
    signal Result_Bitwise_And : signed(31 downto 0);
    signal Bitwise_And_Zero : std_logic;
    signal Bitwise_And_Overflow : std_logic;
    signal Bitwise_And_Carryout : std_logic;

    signal Result_Bitwise_Or : signed(31 downto 0);
    signal Bitwise_Or_Zero : std_logic;
    signal Bitwise_Or_Overflow : std_logic;
    signal Bitwise_Or_Carryout : std_logic;

    signal Result_LogicalLeftShift : signed(31 downto 0);
    signal LogicalLeftShift_Zero : std_logic;
    signal LogicalLeftShift_Overflow : std_logic;
    signal LogicalLeftShift_Carryout : std_logic;
    
    signal Result_LogicalRightShift : signed(31 downto 0);
    signal LogicalRightShift_Zero : std_logic;
    signal LogicalRightShift_Overflow : std_logic;
    signal LogicalRightShift_Carryout : std_logic;

    signal Result_ArithmeticLeftShift : signed(31 downto 0);
    signal ArithmeticLeftShift_Zero : std_logic;
    signal ArithmeticLeftShift_Overflow : std_logic;
    signal ArithmeticLeftShift_Carryout : std_logic;

    signal Result_ArithmeticRightShift : signed(31 downto 0);
    signal ArithmeticRightShift_Zero : std_logic;
    signal ArithmeticRightShift_Overflow : std_logic;
    signal ArithmeticRightShift_Carryout : std_logic;

begin

    -- Instatiating each operation component.
    Adder_Call : Adder PORT MAP(Bus_A => Bus_A, Bus_B => Bus_B, Result => Result_Adder, Zero => Adder_Zero, Overflow => Adder_Overflow, Carryout => Adder_Carryout); 
    Subtraction_Call : Subtraction PORT MAP(Bus_A => Bus_A, Bus_B => Bus_B, Result => Result_Subtraction, Zero => Subtraction_Zero, Overflow => Subtraction_Overflow, Carryout => Subtraction_Carryout); 
    Bitwise_And_Call : BitwiseAnd PORT MAP(Bus_A => Bus_A, Bus_B => Bus_B, Result => Result_Bitwise_And, Zero => Bitwise_And_Zero, Overflow => Bitwise_And_Overflow, Carryout => Bitwise_And_Carryout);
    Bitwise_Or_Call : BitwiseOr PORT MAP(Bus_A => Bus_A, Bus_B => Bus_B, Result => Result_Bitwise_Or, Zero => Bitwise_Or_Zero, Overflow => Bitwise_Or_Overflow, Carryout => Bitwise_Or_Carryout);
    Logical_Left_Shift_Call : LogicalLeftShift PORT MAP(Bus_A => Bus_A,  Bus_B => Bus_B, Result => Result_LogicalLeftShift, Zero => LogicalLeftShift_Zero, Overflow => LogicalLeftShift_Overflow, Carryout => LogicalLeftShift_Carryout);
    Logical_Right_Shift_Call : LogicalRightShift PORT MAP(Bus_A => Bus_A,  Bus_B => Bus_B, Result => Result_LogicalRightShift, Zero => LogicalRightShift_Zero, Overflow => LogicalRightShift_Overflow, Carryout => LogicalRightShift_Carryout);
    Arithmetic_Left_Shift_Call : ArithmeticLeftShift PORT MAP(Bus_A => Bus_A,  Bus_B => Bus_B, Result => Result_ArithmeticLeftShift, Zero => ArithmeticLeftShift_Zero, Overflow => ArithmeticLeftShift_Overflow, Carryout => ArithmeticLeftShift_Carryout);
    Arithmetic_Right_Shift_Call : ArithmeticRightShift PORT MAP(Bus_A => Bus_A,  Bus_B => Bus_B, Result => Result_ArithmeticRightShift, Zero => ArithmeticRightShift_Zero, Overflow => ArithmeticRightShift_Overflow, Carryout => ArithmeticRightShift_Carryout);


    process(BUS_A, BUS_B, ALUctr, Result_Adder, Result_Subtraction, Result_Bitwise_And, Result_Bitwise_Or, Result_LogicalLeftShift, Result_LogicalRightShift, Result_ArithmeticLeftShift, Result_ArithmeticRightShift)
    Variable Result_Adder1 : signed(31 downto 0);
    Variable Adder_Zero1 : std_logic := '0';
    Variable Adder_Overflow1 : std_logic := '0';
    Variable Adder_Carryout1 : std_logic := '0';
    begin
    
        --Case statements to determine ALUs operation and set the output with correct output signals.
         
        case(ALUctr) IS
        
            -- Adder case
            When "0000" =>
                Result_Adder1 := Result_Adder;
                Adder_Zero1 := Adder_Zero;
                Adder_Overflow1 := Adder_Overflow;
                Adder_Carryout1 := Adder_Carryout;
                Result <= Result_Adder1;
                Zero <= Adder_Zero1;
                Overflow <= Adder_Overflow1;
                Carryout <= Adder_Carryout1;
                       
            -- Subtraction case
            When "0001" =>
                Result <= Result_Subtraction;
                Zero <= Subtraction_Zero;
                Overflow <= Subtraction_Overflow;
                Carryout <= Subtraction_Carryout;
                     
            -- Bitwise or case
            When "0010" =>
                Result <= Result_Bitwise_And;
                Zero <= Bitwise_And_Zero;
                Overflow <= Bitwise_And_Overflow;
                Carryout <= Bitwise_And_Carryout;
            
            
            -- Exclusive or  case        
            When "0011" =>        
                Result <= Result_Bitwise_Or;
                Zero <= Bitwise_Or_Zero;
                Overflow <= Bitwise_Or_Overflow;
                Carryout <= Bitwise_Or_Carryout;
                
            -- Multiply
            When "0100" =>
                --Result <= Result_LogicalLeftShift;
                Zero <= LogicalLeftShift_Zero;
                Overflow <= LogicalLeftShift_Overflow;
                Carryout <= LogicalLeftShift_Carryout;
                Result <= Result_LogicalLeftShift;
                
            -- Divide
            When "0101" =>
                --Result <= Result_LogicalRightShift;
                Zero <= LogicalRightShift_Zero;
                Overflow <= LogicalRightShift_Overflow;
                Carryout <= LogicalRightShift_Carryout;
                Result <= Result_LogicalRightShift;
            
            -- Add Immediate
            When "0110" =>
                --Result <= Result_ArithmeticLeftShift;
                Zero <= ArithmeticLeftShift_Zero;
                Overflow <= ArithmeticLeftShift_Overflow;
                Carryout <= ArithmeticLeftShift_Carryout;
                Result <= Result_ArithmeticLeftShift;
                
            -- Sub Immediate
            When "0111" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
              -- Load Word
            When "1000" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
                  -- Store word
            When "1001" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
                  -- Branch on equal
            When "1010" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
                -- Branch on less than
            When "1011" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
                 -- Branch on greater than
            When "1100" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;
                
                 -- Jump
            When "1101" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;    
                
                 -- Shift Left Logical
            When "1110" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;   
                
                
                 -- Jump Return
            When "1111" =>
                --Result <= Result_ArithmeticRightShift;
                Zero <= ArithmeticRightShift_Zero;
                Overflow <= ArithmeticRightShift_Overflow;
                Carryout <= ArithmeticRightShift_Carryout;
                Result <= Result_ArithmeticRightShift;  
                
            When others =>
                -- Setting all outputs to cover all other cases.
                Result <= "00000000000000000000000000000000";
                Zero <= '0';
                Overflow <= '0';
                Carryout <= '0';
            
        end case;
    end process;
end structural;
