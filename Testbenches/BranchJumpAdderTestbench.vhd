library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BranchJumpAdderTestbench is
end BranchJumpAdderTestbench;

architecture behavior of BranchJumpAdderTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type InstAddress_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant InstAddress_vals : InstAddress_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal ShiftInputSig : std_logic_vector (15 downto 0) := "0000000000001010";
    signal PCAddressSig : std_logic_vector (15 downto 0) := "0000000000001111";   
    signal ALUResultSig : std_logic_vector (15 downto 0) := "0000000000000000";
    
    begin
    DUT : entity work.BranchJumpAdder(behavioral) port map (
                                             ShiftInput =>  ShiftInputSig,
                                             PCAddress => PCAddressSig,
                                             ALUResult => ALUResultSig);


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
              ShiftInputSig <= ShiftInputSig;
              PCAddressSig <= PCAddressSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
