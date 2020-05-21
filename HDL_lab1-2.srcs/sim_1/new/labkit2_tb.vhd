library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Labkit_tb is
end;

architecture bench of Labkit_tb is

  component Labkit
      Port ( reset : in STD_LOGIC;
             value : in std_logic_vector (3 downto 0);
             start_t : in std_logic;
             clock : in STD_LOGIC;
             ex : out std_logic := '0');
  end component;

  signal reset: STD_LOGIC;
  signal value: std_logic_vector (3 downto 0);
  signal start_t: std_logic;
  signal clock: STD_LOGIC;
  signal ex: std_logic := '0';

begin

  uut: Labkit port map ( reset   => reset,
                         value   => value,
                         start_t => start_t,
                         clock   => clock,
                         ex      => ex );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;