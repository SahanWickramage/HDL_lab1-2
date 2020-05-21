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
           -- value : in std_logic_vector (3 downto 0); internal
           start_t : in std_logic;
           -- sensor : in STD_LOGIC;
           -- walking_request : in STD_LOGIC;
           -- reprogram : in STD_LOGIC;
           prog_sync : in STD_LOGIC;
           interval : in STD_LOGIC_vector (1 downto 0);
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           clock : in STD_LOGIC;
           -- leds : out STD_LOGIC_VECTOR (2 downto 0);
           -- on_hz : out std_logic := '0';
           ex : out std_logic := '0');
           
end Labkit;

architecture Behavioral of Labkit is

component clock_divider is
    port ( clk      : in std_logic;
           reset    : in std_logic;
           one_hz_enable: out std_logic := '0');
end component;

component timer is
    Port ( one_hz_enable : in STD_LOGIC;
           start_timer : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR (3 downto 0);
           expired : out STD_LOGIC := '0');
end component;

component time_parameters is
    Port ( clk : in std_logic;
           prog_sync : in STD_LOGIC;
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal one_hz : STD_LOGIC;
signal value : STD_LOGIC_VECTOR (3 downto 0);

begin
     
divider : clock_divider
port map ( clk => clock,
           reset => reset,
           one_hz_enable => one_hz);
           
timer1 : timer
port map ( one_hz_enable => one_hz,
           start_timer => start_t,
           value => value,
           expired => ex);
           
time_para : time_parameters
port map( clk => clock,
      prog_sync : in STD_LOGIC;
      time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
      interval : in STD_LOGIC_VECTOR (1 downto 0);
      time_value : in STD_LOGIC_VECTOR (3 downto 0);
      value : out STD_LOGIC_VECTOR (3 downto 0));

end Behavioral;