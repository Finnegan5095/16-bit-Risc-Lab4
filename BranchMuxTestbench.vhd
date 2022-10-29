library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BranchMuxTestbench is
end BranchMuxTestbench;

architecture behavior of BranchMuxTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type InstAddress_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant InstAddress_vals : InstAddress_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal PCSrcSig : std_logic := '0';
    signal NextPCSig : std_logic_vector (15 downto 0) := "0000000000000000";
    signal PCPlusFourSig : std_logic_vector (15 downto 0) := "0000000000001001";
    signal BranchALUResultSig : std_logic_vector (15 downto 0) := "0000000000000011";
    begin
    DUT : entity work.BranchMux(behavioral) port map (
                                             PCPlusFour => PCPlusFourSig,
                                             BranchALUResult => BranchALUResultSig,
                                             PCSrc => PCSrcSig,
                                             NextPC => NextPCSig);


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
              PCPlusFourSig <= PCPlusFourSig;
              BranchALUResultSig <= BranchALUResultSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
