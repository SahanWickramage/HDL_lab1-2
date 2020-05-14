----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2020 11:40:26 AM
-- Design Name: 
-- Module Name: time_parameters - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity time_parameters is
    Port ( clk : in std_logic;
           prog_sync : in STD_LOGIC;
           time_parameter_selector : in STD_LOGIC_VECTOR (1 downto 0);
           interval : in STD_LOGIC_VECTOR (1 downto 0);
           time_value : in STD_LOGIC_VECTOR (3 downto 0);
           value : out STD_LOGIC_VECTOR (3 downto 0));
end time_parameters;

architecture Behavioral of time_parameters is
    signal t_base : std_logic_vector (3 downto 0) := "0110";
    signal t_ext : std_logic_vector (3 downto 0) := "0011";
    signal t_yel : std_logic_vector (3 downto 0) := "0010";
    signal temp_value : std_logic_vector (3 downto 0) := "0000";
    
begin

process(clk, prog_sync, time_parameter_selector, time_value)

begin

    if rising_edge(clk) then
        if prog_sync = '1' then
            case time_parameter_selector is
                when "00" => t_base <= time_value;
                when "01" => t_ext <= time_value;
                when "10" => t_yel <= time_value;
            end case;
        end if;
    end if;

end process;

process(clk, interval)

begin

    if rising_edge(clk) then
        case interval is
            when "00" => temp_value <= t_base;
            when "01" => temp_value <= t_ext;
            when "10" => temp_value <= t_yel;
        end case;
        value <= temp_value;
    end if;

end process;

end Behavioral;
