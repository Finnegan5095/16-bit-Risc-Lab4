library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DatapathTestbench is
end DatapathTestbench;

architecture structural of DatapathTestbench is
    constant TIME_DELAY : time := 40 ns;
    constant NUM_VALS : integer := 39;
     
    signal clk_sig : std_logic := '0'; 
      
    begin
    DUT : entity work.Datapath(structural) port map (
                                             clk => clk_sig
                                             );


        clock : process
          begin
            for i in 0 to 2 * (NUM_VALS) loop
              clk_sig <= NOT clk_sig;
              wait for TIME_DELAY/2;
            end loop;
            wait;
          end process clock;
 
--         stimulus : process
--          begin
--            for i in 0 to (NUM_VALS - 1) loop
--              --ReadData1Sig <= ReadData1_vals(i);
--              --RegToALUMuxInSig <= RegToALUMuxIn_vals(i);
--              --ALUctrOpCodeSig <= ALUOpCode_vals(i);
--              wait for TIME_DELAY;
--            end loop;
--            wait;
--  end process stimulus;
        
 

end structural;
