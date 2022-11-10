library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ShiftJumpTestbench is
end ShiftJumpTestbench;

architecture behavior of ShiftJumpTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type ShiftAddress_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(11 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant ShiftAddress_vals : ShiftAddress_array := ("000000100111","000000011010");
   
    

    signal clk_sig : std_logic := '0';
    signal ShiftAddressSig : std_logic_vector (11 downto 0) := "000000000000";
    signal ShiftOutSig : std_logic_vector (12 downto 0) := "0000000000000";
    begin
    DUT : entity work.ShiftJump(behavioral) port map (
                                             ShiftAddress => ShiftAddressSig,
                                             ShiftOut => ShiftOutSig);


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
              ShiftAddressSig <= ShiftAddress_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
