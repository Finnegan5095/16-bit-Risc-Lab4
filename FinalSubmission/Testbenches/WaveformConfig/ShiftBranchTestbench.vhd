library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ShiftBranchTestbench is
end ShiftBranchTestbench;

architecture behavior of ShiftBranchTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type SignExtend_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant SignExtend_vals : SignExtend_array := ("0000000000000011","1111111111110011");
   
    

    signal clk_sig : std_logic := '0';
    signal SignExtendSig : std_logic_vector (15 downto 0) := "0000000000000000";
    signal ShiftOutBranchSig : std_logic_vector (15 downto 0) := "0000000000000000";
    begin
    DUT : entity work.ShiftBranch(behavioral) port map (
                                             SignExtend => SignExtendSig,
                                             ShiftOutBranch => ShiftOutBranchSig);


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
              SignExtendSig <= SignExtend_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
