library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, i_ld, j_ld, x_ld : in std_logic;
    sel : in std_logic_vector(1 downto 0);
    wr : in std_logic_vector(3 downto 0);
    n, k : in std_logic_vector(3 downto 0);
    c : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end dp;

architecture rtl of dp is
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component complt is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic);
end component;
component ram is
port(clk  : in std_logic;
wr, n, k, i, j, x : in std_logic_vector(3 downto 0);
res : in std_logic_vector(7 downto 0);
y, e1, e2, e3 : out std_logic_vector(7 downto 0));
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component oneortwo_mux is
    port (s : in std_logic;
    y : out std_logic_vector(3 downto 0));
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component resop is
    port (e1, e2 : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
signal i, j, x, i_in, j_in, x_in, oneortwo, iplus1, jplus1, xplus1 : std_logic_vector(3 downto 0);
signal res, e1, e2, e3 : std_logic_vector(7 downto 0);
begin
    in_comp : compgr port map (i, n, c(0));
    jk_comp : compgr port map (j, k, c(1));
    xj_comp : compgr port map (x, j, c(2));
    rese3_comp : complt port map (res, e3, c(3));
    eggFloor_ram : ram port map (clk, wr, n, k, i, j, x, res, y, e1, e2, e3);
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    j_reg : reg4 port map (clk, rst, j_ld, j_in, j);
    x_reg : reg4 port map (clk, rst, x_ld, x_in, x);
    i_mux : mux4 port map (sel(1), oneortwo, iplus1, i_in);
    j_mux : mux4 port map (sel(1), oneortwo, jplus1, j_in);
    x_mux : mux4 port map (sel(1), "0001", xplus1, x_in);
    one_two : oneortwo_mux port map (sel(0), oneortwo);
    i_op : plus1 port map (i, iplus1);
    j_op : plus1 port map (j, jplus1);
    x_op : plus1 port map (x, xplus1);
    res_op : resop port map (e1, e2, res);
end rtl;