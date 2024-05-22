library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity timer is
	Generic ( constant ncycle: positive range 1 to (2**31)-1:=5);
	Port (
	   clk, enable, clear: in std_logic;
	   dig0, dig1: out std_logic_vector(3 downto 0)
    );
end timer;

architecture Behavioral of timer is
    signal uni, dec: unsigned (3 downto 0);
begin

    counter: process(clk, clear) is
        --variable uni, dec: unsigned (3 downto 0);
        --constant factor: unsigned (30 downto 0):=To_unsigned(ncycle-1,31);
    begin
        if clear='1' then
            dig0<="0000";
            dig1<="0000";
            uni<="0000";
            dec<="0000";
        elsif rising_edge(clk) then
            if enable='1' then
                if (uni and dec)/="1001" then
                    if uni="1001" then
                        uni<="0000";
                        if dec/="1001" then
                            dec<=dec+1;
                        end if;
                    else 
                        uni<=uni+1;
                    end if;
                end if;
            end if;
            dig0<=std_logic_vector(uni);
            dig1<=std_logic_vector(dec);
        end if;

    end process;
end Behavioral;
