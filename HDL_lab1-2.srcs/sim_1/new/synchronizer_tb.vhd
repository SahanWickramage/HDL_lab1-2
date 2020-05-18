library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity synchronizer_tb is
end;

architecture bench of synchronizer_tb is

  component synchronizer
      Port ( reset : in STD_LOGIC;
             sensor : in STD_LOGIC;
             walk_request : in STD_LOGIC;
             reprogram : in STD_LOGIC;
             clk : in STD_LOGIC;
             reset_sync : out STD_LOGIC;
             sensor_sync : out STD_LOGIC;
             wr_sync : out STD_LOGIC;
             prog_sync : out STD_LOGIC);
  end component;

  signal reset: STD_LOGIC;
  signal sensor: STD_LOGIC;
  signal walk_request: STD_LOGIC;
  signal reprogram: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal reset_sync: STD_LOGIC;
  signal sensor_sync: STD_LOGIC;
  signal wr_sync: STD_LOGIC;
  signal prog_sync: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: synchronizer port map ( reset        => reset,
                               sensor       => sensor,
                               walk_request => walk_request,
                               reprogram    => reprogram,
                               clk          => clk,
                               reset_sync   => reset_sync,
                               sensor_sync  => sensor_sync,
                               wr_sync      => wr_sync,
                               prog_sync    => prog_sync );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;