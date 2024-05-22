library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider is
    Generic (constant fact: positive range 1 to (2**30)-1:=4);
    port (clk: in std_logic;
          clk_out: out std_logic
    );
end divider;

architecture Behavioral of divider is
    signal count: unsigned(29 downto 0);
begin
    counter: process(clk) is
        --variable count: unsigned (29 downto 0);
        constant max: unsigned (29 downto 0):=To_unsigned(fact-1,30);
    begin
        if(rising_edge(clk)) then
            if(count/=max) then
                count<=count+1;
                clk_out<='0';
            else
                clk_out<='1';
                count<=to_unsigned(0,30);
            end if;
        end if;
    end process;

end Behavioral;
