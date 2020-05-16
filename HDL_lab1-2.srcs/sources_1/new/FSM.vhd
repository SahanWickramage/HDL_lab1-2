----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2020 02:17:25 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( sensor_sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           expired : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           clk : in STD_LOGIC;
           
           interval : out STD_LOGIC_VECTOR (1 downto 0) := "00";
           WR_Reset : out STD_LOGIC := '0';
           start_time : out STD_LOGIC := '0';
           leds : out STD_LOGIC_VECTOR (6 downto 0) := "0011000"
           );
end FSM;

-- Architecture definition for the FSM entity
Architecture Behavioral of FSM is
TYPE State_type IS (A, B, C, D, E);  -- Define the states
SIGNAL State : State_Type;    -- Create a signal that uses 
signal count: integer         := 0;
							      -- the different 
							      
begin
PROCESS (clk, sensor_sync, expired, WR, Reset_Sync, prog_sync) 
    BEGIN
    
    if Reset_Sync = '1' or prog_sync = '1' then
       State <= A;
       leds <= "0011000";
       count <= 2;
       interval <= "00";
       start_time <= '1';
       start_time <= '0' after 20 ns;
    else
        if rising_edge(clk) then
            CASE State IS
                    WHEN A =>	    
                        IF expired = '1' THEN
                            IF count = 2 THEN
                                IF sensor_sync = '1' THEN 
                                    State <= A;
                                    leds <= "0011000";
                                    count <= 0;
                                    interval <= "01";
                                    start_time<='1';
                                    start_time <= '0' after 20 ns;
                                 ELSE
                                    State <= A;
                                    leds <= "0011000";
                                    count <= 1;
                                    interval <= "00";
                                    start_time<='1';
                                    start_time <= '0' after 20 ns;
                                 END IF;
                                 
                            END IF;
                            
                            ELSIF (count = 1 and sensor_sync = '0') THEN
                                State <= B;
                                leds <= "0101000";
                                count <= 0;
                                interval <= "10";
                                start_time<='1';
                                start_time <= '0' after 20 ns;
                            
                        END IF;
        
                    WHEN B => 
                        IF expired = '1' THEN 
                            IF WR = '1' THEN
                                State <= E;
                                leds <= "1001001";
                                interval <= "01";
                                start_time<='1';
                                start_time <= '0' after 20 ns;
                            ELSE
                                State <= C;
                                leds <= "1001010";
                                interval <= "00";
                                start_time<='1';
                                start_time <= '0' after 20 ns;
                            END IF;
                        END IF; 
                        
                    WHEN C => 
                        IF expired = '1' THEN 
                            IF sensor_sync = '1' THEN 
                                 State <= C;
                                 leds <= "1001010";
                                 interval <= "01";
                                 start_time<='1';
                                 start_time <= '0' after 20 ns;
                              ELSE
                                 State <= D;
                                 leds <= "1000100";
                                 interval <= "10";
                                 start_time<='1';
                                 start_time <= '0' after 20 ns;
                              END IF;
                        END IF; 
            
                    WHEN D => 
                        IF expired = '1' THEN 
                            State <= A;
                            leds <= "0011000";
                            count <= 2;
                            interval <= "00";
                            start_time <= '1';
                            start_time <= '0' after 20 ns; 
                        END IF;
                        
                    WHEN E => 
                        IF expired = '1' THEN 
                            State <= C;
                            leds <= "1001010";
                            interval <= "00";
                            start_time<='1';
                            start_time <= '0' after 20 ns;
                            WR_Reset <= '1';
                            WR_Reset <= '0' after 20 ns;
                        END IF; 
        
            END CASE; 
        end if;
    end if;
    
    END PROCESS;
end Behavioral;
