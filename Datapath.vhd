----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 06:15:38 PM
-- Design Name: 
-- Module Name: Datapath - Structural
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
library UNISIM;
use UNISIM.VComponents.all;

entity Datapath is
  Port (clk : in STD_LOGIC;
        RegDst : in STD_LOGIC;
        Jump    : in STD_LOGIC;
        Branch  : in STD_LOGIC;
        MemRead : in STD_LOGIC;
        MemToReg : in STD_LOGIC;
        ALUctrOpCode : in STD_LOGIC_VECTOR(3 downto 0);
        MemWrite : in STD_LOGIC;
        ALUSrc : in STD_LOGIC;
        RegWrite : in STD_LOGIC
  );
end Datapath;

architecture Structural of Datapath is

    Component ALU
        PORT (ReadData1   : in STD_LOGIC_VECTOR(15 downto 0);
            RegToALUMuxIn   : in STD_LOGIC_VECTOR(15 downto 0);
            ALUctrOpCode  : in STD_LOGIC_VECTOR(3 downto 0);
            Zero    : out std_logic;
            Overflow    : out std_logic;
            Carryout    : out std_logic;
            ALUResultOut  : out STD_LOGIC_VECTOR(15 downto 0));
    END Component;
    
    Component ALUMux
        Port (ReadData2 : in STD_LOGIC_VECTOR(15 downto 0);
        SignExtend : in STD_LOGIC_VECTOR(15 downto 0);
        ALUSrc  : in STD_LOGIC;
        ALUMuxOut   : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component BranchJumpAdder
        Port (ShiftInput : in STD_LOGIC_VECTOR(15 downto 0);
         PCAddress : in STD_LOGIC_VECTOR(15 downto 0);
         ALUResult  : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component BranchMux
        Port (PCPlusFour : in STD_LOGIC_VECTOR(15 downto 0);
        BranchALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        PCSrc  : in STD_LOGIC;
        NextPC   : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component DataMemory
        Port (Zero : in STD_LOGIC;
        clk  : in STD_LOGIC;
        WriteData : in STD_LOGIC_VECTOR(15 downto 0);
        ALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        MemWrite    : in STD_LOGIC;
        MemRead     : in STD_LOGIC;
        ReadData    : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component InstMemToRegMux
         Port (RegDst : in STD_LOGIC;
        Inst1Rs   : in STD_LOGIC_VECTOR(3 downto 0);
        Inst2Rd   : in STD_LOGIC_VECTOR(3 downto 0);
        MuxOut  : out STD_LOGIC_VECTOR(3 downto 0));     
    End Component;
    
    Component InstructionMemory
         Port (InstAddress : in STD_LOGIC_VECTOR(15 downto 0);
        InstData    : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component Instruction_Adder_Component
        Port (InstIn : in STD_LOGIC_VECTOR(15 downto 0);
        InstOut : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component MemToRegMux
        Port (ReadDataMem : in STD_LOGIC_VECTOR(15 downto 0);
        ALUResult : in STD_LOGIC_VECTOR(15 downto 0);
        MemToReg  : in STD_LOGIC;
        MemToRegMuxOut   : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component PC_Component
        Port (clk : in  STD_LOGIC;
           pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (15 downto 0));
    End Component; 

    Component RegFile
        Port (clk : in STD_LOGIC;
        ReadReg1 : in STD_LOGIC_VECTOR(4 downto 0);
        ReadReg2 : in STD_LOGIC_VECTOR(4 downto 0);
        WriteReg : in STD_LOGIC_VECTOR(4 downto 0);
        WriteData : in STD_LOGIC_VECTOR(15 downto 0);
        RegWriteCtrl : in STD_LOGIC;
        ReadData1 : out STD_LOGIC_VECTOR(15 downto 0);
        ReadData2 : out STD_LOGIC_VECTOR(15 downto 0));
    End Component; 
    
    Component ShiftBranch
        Port (SignExtend : in STD_LOGIC_VECTOR(15 downto 0);
        ShiftOutBranch    : out STD_LOGIC_VECTOR(15 downto 0));
    End Component; 
    
    Component ShiftJump
        Port (ShiftAddress : in STD_LOGIC_VECTOR(12 downto 0);
        ShiftOut    : out STD_LOGIC_VECTOR(13 downto 0));
    End Component; 
    
    Component SignExtension
        Port (DataIn : in STD_LOGIC_VECTOR(3 downto 0);
        ExtendedData : out STD_LOGIC_VECTOR(15 downto 0));
    End Component; 
    
    Component JumpMux
        Port (Jump : in STD_LOGIC; 
        JumpAddressIn : in STD_LOGIC_VECTOR(15 downto 0);
        BranchMuxIn : in STD_LOGIC_VECTOR(15 downto 0);
        PCOut   : out STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    
    FOR ALL : ALU use ENTITY work.ALU(Behavioral);
    FOR ALL : ALUMux use ENTITY work.ALUMux(Behavioral);
    FOR ALL : BranchJumpAdder use ENTITY work.BranchJumpAdder(Behavioral);
    FOR ALL : BranchMux use ENTITY work.BranchMux(Behavioral);
    FOR ALL : DataMemory use ENTITY work.DataMemory(Behavioral);
    FOR ALL : InstMemToRegMux use ENTITY work.InstMemToRegMux(Behavioral);
    FOR ALL : InstructionMemory use ENTITY work.InstructionMemory(Behavioral);
    FOR ALL : Instruction_Adder_Component use ENTITY work.Instruction_Adder_Component(Behavioral);
    FOR ALL : MemToRegMux use ENTITY work.MemToRegMux(Behavioral);
    FOR ALL : PC_Component use ENTITY work.PC_Component(Behavioral);
    FOR ALL : RegFile use ENTITY work.RegFile(Behavioral);
    FOR ALL : ShiftBranch use ENTITY work.ShiftBranch(Behavioral);
    FOR ALL : ShiftJump use ENTITY work.ShiftJump(Behavioral);
    FOR ALL : SignExtension use ENTITY work.SignExtension(Behavioral);
    FOR ALL : JumpMux use ENTITY work.JumpMux(Behavioral);
    
    signal InitialPCSignal : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal pc_out_signal : STD_LOGIC_VECTOR(15 downto 0);
--    signal InstAddressSignal : STD_LOGIC_VECTOR(15 downto 0);
    signal InstDataSignal : STD_LOGIC_VECTOR(15 downto 0);
    signal InstInAdderSignal : STD_LOGIC_VECTOR(15 downto 0);
    signal InstOutAdderSignal : STD_LOGIC_VECTOR(15 downto 0);
    
    signal InstRsMuxSignal : STD_LOGIC_VECTOR(3 downto 0);
    signal InstRtMuxSignal : STD_LOGIC_VECTOR(3 downto 0);
    signal InstRdMuxSignal : STD_LOGIC_VECTOR(3 downto 0);
    
    signal WriteRegisterSignalReg : STD_LOGIC_VECTOR(3 downto 0); 
    signal Instruction_Adder_Component_Signal : STD_LOGIC_VECTOR(15 downto 0);
    signal SignExtendedSignal : STD_LOGIC_VECTOR(15 downto 0);
    
begin

    
    PC_ComponentCall : PC_Component
    PORT MAP(
        clk => clk,
        pc_in  => InitialPCSignal,
        pc_out  => pc_out_signal
    );
    
    InstructionMemoryCall : InstructionMemory
     PORT MAP(
        InstAddress => pc_out_signal,
        InstData  => InstDataSignal
    );
    
     Instruction_Adder_ComponentCall : Instruction_Adder_Component
     PORT MAP(
        InstIn => pc_out_signal,
        InstOut  => Instruction_Adder_Component_Signal
    );
    
    InstRtMuxSignal <= InstDataSignal(7 downto 4);
    InstRdMuxSignal <= InstDataSignal(3 downto 0);
    
     InstMemToRegMuxCall : InstMemToRegMux
     PORT MAP(
        RegDst => RegDst,
        Inst1Rs  => InstRtMuxSignal,
        Inst2Rd  => InstRdMuxSignal,
        MuxOut => WriteRegisterSignalReg
    );
    
     SignExtensionCall : SignExtension
     PORT MAP(
        DataIn => InstRdMuxSignal, --Rd
        ExtendedData  => SignExtendedSignal
    );
    
     ShiftBranchCall : ShiftBranch
     PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
    
    
     BranchJumpAdderCall : BranchJumpAdder
     PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
     ShiftJumpCall : ShiftJump
     PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );

  RegFileCall : RegFile
     PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
     ALUMuxCall  : ALUMux
     PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
    ALUCall : ALU 
    PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
    

    DataMemoryCall : DataMemory 
    PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    
    MemToRegMuxCall : MemToRegMux 
    PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );

    BranchMuxCall : BranchMux 
    PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );

    JumpMuxCall : JumpMux 
    PORT MAP(
        clk => clk,
        RS  => RS,
        RT  => RT,
        RD  => RD,
        Result => Result,
        RegWr => RegWr,
        busA => busA,
        busB => busB
    );
    

end Structural;
