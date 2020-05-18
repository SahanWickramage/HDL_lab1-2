library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_tb is
end;

architecture bench of FSM_tb is

  component FSM
      Port ( sensor_sync : in STD_LOGIC;
             WR : in STD_LOGIC;
             Reset_Sync : in STD_LOGIC;
             expired : in STD_LOGIC;
             prog_sync : in STD_LOGIC;
             clk : in STD_LOGIC;
             interval : out STD_LOGIC_VECTOR (1 downto 0);
             WR_Reset : out STD_LOGIC;
             start_time : out STD_LOGIC;
             leds : out STD_LOGIC_VECTOR (6 downto 0)
             );
  end component;

  signal sensor_sync: STD_LOGIC;
  signal WR: STD_LOGIC;
  signal Reset_Sync: STD_LOGIC;
  signal expired: STD_LOGIC;
  signal prog_sync: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal interval: STD_LOGIC_VECTOR (1 downto 0);
  signal WR_Reset: STD_LOGIC;
  signal start_time: STD_LOGIC;
  signal leds: STD_LOGIC_VECTOR (6 downto 0) ;

  constant clock_period: time := 100 ns;

begin

  uut: FSM port map ( sensor_sync => sensor_sync,
                      WR          => WR,
                      Reset_Sync  => Reset_Sync,
                      expired     => expired,
                      prog_sync   => prog_sync,
                      clk         => clk,
                      interval    => interval,
                      WR_Reset    => WR_Reset,
                      start_time  => start_time,
                      leds        => leds );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Reset_Sync <= '0';
    sensor_sync <= '0';
    WR <= '0';
    prog_sync <= '0';
    expired <= '0';
    


    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
     clk <= '0', '1' after clock_period / 2;
     wait for clock_period;
  end process;

end;