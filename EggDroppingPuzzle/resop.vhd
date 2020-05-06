library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity resop is
    port (e1, e2 : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end resop;

architecture rtl of resop is
signal y_uns : unsigned(7 downto 0);
signal x : std_logic_vector(7 downto 0);
begin
    x <= e1 when unsigned(e1) > unsigned(e2) else e2;
    y_uns <= unsigned(x) + 1;
    y <= std_logic_vector(y_uns);
end rtl;
