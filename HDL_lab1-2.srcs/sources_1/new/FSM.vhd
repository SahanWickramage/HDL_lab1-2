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
           WR_Reset : in STD_LOGIC;
           expired : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           
           interval : out STD_LOGIC_VECTOR (1 downto 0);
           start_time : out STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (6 downto 0)
           );
end FSM;

-- Architecture definition for the FSM entity
Architecture Behavioral of FSM is
TYPE State_type IS (A, B, C, D, E);  -- Define the states
	SIGNAL State : State_Type;    -- Create a signal that uses 
							      -- the different 
							      
begin

PROCESS (sensor_sync) 
    BEGIN
    CASE State IS
 			-- If the current state is A and P is set to 1, then the
			-- next state is B
			WHEN A => 			    
				IF (expired = '1' and sensor_sync = '1') THEN 
					State <= A;
					interval <= "01";
					start_time<='1';
				END IF; 
				
				IF (expired = '0') THEN 
					State <= A;
				END IF;
				
				IF (expired = '1' and sensor_sync = '0') THEN 
					State <= B;
					interval <= "01"; --tYELL
					start_time<='1';
				END IF; 

			WHEN B => 
				IF (expired = '0') THEN 
					State <= B;
				END IF;
				
				IF (WR = '1') THEN 
					State <= E;
					interval <= "01"; --tEXT
					start_time<='1';
				END IF;
				
				IF (expired = '1') THEN 
					State <= C;
					interval <= "01";
					start_time<='1';
				END IF; 
				
			WHEN C => 
				IF (expired = '0') THEN 
					State <= C;
				END IF;
				
				IF expired ='1' THEN 
					State <= D;
					interval <= "01";--tYELL
					start_time<='1';
				END IF; 
				
				IF (expired = '1' and sensor_sync = '1') THEN 
					State <= C;
					interval <= "01";--tEXT
					start_time<='1';
				END IF; 
 	
			WHEN D=> 
				IF (expired = '0') THEN 
					State <= D;
				END IF; 
				
				IF expired='1' THEN 
					State <= A; 
					interval <= "01";--2tBASE
					start_time<='1';
				END IF; 
				
			WHEN E=> 
				IF (expired = '0') THEN 
					State <= E;
				END IF; 
				
				IF expired='1' THEN 
					State <= C; 
					interval <= "01";--tBASE
					start_time<='1';
				END IF; 

		END CASE; 
    END PROCESS;
    
PROCESS
    BEGIN
    CASE State IS
        WHEN A => 
        leds <= "0011000";
               
         WHEN B => 
         leds <= "0101000";
               
         WHEN C => 
         leds <= "1001010";
         
         WHEN D => 
         leds <= "1000100";
			
         WHEN E => 
         leds <= "1001001";
			  
    END CASE;
END PROCESS;
end Behavioral;
