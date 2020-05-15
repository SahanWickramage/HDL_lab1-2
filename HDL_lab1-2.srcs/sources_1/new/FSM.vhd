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
           WR_Reset : in STD_LOGIC;
           expired : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           
           interval : out STD_LOGIC_VECTOR (1 downto 0);
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
							      -- the different 
							      
begin

PROCESS (sensor) 
    BEGIN
    CASE State IS
 			-- If the current state is A and P is set to 1, then the
			-- next state is B
			WHEN A => 			    
				IF (expired = '1' and sensor = '1') THEN 
					State <= A;
					interval <= "01";
					start_time<='1';
				END IF; 
				
				IF (expired = '0') THEN 
					State <= A;
				END IF;
				
				IF (expired = '1' and sensor = '0') THEN 
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
				
				IF (expired = '1' and sensor = '1') THEN 
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
