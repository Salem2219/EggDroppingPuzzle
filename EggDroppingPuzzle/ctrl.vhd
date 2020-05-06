library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ctrl is
  port(clk,rst, start: in std_logic;
      x : in std_logic_vector(3 downto 0);
       i_ld, j_ld, x_ld: out std_logic;
       sel : out std_logic_vector(1 downto 0);
      wr : out std_logic_vector(3 downto 0));
end ctrl;

architecture rtl of ctrl is
  type state_type is (s0,s1,s2,s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
  signal current_state, next_state: state_type;
begin 
  process(x, start, current_state)
  begin
    case current_state is
	when s0 => 
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "00";
       wr <= "0000";
	  next_state <= s1;
	when s1 =>  
       i_ld <= '1';
       j_ld <= '1';
       x_ld <= '0';
       sel <= "00";
       wr <= "0000";
      if (start = '1') then
	  next_state <= s2;
      else
      next_state <= s1;
      end if;
	when s2 => 
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "00";
       wr <= "0000";
      if(x(0) = '1') then
      next_state <= s4;
      else
      next_state <= s3;
      end if;
	when s3 =>  
       i_ld <= '1';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "10";
       wr <= "0001";
	  next_state <= s2;
      when s4 =>
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "00";
       wr <= "0000";
       if (x(1) = '1') then
      next_state <= s6;
      else
      next_state <= s5;
      end if;
      when s5 =>
       i_ld <= '0';
       j_ld <= '1';
       x_ld <= '0';
       sel <= "10";
       wr <= "0010";
      next_state <= s4;
    when s6 =>  
       i_ld <= '1';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "01";
       wr <= "0000";
	  next_state <= s7;
    when s7 =>  
       i_ld <= '0';
       j_ld <= '1';
       x_ld <= '0';
       sel <= "01";
       wr <= "0000";
       if (x(0) = '1') then
	  next_state <= s1;
    else
    next_state <= s8;
    end if;
    when s8 =>
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '1';
       sel <= "00";
       wr <= "0100";
       if (x(1) = '1') then
	  next_state <= s9;
    else
    next_state <= s10;
    end if;
    when s9 =>  
       i_ld <= '1';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "10";
       wr <= "0000";
	  next_state <= s7;
    when s10 =>  
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '0';
       sel <= "00";
       wr <= "0000";
       if (x(2) = '1') then
	  next_state <= s11;
    else
    next_state <= s12;
    end if;
    when s11 =>  
       i_ld <= '0';
       j_ld <= '1';
       x_ld <= '0';
       sel <= "10";
       wr <= "0000";
	  next_state <= s8;
    when s12 =>  
       i_ld <= '0';
       j_ld <= '0';
       x_ld <= '1';
       sel <= "10";
       wr <= x(3) & "000";
	  next_state <= s10;
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;