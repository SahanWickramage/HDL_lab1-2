library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clock_divider_tb is
end;

architecture bench of clock_divider_tb is

  component clock_divider
      port ( clk      : in std_logic;
             reset    : in std_logic;
             one_hz_enable: out std_logic);
  end component;

  signal clk: std_logic := '0';
  signal reset: std_logic := '0';
  signal one_hz_enable: std_logic;

  constant clock_period: time    := 20 ns; -- f = 50MHz
  signal stop_the_clock: boolean := false;

begin

  uut: clock_divider port map ( clk           => clk,
                                reset         => reset,
                                one_hz_enable => one_hz_enable );

  stimulus: process
  begin
  
    -- Put initialisation code here
    -- wait for 100 ns;
    -- stop_the_clock <= false;
    
    wait for 500 ns;
    -- Put test bench stimulus code here
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    -- while not stop_the_clock loop
    --  clk <= '0', '1' after clock_period / 2;
    --  wait for clock_period;
    -- end loop;
    -- if not stop_the_clock then
    --    clk <= '0';
    --    wait for clock_period / 2;
    --    clk <= '1';
    --    wait for clock_period / 2;
    -- end if;
    wait;
  end process;

end;