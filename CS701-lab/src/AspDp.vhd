library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.TdmaMinTypes.all;

entity AspDp is
  port(
    clock        : in  std_logic;
    recv : in  tdma_min_port;
    send : out tdma_min_port
  );
end entity;

architecture behavioural of AspDp is
  signal toggle_flag : std_logic := '0';
  
  type sample_hist is array(0 to 2) of signed(15 downto 0);
  signal left_hist  : sample_hist := (others => (others => '0'));
  signal right_hist : sample_hist := (others => (others => '0'));
begin

  process(clock)
    variable current_sample : signed(15 downto 0);
    variable average_val    : signed(15 downto 0);
    variable scaled_double  : signed(31 downto 0);
    variable clipped_val    : signed(15 downto 0);
  begin
    if rising_edge(clock) then
      if recv.data(31 downto 28) = "1000" then
        toggle_flag <= not toggle_flag;

        current_sample := signed(recv.data(15 downto 0));

        if recv.data(16) = '0' then
          left_hist <= left_hist(0 to 1) & current_sample;
          average_val := (current_sample + left_hist(0) + left_hist(1) + left_hist(2)) / 4;
          
        elsif recv.data(16) = '1' then
          right_hist <= right_hist(0 to 1) & current_sample;
          average_val := (current_sample + right_hist(0) + right_hist(1) + right_hist(2)) / 4;

        else
          average_val := (others => '0');
        end if;

        scaled_double := average_val * 2;
        
        if scaled_double > to_signed(4096, 32) then
          clipped_val := to_signed(4096, 16);
        elsif scaled_double < to_signed(-4096, 32) then
          clipped_val := to_signed(-4096, 16);
        else
          clipped_val := signed(scaled_double(15 downto 0));
        end if;

        send.addr <= std_logic_vector(to_unsigned(2, send.addr'length));
        send.data <= recv.data(31 downto 16) & std_logic_vector(clipped_val);

      else
        send.addr  <= (others => '0');
        send.data  <= (others => '0');
      end if;
    end if;
  end process;

end architecture behavioural;
