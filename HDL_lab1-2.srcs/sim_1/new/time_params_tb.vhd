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

begin

  uut: time_parameters port map ( clk                     => clk,
                                  prog_sync               => prog_sync,
                                  time_parameter_selector => time_parameter_selector,
                                  interval                => interval,
                                  time_value              => time_value,
                                  value                   => value );

  stimulus: process
  begin
  
    clk <= '1';
        prog_sync <= '0';
        time_parameter_selector <= "00";
        time_value <= "0000";
        interval <= "00";
        
        wait for 10ns;
        clk <= '0';
        wait for 10ns;
        
        clk <= '1';
        prog_sync <= '1';
        time_parameter_selector <= "00";
        time_value <= "0000";
        interval <= "00";
        
        wait for 10ns;
        clk <= '0';
        wait for 10ns;
        
        clk <= '1';
        prog_sync <= '0';
        time_parameter_selector <= "00";
        time_value <= "0000";
        interval <= "00";
        wait for 1ns;

    wait;
  end process;


end;