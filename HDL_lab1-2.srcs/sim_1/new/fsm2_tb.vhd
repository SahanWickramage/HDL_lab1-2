library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm2_tb is
end;

architecture bench of fsm2_tb is

  component fsm2
      Port ( clk : in STD_LOGIC;
             expired : in STD_LOGIC;
             sensor_sync : in std_logic;
             wr : in std_logic;
             prog_sync : in std_logic;
             reset_sync : in std_logic;
             led_values : out STD_LOGIC_VECTOR (2 downto 0) := "000";
             interval: out std_logic_vector (1 downto 0) := "00";
             wr_reset: out std_logic := '0';
             start_timer: out std_logic := '0');
  end component;

  signal clk: STD_LOGIC;
  signal expired: STD_LOGIC;
  signal sensor_sync: std_logic;
  signal wr: std_logic;
  signal prog_sync: std_logic;
  signal reset_sync: std_logic;
  signal led_values: STD_LOGIC_VECTOR (2 downto 0) := "000";
  signal interval: std_logic_vector (1 downto 0) := "00";
  signal wr_reset: std_logic := '0';
  signal start_timer: std_logic := '0';

begin

  uut: fsm2 port map ( clk         => clk,
                       expired     => expired,
                       sensor_sync => sensor_sync,
                       wr          => wr,
                       prog_sync   => prog_sync,
                       reset_sync  => reset_sync,
                       led_values  => led_values,
                       interval    => interval,
                       wr_reset    => wr_reset,
                       start_timer => start_timer );

  stimulus: process
  begin
  
    -- Put initialisation code here
    expired <= '0'; -- init
    expired <= '1' after 70 ns; -- stay at A
    expired <= '0' after 90 ns;
    expired <= '1' after 100 ns; -- goto B
    expired <= '0' after 20 ns;
    expired <= '1' after 80 ns; -- goto C
    expired <= '0' after 20 ns;
    expired <= '1' after 80 ns; -- goto D
    expired <= '0' after 20 ns;
    expired <= '1' after 80 ns; -- goto A
    expired <= '0' after 20 ns;
    expired <= '1' after 80 ns; -- stay at A
    expired <= '0' after 20 ns;

    -- Put test bench stimulus code here

    wait;
  end process;
  
  clocking: process
  begin
     clk <= '0', '1' after 50 ns;
     wait for 100 ns;
  end process;


end;