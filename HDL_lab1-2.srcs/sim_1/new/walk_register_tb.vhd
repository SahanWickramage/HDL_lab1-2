library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity walk_register_tb is
end;

architecture bench of walk_register_tb is

  component walk_register
      Port ( WR_Sync : in STD_LOGIC;
             WR_Reset : in STD_LOGIC;
             WR : out STD_LOGIC);
  end component;

  signal WR_Sync: STD_LOGIC;
  signal WR_Reset: STD_LOGIC;
  signal WR: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: walk_register port map ( WR_Sync  => WR_Sync,
                                WR_Reset => WR_Reset,
                                WR       => WR );

  stimulus: process
  begin
  
    -- Put initialisation code here
    WR_Sync <= '0';
    WR_Reset <= '0';
    wait for 10 ns;
    
    WR_Sync <= '0';
    wait for 5 ns;
    WR_Reset <= '1';
    wait for 10 ns;
    
    WR_Sync <= '1';
    wait for 5 ns;
    WR_Reset <= '0';
    wait for 10 ns;
    
    WR_Sync <= '1';
    wait for 5 ns;
    WR_Reset <= '1';
    wait for 10 ns;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    -- while not stop_the_clock loop
    --  WR_sync <= '0', '1' after clock_period / 2;
    --  wait for clock_period;
    -- end loop;
    wait;
  end process;

end;