library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_testbench is
end PC_testbench;

architecture behavior of PC_testbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type pc_in_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant pc_in_vals : pc_in_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal pc_in_sig : std_logic_vector (15 downto 0) := "0000000000000000";
    signal pc_out_sig : std_logic_vector (15 downto 0) := "0000000000000000";
    begin
    DUT : entity work.PC_Component(behavioral) port map (
                                             clk => clk_sig,
                                             pc_in => pc_in_sig,
                                             pc_out => pc_out_sig);


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
              pc_in_sig <= pc_in_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
        
       
 
    
    

    

end behavior;
