library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegFileTestbench is
end RegFileTestbench;

architecture behavior of RegFileTestbench is
    constant TIME_DELAY : time := 20 ns;
    constant NUM_VALS : integer := 2;
    
    
    type ReadReg1_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    type ReadReg2_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(3 downto 0);
    --type pc_out_array is array(0 to (NUM_VALS - 1)) of std_logic_vector(15 downto 0);
  
    constant ReadReg1_vals : ReadReg1_array := ("0011","0001");
    constant ReadReg2_vals : ReadReg2_array := ("0101","0100");
   
    

    signal clk_sig : std_logic := '0';
    signal ReadReg1Sig : std_logic_vector (3 downto 0) := "0000";
    signal ReadReg2Sig : std_logic_vector (3 downto 0) := "0000";
    signal WriteRegSig : std_logic_vector (3 downto 0) := "1010";
    signal WriteDataSig : std_logic_vector (15 downto 0) := "0000000111100000";
    signal RegWriteControlSig : std_logic := '1';
    signal ReadData1Sig : std_logic_vector (15 downto 0) := "0000000111100000";
    signal ReadData2Sig : std_logic_vector (15 downto 0) := "0000000111100000";
   
    
    begin
    DUT : entity work.RegFile(behavioral) port map (
                                            clk => clk_sig,
                                            ReadReg1 => ReadReg1Sig,
                                            ReadReg2 => ReadReg2Sig,
                                            WriteReg => WriteRegSig,
                                            WriteData => WriteDataSig,
                                            RegWriteCtrl => RegWriteControlSig,
                                            ReadData1 => ReadData1Sig,
                                            ReadData2 => ReadData2Sig);


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
              ReadReg1Sig <= ReadReg1_vals(i);
              ReadReg2Sig <= ReadReg2_vals(i);
              wait for TIME_DELAY;
            end loop;
            wait;
  end process stimulus;
        
 

end behavior;
