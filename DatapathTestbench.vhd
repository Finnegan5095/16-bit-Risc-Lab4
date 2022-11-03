library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DatapathTestbench is
end DatapathTestbench;

architecture structural of DatapathTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type ALUOpCode_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    constant ALUOpCode_vals : ALUOpCode_array := ("0110", "0111");
    
    type ReadData1_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    constant ReadData1_vals : ReadData1_array := ("0000000011110000","0000000000001111");
    
    type RegToALUMuxIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    constant RegToALUMuxIn_vals : RegToALUMuxIn_array := ("0000000011110000","0000000000001111");
   
    
   
    signal clk_sig : std_logic := '0'; 
    signal RegDstSig : std_logic := '0';
    signal JumpSig : std_logic := '0';
    signal BranchSig : std_logic := '1';
    signal MemReadSig : std_logic := '0';
    signal MemToRegSig : std_logic := '0';
    signal MemWriteSig : std_logic := '0';
    signal ALUSrcSig : std_logic := '1';
    signal RegWriteSig : std_logic := '0';
    signal ALUctrOpCodeSig : std_logic_vector (3 downto 0) := "1100";

   
   
    begin
    DUT : entity work.Datapath(structural) port map (
                                             clk => clk_sig,
                                             RegDst => RegDstSig,
                                             Jump => JumpSig,
                                             Branch => BranchSig,
                                             MemRead => MemReadSig,
                                             MemToReg => MemToRegSig,
                                             MemWrite => MemWriteSig,
                                             ALUSrc => ALUSrcSig,
                                             RegWrite => RegWriteSig,
                                             ALUctrOpCode => AluctrOpCodeSig
                                             );


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
              --ReadData1Sig <= ReadData1_vals(i);
              --RegToALUMuxInSig <= RegToALUMuxIn_vals(i);
              --ALUctrOpCodeSig <= ALUOpCode_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end structural;
