----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
 
-- Create Date: 10/22/2022 04:02:45 PM
-- Design Name: 
-- Module Name: PC_Component - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
 
-- Dependencies: 
 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PC_Component is
    Port ( clk : in  STD_LOGIC;
           pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
           pc_out : inout  STD_LOGIC_VECTOR (15 downto 0));
end PC_Component;

architecture Behavioral of PC_Component is

begin

process (clk, pc_in)
    variable temp : std_logic_vector(15 downto 0) := "0000000000000000";
	begin
	--if rising_edge(clk) then 
	if falling_edge(clk) then
	   temp := pc_in;
	else
	   temp := temp;
	   --pc_out <= pc_in ;--after 49ns;
	end if;
    pc_out <= temp;-- after 49ns;   
end process;
end Behavioral;


