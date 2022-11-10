library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlUnitTestbench is
end ControlUnitTestbench;

architecture behavioral of ControlUnitTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 16;
    
    
    type OpCode_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    constant OpCode_vals : OpCode_array := ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111");
    
--    type ReadData1_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
--    constant ReadData1_vals : ReadData1_array := ("0000000011110000","0000000000001111");
    
--    type RegToALUMuxIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
--    constant RegToALUMuxIn_vals : RegToALUMuxIn_array := ("0000000011110000","0000000000001111");
    signal InstOpCodeSig : std_logic_vector (3 downto 0) := "0000";
    signal ALUOpCodeSig : std_logic_vector (3 downto 0) := "0000";
    signal clk_sig : std_logic := '0'; 
    signal RegDstSig : std_logic := '0';
    signal JumpSig : std_logic := '0';
    signal BranchSig : std_logic := '0';
    signal MemReadSig : std_logic := '0';
    signal MemToRegSig : std_logic := '0';
    signal MemWriteSig : std_logic := '0';
    signal ALUSrcSig : std_logic := '0';
    signal RegWriteSig : std_logic := '0';
   
   
    begin
    DUT : entity work.ControlUnit(behavioral) port map (
                                             InstOpCode => InstOpCodeSig,
                                             ALUOpCode => ALUOpCodeSig,
                                             RegDst => RegDstSig,
                                             Jump => JumpSig,
                                             Branch => BranchSig,
                                             MemRead => MemReadSig,
                                             MemToReg => MemToRegSig,
                                             MemWrite => MemWriteSig,
                                             ALUSrc => ALUSrcSig,
                                             RegWrite => RegWriteSig
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
              InstOpCodeSig <= OpCode_vals(i);
             
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavioral;
