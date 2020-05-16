library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity time_parameters_tb is
end;

architecture bench of time_parameters_tb is

  component time_parameters
      Port ( clk : in std_logic;
             prog_sync : in STD_LOGIC;
             time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
             interval : in STD_LOGIC_VECTOR (1 downto 0);
             time_value : in STD_LOGIC_VECTOR (3 downto 0);
             value : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal clk: std_logic;
  signal prog_sync: STD_LOGIC;
  signal time_parameter_selector: STD_LOGIC_VECTOR (1 downto 0);
  signal interval: STD_LOGIC_VECTOR (1 downto 0);
  signal time_value: STD_LOGIC_VECTOR (3 downto 0);
  signal value: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: time_parameters port map ( clk                     => clk,
                                  prog_sync               => prog_sync,
                                  time_parameter_selector => time_parameter_selector,
                                  interval                => interval,
                                  time_value              => time_value,
                                  value                   => value );

  stimulus: process
  begin
  
    -- Put initialisation code here

    prog_sync <= '1';
    wait for 5 ns;
    prog_sync <= '0';
    wait for 5 ns;

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