library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clock_divider is
    port ( clk      : in std_logic;
           reset    : in std_logic;
           one_hz_enable: out std_logic);
end clock_divider;
  
architecture Behavioral of clock_divider is
    signal count: integer         := 0;
    signal temp_value : std_logic := '0';
  
begin
  
process(clk, reset)

begin

    if(reset = '1') then
        count <= 0;
        temp_value <= '0';
    elsif rising_edge ( clk ) then
        count <= count + 1;
        -- if (count = 50_000_000) then -- f --> f/100, 100MHz --> 1Hz
        if (count = 4) then -- f --> f/10, 100MHz --> 10MHz
            temp_value <= NOT temp_value;
            count <= 0;
        end if;
    end if;
    
    one_hz_enable <= temp_value;
    
end process;
  
end Behavioral;