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

  -- constant clock_period: time := 10 ns;
  -- signal stop_the_clock: boolean;

begin

  uut: walk_register port map ( WR_Sync  => WR_Sync,
                                WR_Reset => WR_Reset,
                                WR       => WR );

  stimulus: process
  begin
  
    -- Put initialisation code here
    WR_Sync <= '1';
    WR_Reset <= '0';
    wait for 30ns;
    
    WR_Reset <= '1';
    wait for 30ns;
    
    WR_Reset <= '0';
    wait for 30ns;

    WR_Sync <= '0';
    wait for 30ns;
    
    WR_Reset <= '1';
    wait for 30ns;
    
    WR_Reset <= '0';
    wait for 30ns;

    -- Put test bench stimulus code here

    -- stop_the_clock <= true;
    wait;
  end process;

end;