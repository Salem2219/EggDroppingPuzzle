library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk  : in std_logic;
wr, n, k, i, j, x : in std_logic_vector(3 downto 0);
res : in std_logic_vector(7 downto 0);
y, e1, e2, e3 : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
type ram_type is array (0 to 15, 0 to 15) of
std_logic_vector(7 downto 0);
signal eggFloor : ram_type;
signal jminusx, iminus1, xminus1 : unsigned(3 downto 0);
begin
jminusx <= unsigned(j) - unsigned(x);
iminus1 <= unsigned(i) - 1;
xminus1 <= unsigned(x) - 1;
process(clk)
begin
if (rising_edge(clk)) then
if (wr = "0001") then
eggFloor(conv_integer(unsigned(i)), 1) <= "00000001";
eggFloor(conv_integer(unsigned(i)), 0) <= "00000000";
elsif (wr = "0010") then
eggFloor(1, conv_integer(unsigned(j))) <= "0000" & j;
elsif (wr = "0100") then
eggFloor(conv_integer(unsigned(i)), conv_integer(unsigned(j))) <= (others => '1');
elsif (wr = "1000") then
eggFloor(conv_integer(unsigned(i)), conv_integer(unsigned(j))) <= res;
end if;
end if;
end process;
y <= eggFloor(conv_integer(unsigned(n)), conv_integer(unsigned(k)));
e1 <= eggFloor(conv_integer(iminus1), conv_integer(xminus1));
e2 <= eggFloor(conv_integer(unsigned(i)), conv_integer(jminusx));
e3 <= eggFloor(conv_integer(unsigned(i)), conv_integer(unsigned(j)));
end rtl;