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
           walking_request : in STD_LOGIC;
           reprogram : in STD_LOGIC;
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           clock : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (6 downto 0)
          );
           
end Labkit;


architecture Behavioral of Labkit is
component FSM is
    Port ( 
           WR : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           expired : in STD_LOGIC;
           sensor_sync : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           clk : in STD_LOGIC;
           WR_Reset : out STD_LOGIC;
           interval : out STD_LOGIC_VECTOR (1 downto 0);
           start_time : out STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component;

component synchronizer is
    Port(  reset : in STD_LOGIC;
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
    Port(  WR_Sync : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           WR : out STD_LOGIC);
end component;

component time_parameters is
    Port(  clk : in std_logic;
           prog_sync : in STD_LOGIC;
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component clock_divider is
    Port(  clk      : in std_logic;
           reset    : in std_logic;
           one_hz_enable: out std_logic);
end component;

component timer is
    Port(  one_hz_enable : in STD_LOGIC;
           start_timer : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           expired : out STD_LOGIC);
end component;

signal reset_sync : STD_LOGIC;
signal sensor_sync : STD_LOGIC;
signal wr_sync : STD_LOGIC;
signal WR : STD_LOGIC;
signal WR_Reset : STD_LOGIC;
signal prog_sync : STD_LOGIC;
signal start_time : STD_LOGIC;
signal expired : STD_LOGIC;
signal interval : STD_LOGIC_VECTOR ( 1 downto 0 );
signal value : STD_LOGIC_VECTOR ( 3 downto 0 );
signal one_hz_enable : STD_LOGIC;



begin
FSM_1 : FSM
port map (     sensor_sync => sensor_sync,
               WR => WR,
               prog_sync => prog_sync,
               Reset_Sync => reset_sync,
               clk => clock,
               WR_Reset => WR_Reset,
               expired => expired,
               interval => interval,
               start_time => start_time,
               leds => leds);

synchronizer_1 : synchronizer
port map(
           reset => reset,
           sensor => sensor,
           walk_request => walking_request,
           reprogram => reprogram,
           clk => clock,
           reset_sync => reset_sync,
           sensor_sync => sensor_sync,
           wr_sync => wr_sync,
           prog_sync => prog_sync
);

walk_register_1 : walk_register
port map( 
           WR_Sync => wr_sync,
           WR_Reset => WR_Reset,
           WR => WR);

time_parameters_1 : time_parameters
port map(
clk => clock,
           prog_sync => prog_sync,
           time_parameter_selector => time_parameter_selector,
           interval => interval,
           time_value => time_value,
           value => value
);   

clock_divider_1 : clock_divider
port map(
           clk => clock,
           reset => reset_sync,
           one_hz_enable => one_hz_enable
);  

timer_1 : timer
port map(
           one_hz_enable => one_hz_enable,
           start_timer => start_time,
           value => value,
           expired => expired
);       

end Behavioral;
