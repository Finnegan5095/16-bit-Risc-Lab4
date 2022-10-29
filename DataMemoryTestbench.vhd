library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DataMemoryTestbench is
end DataMemoryTestbench;

architecture behavior of DataMemoryTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type InstAddress_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant InstAddress_vals : InstAddress_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal ZeroSig : std_logic := '0';
    signal MemWriteSig : std_logic := '0';
    signal MemReadSig : std_logic := '1';
    signal WriteDataSig : std_logic_vector (15 downto 0) := "0000000000000000";
    signal ALUResultSig : std_logic_vector (15 downto 0) := "0000000000000011";
    signal ReadDataSig : std_logic_vector (15 downto 0) := "0000000000000000";
    begin
    DUT : entity work.DataMemory(behavioral) port map (
                                             Zero => ZeroSig,
                                             WriteData => WriteDataSig,
                                             ALUResult => ALUResultSig,
                                             MemWrite => MemWriteSig,
                                             MemRead => MemReadSig);


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
              ZeroSig <= ZeroSig;
              WriteDataSig <= WriteDataSig;
              ALUResultSig <= ALUResultSig;
              ReadDataSig <= ReadDataSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
