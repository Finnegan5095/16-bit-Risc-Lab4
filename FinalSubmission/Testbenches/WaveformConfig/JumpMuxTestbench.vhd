library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity JumpMuxTestbench is
end JumpMuxTestbench;

architecture behavior of JumpMuxTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type DataIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant DataIn_vals : DataIn_array := ("0011","1100");
   
    
    signal jump_sig : std_logic := '1';
    signal clk_sig : std_logic := '0';
    signal ShiftJumpSignalOutSignal : std_logic_vector(12 downto 0) := "0000011110000";
    signal PCMostSigSignal : std_logic_vector(2 downto 0) := "000";
    signal BranchMuxInSignal : std_logic_vector(15 downto 0) := "0000000000010010";
    signal PCOutSignal : std_logic_vector(15 downto 0) := "0000000000000000";
    
    begin
    DUT : entity work.JumpMux(behavioral) port map (
                                             Jump => jump_sig,
                                             ShiftJumpSignalOut => ShiftJumpSignalOutSignal,
                                             PCMostSig => PCMostSigSignal,
                                             BranchMuxIn => BranchMuxInSignal,
                                             PCOut => PCOutSignal);


        clock : process
          begin
            for i in 0 to 2 * (NUM_VALS) loop
              clk_sig <= NOT clk_sig;
              wait for TIME_DELAY/2;
            end loop;
            wait;
          end process clock;
 
         stimulus : process
          begin
            for i in 0 to (NUM_VALS - 1) loop
              --Inst1RsSig <= Inst1RsSig;
              --Inst2RdSig <= Inst2RdSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
