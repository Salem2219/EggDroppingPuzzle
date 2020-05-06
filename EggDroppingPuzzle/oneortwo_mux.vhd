library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity oneortwo_mux is
    port (s : in std_logic;
    y : out std_logic_vector(3 downto 0));
end oneortwo_mux;

architecture rtl of oneortwo_mux is
begin
    y <= "0010" when s = '1' else "0001";
end rtl;