library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Instruction_Adder_Testbench is
end Instruction_Adder_Testbench;

architecture behavior of Instruction_Adder_Testbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type InstIn_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant InstIn_vals : InstIn_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal InstInSig : std_logic_vector (15 downto 0) := "0000000000000000";
    signal InstOutSig : std_logic_vector (15 downto 0) := "0000000000000000";
    begin
    DUT : entity work.Instruction_Adder_Component(behavioral) port map (
                                             InstIn => InstInSig,
                                             InstOut => InstOutSig);


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
              InstInSig <= InstIn_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
