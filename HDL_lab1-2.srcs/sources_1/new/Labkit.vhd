----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 05:11:00 AM
-- Design Name: 
-- Module Name: Labkit - Behavioral
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

entity Labkit is
    Port ( reset : in STD_LOGIC;
           sensor : in STD_LOGIC;
           WR : in STD_LOGIC;
           reprogram : in STD_LOGIC;
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           clock : in STD_LOGIC;
           
           expired : inout STD_LOGIC;
           one_hz_enable : inout STD_LOGIC;
           
           leds : out STD_LOGIC_VECTOR (6 downto 0)
          );
           
end Labkit;


architecture Behavioral of Labkit is
component FSM is
    Port ( sensor_sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           expired : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           
           interval : out STD_LOGIC_VECTOR (1 downto 0);
           start_time : out STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component;

component synchronizer is
    Port(   reset : in STD_LOGIC;
           sensor : in STD_LOGIC;
           walk_request : in STD_LOGIC;
           reprogram : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset_sync : out STD_LOGIC;
           sensor_sync : out STD_LOGIC;
           wr_sync : out STD_LOGIC;
           prog_sync : out STD_LOGIC);
end component;

component walk_register is
    Port(  clk : in std_logic;
           WR_Sync : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           WR : out STD_LOGIC);
end component;

signal reset_sync : STD_LOGIC;
signal sensor_sync : STD_LOGIC;
signal wr_sync : STD_LOGIC;
signal prog_sync : STD_LOGIC;
signal start_time : STD_LOGIC;
signal interval : STD_LOGIC_VECTOR ( 1 downto 0 );
signal value : STD_LOGIC_VECTOR ( 3 downto 0 );



begin
FSM_1 : FSM
port map ( sensor_sync => sensor_sync,
               WR => WR,
               prog_sync => prog_sync,
               WR_Reset => reset_sync,
               expired => expired,
               interval => interval,
               start_time => start_time,
               leds => leds);


end Behavioral;
