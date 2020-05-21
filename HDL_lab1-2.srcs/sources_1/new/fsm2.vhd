----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2020 08:30:51 PM
-- Design Name: 
-- Module Name: fsm2 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm2 is
    Port ( clk : in STD_LOGIC;
           expired : in STD_LOGIC;
           sensor_sync : in std_logic;
           wr : in std_logic;
           prog_sync : in std_logic;
           reset_sync : in std_logic;
           
           leds : out STD_LOGIC_VECTOR (6 downto 0) := "0011000";
           interval: out std_logic_vector (1 downto 0) := "00";
           wr_reset: out std_logic := '0';
           start_timer: out std_logic := '0');
end fsm2;

architecture Behavioral of fsm2 is
    type state_type is (A, B, C, D, E);  -- Define the states
    signal current_state : state_type := A; 
    -- signal count: integer := 2;
    signal is_first_turn : boolean := true;
    signal prev_state: std_logic := '0';
    constant high_time: time    := 75 ns;

begin

process(clk, expired, sensor_sync, wr, prog_sync, reset_sync)
begin
    if (prog_sync = '1' or reset_sync = '1') then
        prev_state <= clk;
        current_state <= A;
        leds <= "0011000";
        is_first_turn <= true;
        interval <= "00";
        start_timer <= '1';
        start_timer <= '0' after high_time;
    else
        if (clk = '1' and prev_state = '0') then
            prev_state <= '1';
            if expired = '1' then
                case current_state is
                    when A =>
                        if (is_first_turn = true and sensor_sync = '1') then
                            current_state <= A;
                            leds <= "0011000";
                            interval <= "01";
                            is_first_turn <= false;
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        elsif (is_first_turn = true and sensor_sync = '0') then
                            current_state <= A;
                            leds <= "0011000";
                            interval <= "00";
                            is_first_turn <= false;
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        else
                            current_state <= B;
                            leds <= "0100100";
                            interval <= "10";
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        end if;
                     when B =>
                        if wr = '1' then
                            current_state <= E;
                            leds <= "1001001";
                            interval <= "01";
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        else
                            current_state <= C;
                            leds <= "1000010";
                            interval <= "00";
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        end if;
                     when C =>
                        if sensor_sync = '1' then
                            current_state <= C;
                            leds <= "1000010";
                            interval <= "01";
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        else
                            current_state <= D;
                            leds <= "0100100";
                            interval <= "10";
                            start_timer <= '1';
                            start_timer <= '0' after high_time;
                        end if;
                     when D =>
                        current_state <= A;
                        leds <= "0011000";
                        is_first_turn <= true;
                        interval <= "00";
                        start_timer <= '1';
                        start_timer <= '0' after high_time;
                     when E => 
                        current_state <= C;
                        leds <= "1000010";
                        interval <= "00";
                        start_timer <= '1';
                        wr_reset <= '1';
                        wr_reset <= '0' after high_time;
                        start_timer <= '0';
                end case;
            end if;
        elsif (clk = '0' and prev_state = '1') then
            prev_state <= '0';
        end if;
    end if;
end process;

end Behavioral;
