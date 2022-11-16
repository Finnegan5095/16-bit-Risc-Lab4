----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2022 04:02:45 PM
-- Design Name: 
-- Module Name: PC_Component - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
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
process (clk)
	begin
	--if rising_edge(clk) then 
	if falling_edge(clk) then --Ask Rob about rising/falling edge for pc counter.
		pc_out <= pc_in;
	--else
	   --pc_out <= pc_out;
	end if;
	   
end process;
end Behavioral;


