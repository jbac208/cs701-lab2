library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.TdmaMinTypes.all;

entity AspDp is
  port (
    clock : in  std_logic;
    recv  : in  tdma_min_port;
    send  : out tdma_min_port
  );
end entity;

architecture rtl of AspDp is
  -- keep the last 3 samples per channel
  type sample_hist is array(0 to 2) of signed(15 downto 0);
  signal left_hist  : sample_hist := (others => (others => '0'));
  signal right_hist : sample_hist := (others => (others => '0'));
begin

  process(clock)
    variable curr_samp : signed(15 downto 0);
    variable sm        : signed(17 downto 0);
    variable avg       : signed(15 downto 0);
  begin
    if rising_edge(clock) then
      if recv.data(31 downto 28) = "1000" then  -- valid packet tag
        curr_samp := signed(recv.data(15 downto 0));

        if recv.data(16) = '0' then
          -- shift left channel history
          left_hist(0) <= left_hist(1);
          left_hist(1) <= left_hist(2);
          left_hist(2) <= curr_samp;
          -- sum 4 values
          sm := resize(left_hist(0),18)
             + resize(left_hist(1),18)
             + resize(left_hist(2),18)
             + resize(curr_samp,18);
        else
          -- shift right channel history
          right_hist(0) <= right_hist(1);
          right_hist(1) <= right_hist(2);
          right_hist(2) <= curr_samp;
          sm := resize(right_hist(0),18)
             + resize(right_hist(1),18)
             + resize(right_hist(2),18)
             + resize(curr_samp,18);
        end if;

        -- compute average (sum ÷ 4)
        avg := signed(sm(17 downto 2));

        -- package and forward on port “2”
        send.addr <= std_logic_vector(to_unsigned(1, send.addr'length));
        send.data <= recv.data(31 downto 16) & std_logic_vector(avg);

      else
        -- idle when no valid packet
        send.addr <= (others => '0');
        send.data <= (others => '0');
      end if;
    end if;
  end process;

end architecture;
