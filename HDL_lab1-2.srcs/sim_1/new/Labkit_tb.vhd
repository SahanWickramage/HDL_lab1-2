library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Labkit_tb is
end;

architecture bench of Labkit_tb is

  component Labkit
      Port ( reset : in STD_LOGIC;
             sensor : in STD_LOGIC;
             walking_request : in STD_LOGIC;
             reprogram : in STD_LOGIC;
             time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
             time_value : in STD_LOGIC_VECTOR (3 downto 0);
             clock : in STD_LOGIC;
             leds : out STD_LOGIC_VECTOR (6 downto 0)
            );
  end component;

  signal reset: STD_LOGIC;
  signal sensor: STD_LOGIC;
  signal walking_request: STD_LOGIC;
  signal reprogram: STD_LOGIC;
  signal time_parameter_selector: STD_LOGIC_VECTOR (1 downto 0);
  signal time_value: STD_LOGIC_VECTOR (3 downto 0);
  signal clock: STD_LOGIC;
  signal leds: STD_LOGIC_VECTOR (6 downto 0) ;

begin

  uut: Labkit port map ( reset                   => reset,
                         sensor                  => sensor,
                         walking_request         => walking_request,
                         reprogram               => reprogram,
                         time_parameter_selector => time_parameter_selector,
                         time_value              => time_value,
                         clock                   => clock,
                         leds                    => leds );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;