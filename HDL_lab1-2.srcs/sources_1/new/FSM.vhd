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
    Port ( sensor : in STD_LOGIC;
           WR : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           expired : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           clk : in STD_LOGIC;
           
           interval : out STD_LOGIC_VECTOR (1 downto 0);
           WR_Reset : out STD_LOGIC;
           start_time : out STD_LOGIC;
           Rm : out STD_LOGIC;
           Ym : out STD_LOGIC;
           Gm : out STD_LOGIC;
           Rs : out STD_LOGIC;
           Ys : out STD_LOGIC;
           Gs : out STD_LOGIC;
           walk : out STD_LOGIC
           );
end FSM;

-- Architecture definition for the FSM entity
Architecture Behavioral of FSM is
TYPE State_type IS (A, B, C, D, E);  -- Define the states
SIGNAL State : State_Type;    -- Create a signal that uses 
signal count: integer         := 0;
							      -- the different 
							      
begin

process (Reset_Sync, prog_sync) --resetting process
begin

    if Reset_Sync = '1' or prog_sync = '1' then
       State <= A;
       count <= 2;
       interval <= "00";
       start_time <= '1';
       start_time <= '0' after 20 ns; 
    end if;

end process;

PROCESS (clk, sensor, expired, WR) 
    BEGIN
    
    if rising_edge(clk) then
        CASE State IS
                -- If the current state is A and P is set to 1, then the
                -- next state is B
                WHEN A =>	    
                    IF expired = '1' THEN
                        IF count = 2 THEN
                            IF sensor = '1' THEN 
                                State <= A;
                                count <= 0;
                                interval <= "01";
                                start_time<='1';
                                start_time <= '0' after 20 ns;
                             ELSE
                                State <= A;
                                count <= 1;
                                interval <= "00";
                                start_time<='1';
                                start_time <= '0' after 20 ns;
                             END IF;
                             
                        END IF;
                        
                        ELSIF (count = 1 and sensor = '0') THEN
                            State <= B;
                            count <= 0;
                            interval <= "10";
                            start_time<='1';
                            start_time <= '0' after 20 ns;
                        
                    END IF;
    
                WHEN B => 
                    IF expired = '1' THEN 
                        IF WR = '1' THEN
                            State <= E;
                            interval <= "01";
                            start_time<='1';
                            start_time <= '0' after 20 ns;
                        ELSE
                            State <= C;
                            interval <= "00";
                            start_time<='1';
                            start_time <= '0' after 20 ns;
                        END IF;
                    END IF; 
                    
                WHEN C => 
                    IF expired = '1' THEN 
                        IF sensor = '1' THEN 
                             State <= C;
                             interval <= "01";
                             start_time<='1';
                             start_time <= '0' after 20 ns;
                          ELSE
                             State <= D;
                             interval <= "10";
                             start_time<='1';
                             start_time <= '0' after 20 ns;
                          END IF;
                    END IF; 
        
                WHEN D => 
                    IF expired = '1' THEN 
                        State <= A;
                        count <= 2;
                        interval <= "00";
                        start_time <= '1';
                        start_time <= '0' after 20 ns; 
                    END IF;
                    
                WHEN E => 
                    IF expired = '1' THEN 
                        State <= C;
                        interval <= "00";
                        start_time<='1';
                        start_time <= '0' after 20 ns;
                    END IF; 
    
        END CASE; 
    end if;
    
    END PROCESS;
    
PROCESS
    BEGIN
    CASE State IS
        WHEN A => 
			   Rm <= '0';
               Ym <= '0';
               Gm <= '1';
               Rs <= '1';
               Ys <= '0';
               Gs <= '0';
               walk <= '0';
               
         WHEN B => 
			   Rm <= '0';
               Ym <= '1';
               Gm <= '0';
               Rs <= '1';
               Ys <= '0';
               Gs <= '0';
               walk <= '0';
               
         WHEN C => 
			   Rm <= '1';
               Ym <= '0';
               Gm <= '0';
               Rs <= '1';
               Ys <= '0';
               Gs <= '1';
               walk <= '0';
         
         WHEN D => 
			   Rm <= '1';
               Ym <= '0';
               Gm <= '0';
               Rs <= '0';
               Ys <= '1';
               Gs <= '0';
               walk <= '0';
               
         WHEN E => 
			   Rm <= '1';
               Ym <= '0';
               Gm <= '0';
               Rs <= '1';
               Ys <= '0';
               Gs <= '0';
               walk <= '1';
    
    END CASE;
END PROCESS;
end Behavioral;
