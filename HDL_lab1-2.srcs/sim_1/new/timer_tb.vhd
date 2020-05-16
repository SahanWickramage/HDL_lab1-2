library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity timer_tb is
end;

architecture bench of timer_tb is

  component timer
      Port ( one_hz_enable : in STD_LOGIC;
             start_timer : in STD_LOGIC;
             value : in STD_LOGIC_VECTOR (3 downto 0);
             expired : out STD_LOGIC);
  end component;

  signal one_hz_enable: STD_LOGIC;
  signal start_timer: STD_LOGIC;
  signal value: STD_LOGIC_VECTOR (3 downto 0);
  signal expired: STD_LOGIC;

begin

  uut: timer port map ( one_hz_enable => one_hz_enable,
                        start_timer   => start_timer,
                        value         => value,
                        expired       => expired );

  stimulus: process
  begin
  
    -- Put initialisation code here
    value <= "1111";
    start_timer <= '1';
    wait for 50 ns;
    start_timer <= '0';
    -- Put test bench stimulus code here

    wait;
  end process;
  
  clocking: process
  begin
    one_hz_enable <= '0';
    wait for 500 ms;
    one_hz_enable <= '1';
    wait for 500 ms;
  end process;


end;