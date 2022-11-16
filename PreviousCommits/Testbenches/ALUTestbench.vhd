library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUTestbench is
end ALUTestbench;

architecture behavior of ALUTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type ALUOpCode_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    constant ALUOpCode_vals : ALUOpCode_array := ("0110", "0111");
    
    type ReadData1_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    constant ReadData1_vals : ReadData1_array := ("0000000011110000","0000000000001111");
    
    type RegToALUMuxIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    constant RegToALUMuxIn_vals : RegToALUMuxIn_array := ("0000000011110000","0000000000001111");
   
    signal ReadData1Sig : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal RegToALUMuxInSig : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal ALUResultOutSig : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal ALUctrOpCodeSig : std_logic_vector (3 downto 0) := "0010";
    signal ZeroSig : std_logic := '0';
    signal clk_sig : std_logic := '0';
   
   
    begin
    DUT : entity work.ALU(behavior) port map (
                                             ReadData1 => ReadData1Sig,
                                             RegToALUMuxIn => RegToALUMuxInSig,
                                             ALUResultOut => ALUResultOutSig,
                                             ALUctrOpCode => ALUctrOpCodeSig,
                                             Zero => ZeroSig);


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
              ReadData1Sig <= ReadData1_vals(i);
              RegToALUMuxInSig <= RegToALUMuxIn_vals(i);
              ALUctrOpCodeSig <= ALUOpCode_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
