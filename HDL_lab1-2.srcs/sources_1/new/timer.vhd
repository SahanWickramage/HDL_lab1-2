----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 11:43:43 AM
-- Design Name: 
-- Module Name: timer - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
    Port ( one_hz_enable : in STD_LOGIC;
           start_timer : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           expired : out STD_LOGIC := '0');
end timer;

architecture Behavioral of timer is
    signal count: integer            := 0;
    signal previous_state: std_logic := '0';
    signal timer_running: std_logic  := '0';

begin
-- process (start_timer)
-- begin
--    if (start_timer = '1' and timer_running = '0') then
--        count := to_integer(unsigned(value));
--        timer_running <= '1';
--    end if;
-- end process;

process (one_hz_enable, value, start_timer)
begin
    if (start_timer = '1' and timer_running = '0') then
        count <= to_integer(unsigned(value));
        timer_running <= '1';
        previous_state <= '0';
    end if;

    if timer_running = '1' then
        if (one_hz_enable = '1' and previous_state = '0') then
            if count = 0 then
                timer_running <='0';
                previous_state <= '0';
                expired <= '1';
                expired <= '0' after 75 ns;
            else
                previous_state <= '1';
                count <= count - 1;
            end if;
        elsif (one_hz_enable = '0' and previous_state = '1') then
            previous_state <= '0';
        end if;
    end if;
end process;

end Behavioral;
