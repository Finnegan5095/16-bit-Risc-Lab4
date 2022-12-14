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
--library UNISIM;
--use UNISIM.VComponents.all;

entity Datapath is
  Port (clk : in STD_LOGIC);
end Datapath;

architecture Structural of Datapath is

    Component ALU
        PORT (clk : in STD_LOGIC;
              ReadData1   : in STD_LOGIC_VECTOR(15 downto 0);
              RegToALUMuxIn   : in STD_LOGIC_VECTOR(15 downto 0);
              ALUctrOpCode  : in STD_LOGIC_VECTOR(3 downto 0);
              Zero    : out std_logic;
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
              Zero : in STD_LOGIC;
              Branch : in STD_LOGIC;
              --PCSrc  : in STD_LOGIC;
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
        Port (clk : in  STD_LOGIC;
              InstIn : in STD_LOGIC_VECTOR(15 downto 0);
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
              pc_out : inout  STD_LOGIC_VECTOR (15 downto 0));
    End Component; 

    Component RegFile
        Port (clk : in STD_LOGIC;
              InstData : in STD_LOGIC_VECTOR(15 downto 0);
              ReadReg1 : in STD_LOGIC_VECTOR(3 downto 0);
              ReadReg2 : in STD_LOGIC_VECTOR(3 downto 0);
              WriteReg : in STD_LOGIC_VECTOR(3 downto 0);
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
        Port (ShiftAddress : in STD_LOGIC_VECTOR(11 downto 0);
              ShiftOut    : out STD_LOGIC_VECTOR(12 downto 0));
    End Component; 
    
    Component SignExtension
        Port (DataIn : in STD_LOGIC_VECTOR(3 downto 0);
              ExtendedData : out STD_LOGIC_VECTOR(15 downto 0));
    End Component; 
    
    Component JumpMux
        Port (Jump : in STD_LOGIC; 
              --JumpAddressIn : in STD_LOGIC_VECTOR(15 downto 0);
              PCMostSig : in std_logic_vector(2 downto 0);
              ShiftJumpSignalOut : in std_logic_vector(12 downto 0);
              BranchMuxIn : in STD_LOGIC_VECTOR(15 downto 0);
              PCOut   : inout STD_LOGIC_VECTOR(15 downto 0));
    End Component;
    
    Component ControlUnit
        Port (InstOpCode : in STD_LOGIC_VECTOR(15 downto 0);
              RegDst  : out STD_LOGIC;
              Jump  : out STD_LOGIC;
              Branch  : out STD_LOGIC;
              MemRead  : out STD_LOGIC;
              MemToReg  : out STD_LOGIC;
              ALUOpCode  : out STD_LOGIC_VECTOR(3 downto 0);
              MemWrite  : out STD_LOGIC;
              ALUSrc  : out STD_LOGIC;
              RegWrite  : out STD_LOGIC);
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
    FOR ALL : ControlUnit use ENTITY work.ControlUnit(Behavioral);
    
    signal InitialPCSignal : STD_LOGIC_VECTOR(15 downto 0)                      := "0000000000000000";
    signal pc_out_signal : STD_LOGIC_VECTOR(15 downto 0)                        := "1111111111111111";
    signal InstDataSignal : STD_LOGIC_VECTOR(15 downto 0)                       := "0000000000000000";
    --signal InstInAdderSignal : STD_LOGIC_VECTOR(15 downto 0)                  := "0000000000000000";
    --signal InstOutAdderSignal : STD_LOGIC_VECTOR(15 downto 0)                 := "0000000000000000";
    --                                                                          
    signal InstRsMuxSignal : STD_LOGIC_VECTOR(3 downto 0)                       := "0000";
    signal InstRtMuxSignal : STD_LOGIC_VECTOR(3 downto 0)                       := "0000";
    signal InstRdMuxSignal : STD_LOGIC_VECTOR(3 downto 0)                       := "0000";
    --                                                                          
    signal WriteRegisterSignalReg : STD_LOGIC_VECTOR(3 downto 0)                := "0000"; 
    signal Instruction_Adder_Component_Signal : STD_LOGIC_VECTOR(15 downto 0)   := "0000000000000000";
    signal SignExtendedSignal : STD_LOGIC_VECTOR(15 downto 0)                   := "0000000000000000";
    signal JumpShifterSignal : STD_LOGIC_VECTOR(11 downto 0)                    := "000000000000";
    signal ReadReg1OutSignal : STD_LOGIC_VECTOR(15 downto 0)                    := "0000000000000000";
    signal ReadReg2OutSignal : STD_LOGIC_VECTOR(15 downto 0)                    := "0000000000000000";
    signal ALUMuxOutSignal : STD_LOGIC_VECTOR(15 downto 0)                      := "0000000000000000";
    signal ZeroSignal : STD_LOGIC                                               := '0';
    signal ALUResultsigOut : STD_LOGIC_VECTOR(15 downto 0)                      := "0000000000000000";
    signal DataMemorySignalOut : STD_LOGIC_VECTOR(15 downto 0)                  := "0000000000000000";
    signal MemToRegMuxOutSignal : STD_LOGIC_VECTOR(15 downto 0)                 := "0000000000000000";
    signal ShiftOutBranchSignal : STD_LOGIC_VECTOR(15 downto 0)                 := "0000000000000000";
    signal PCMostSig : STD_LOGIC_VECTOR(2 downto 0)                             := "000";
    signal BranchJumpAdderALUResult : STD_LOGIC_VECTOR(15 downto 0)             := "0000000000000000";
    signal ShiftJumpSignalOut : STD_LOGIC_VECTOR(12 downto 0)                   := "0000000000000";
    signal ZeroAndBranchSignal : STD_LOGIC                                      := '0';
    signal BranchMuxSignalOut : STD_LOGIC_VECTOR(15 downto 0)                   := "0000000000000000";
    signal JumpFullSignal : STD_LOGIC_VECTOR(15 downto 0)                       := "0000000000000000";
    signal PCOutSignal : STD_LOGIC_VECTOR(15 downto 0)                          := "1111111111111111";
    --                                                                          
    --Control Unit signals.                                                     
    signal OpCodeSignal : STD_LOGIC_VECTOR(3 downto 0)                          := "0000";
    signal ALUOpCodeSignal : STD_LOGIC_VECTOR(3 downto 0)                       := "0000";
    signal RegDstSignal : STD_LOGIC                                             := '0';
    signal JumpSignal : STD_LOGIC                                               := '0';
    signal BranchSignal : STD_LOGIC                                             := '0';
    signal MemReadSignal : STD_LOGIC                                            := '0';
    signal MemToRegSignal : STD_LOGIC                                           := '0';
    signal MemWriteSignal : STD_LOGIC                                           := '0';
    signal ALUSrcSignal : STD_LOGIC                                             := '0';
    signal RegWriteSignal : STD_LOGIC                                           := '0';
    
    
begin

    
    PC_ComponentCall : PC_Component
    PORT MAP(
        clk => clk,
        pc_in  => PCOutSignal,
        pc_out  => pc_out_signal
    );
    
    InstructionMemoryCall : InstructionMemory
     PORT MAP(
        InstAddress => pc_out_signal,
        InstData  => InstDataSignal
    );
    
    Instruction_Adder_ComponentCall : Instruction_Adder_Component
     PORT MAP(
        clk => clk,
        InstIn => pc_out_signal,
        InstOut  => Instruction_Adder_Component_Signal
    );
    
    ControlUnitCall : ControlUnit
     PORT MAP(
        InstOpCode => InstDataSignal,
        RegDst => RegDstSignal,
        Jump  => JumpSignal,
        Branch  => BranchSignal,
        MemRead => MemReadSignal,
        MemToReg => MemToRegSignal,
        ALUOpCode => ALUOpCodeSignal,
        MemWrite => MemWriteSignal,
        ALUSrc => ALUSrcSignal,
        RegWrite => RegWriteSignal
    );
    
    InstMemToRegMuxCall : InstMemToRegMux
     PORT MAP(
        RegDst => RegDstSignal,
        Inst1Rs  => InstDataSignal(7 downto 4),
        Inst2Rd  => InstDataSignal(3 downto 0),
        MuxOut => WriteRegisterSignalReg
    );
    
    SignExtensionCall : SignExtension
     PORT MAP(
        DataIn => InstDataSignal(3 downto 0), --Rd
        ExtendedData  => SignExtendedSignal
    );
    
    ShiftBranchCall : ShiftBranch
     PORT MAP(
        SignExtend => SignExtendedSignal,
        ShiftOutBranch  => ShiftOutBranchSignal
    );
    
    BranchJumpAdderCall : BranchJumpAdder
     PORT MAP(
        ShiftInput => ShiftOutBranchSignal,
        PCAddress  => Instruction_Adder_Component_Signal,
        ALUResult  => BranchJumpAdderALUResult
    );
    
    ShiftJumpCall : ShiftJump
     PORT MAP(
        ShiftAddress => InstDataSignal(11 downto 0),
        ShiftOut  => ShiftJumpSignalOut
    );

    RegFileCall : RegFile
     PORT MAP(
        clk => clk,
        InstData => InstDataSignal,
        ReadReg1  => InstDataSignal(11 downto 8),
        ReadReg2  => InstDataSignal(7 downto 4),
        WriteReg  => WriteRegisterSignalReg,
        WriteData => MemToRegMuxOutSignal,
        RegWriteCtrl => RegWriteSignal,
        ReadData1 => ReadReg1OutSignal,
        ReadData2 => ReadReg2OutSignal
    );
    
    ALUMuxCall  : ALUMux
     PORT MAP(
        ReadData2 => ReadReg2OutSignal,
        SignExtend  => SignExtendedSignal,
        ALUSrc  => ALUSrcSignal,
        ALUMuxOut => ALUMuxOutSignal
    );
    
    ALUCall : ALU 
    PORT MAP(
        clk => clk,
        ReadData1 => ReadReg1OutSignal,
        RegToALUMuxIn  => ALUMuxOutSignal,
        ALUctrOpCode  => ALUOpCodeSignal,
        Zero  => ZeroSignal,
        ALUResultOut => ALUResultsigOut
    );
    
    DataMemoryCall : DataMemory 
    PORT MAP(
        Zero => ZeroSignal,
        clk  => clk,
        WriteData  => ReadReg2OutSignal,
        ALUResult  => ALUResultsigOut,
        MemWrite => MemWriteSignal,
        MemRead => MemReadSignal,
        ReadData => DataMemorySignalOut
    );
    
    MemToRegMuxCall : MemToRegMux 
    PORT MAP(
        ReadDataMem => DataMemorySignalOut,
        ALUResult  => ALUResultsigOut,
        MemToReg  => MemToRegSignal,
        MemToRegMuxOut  => MemToRegMuxOutSignal
    );

    BranchMuxCall : BranchMux 
    PORT MAP(
        PCPlusFour => Instruction_Adder_Component_Signal,
        BranchALUResult  => BranchJumpAdderALUResult,
        Zero => ZeroSignal,
        Branch => BranchSignal,
        --PCSrc => ZeroAndBranchSignal ,
        NextPC => BranchMuxSignalOut 
    );

    JumpMuxCall : JumpMux 
    PORT MAP(
        Jump => JumpSignal,
        PCMostSig => Instruction_Adder_Component_Signal(15 downto 13),
        ShiftJumpSignalOut => ShiftJumpSignalOut,
        --JumpAddressIn  => PCMostSig & ShiftJumpSignalOut,
        BranchMuxIn  => BranchMuxSignalOut,
        PCOut => PCOutSignal 
    );
    
    --process (clk)
    --process (clk, PCOutSignal, InstDataSignal, Instruction_Adder_Component_Signal, ShiftJumpSignalOut, ZeroSignal, BranchSignal )
    --begin
    --if falling_edge(clk) then
    --     InitialPCSignal <= PCOutSignal;
    --end if;
    --if rising_edge(clk) then
    --if falling_edge(clk) then
       
           --InitialPCSignal <= PCOutSignal;
           --OpCodeSignal <= InstDataSignal(15 downto 12);
           --PCMostSig <= Instruction_Adder_Component_Signal(15 downto 13);
           --InstRsMuxSignal <= InstDataSignal(11 downto 8);
           --InstRtMuxSignal <= InstDataSignal(7 downto 4);
           --InstRdMuxSignal <= InstDataSignal(3 downto 0);
           --JumpShifterSignal <= InstDataSignal(11 downto 0);
           --JumpFullSignal <= PCMostSig & ShiftJumpSignalOut;
           --ZeroAndBranchSignal <= ZeroSignal and BranchSignal;    
           
        
    --end if;
    --end process;
    
    
end Structural;
