library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity InstMemToRegMuxTestbench is
end InstMemToRegMuxTestbench;

architecture behavior of InstMemToRegMuxTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type DataIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant DataIn_vals : DataIn_array := ("0011","1100");
   
    

    signal clk_sig : std_logic := '0';
    signal RegDstSig : std_logic := '0';
    signal Inst1RsSig : std_logic_vector (3 downto 0) := "0010";
    signal Inst2RdSig : std_logic_vector (3 downto 0) := "0100";
    signal MuxOutSig : std_logic_vector (3 downto 0) := "0000";
    begin
    DUT : entity work.InstMemToRegMux(behavioral) port map (
                                             RegDst => RegDstSig,
                                             Inst1Rs => Inst1RsSig,
                                             Inst2Rd => Inst2RdSig,
                                             MuxOut => MuxOutSig);


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
              Inst1RsSig <= Inst1RsSig;
              Inst2RdSig <= Inst2RdSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
