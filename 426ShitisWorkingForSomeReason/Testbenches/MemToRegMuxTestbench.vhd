library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MemToRegMuxTestbench is
end MemToRegMuxTestbench;

architecture behavior of MemToRegMuxTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    --type InstAddress_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    --constant InstAddress_vals : InstAddress_array := ("0000000000000000","0000000000000001");
   
    

    signal clk_sig : std_logic := '0';
    signal ReadDataMemSig : std_logic_vector (15 downto 0) := "0000000000011110";
    signal ALUResultSig : std_logic_vector (15 downto 0) := "0000000000111100";
    signal MemToRegSig : std_logic := '0';
    signal MemToRegMuxOut : std_logic_vector (15 downto 0) := "0000000000000000";
    
    begin
    DUT : entity work.MemToRegMux(behavioral) port map (
                                           ReadDataMem  => ReadDataMemSig,
                                           ALUResult => ALUResultSig, 
                                           MemToReg => MemToRegSig,  
                                           MemToRegMuxOut => MemToRegMuxOut);
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
              ReadDataMemSig <= ReadDataMemSig;
              ALUResultSig <= ALUResultSig;
              MemToRegSig <= MemToRegSig;
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
