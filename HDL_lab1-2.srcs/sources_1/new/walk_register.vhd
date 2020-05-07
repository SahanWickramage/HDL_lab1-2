----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 04:37:23 PM
-- Design Name: 
-- Module Name: walk_register - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity walk_register is
    Port ( WR_Sync : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           WR : out STD_LOGIC);
end walk_register;

architecture Behavioral of walk_register is

signal wr_value : std_logic := '0';

begin

process (WR_sync, WR_Reset)
begin
    if (WR_Reset = '0') then
        wr_value <= '0';
    elsif (WR_sync = '0') then
        wr_value <= '1';
    end if;
    
    WR <= wr_value;
end process;    
    
end Behavioral;
