library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity decoder is
	Port (
	   clk, enable: in std_logic;
	   dig0, dig1: in std_logic_vector(3 downto 0);
	   sel: out std_logic;
	   dig_out: out std_logic_vector(6 downto 0));
end decoder;

architecture Behavioral of decoder is
    type decode_array is array (0 to 9) of std_logic_vector (6 downto 0);
    constant decoder: decode_array:=("1111110", "0110000", "1101101", "1111001", "0110011",
            "1011011", "1011111", "1110000", "1111111", "1110011");
begin

    decode: process(clk) is
        variable dsel: std_logic:='0';
        --variable digit: unsigned(3 downto 0);
        variable digit: integer range 0 to 9;
    begin
        if rising_edge(clk) then
            if enable='1' then
                if dsel='1' then
                    digit:=to_integer(unsigned(dig0));
                    dsel:='0';
                else
                    digit:=to_integer(unsigned(dig1));
                    dsel:='1';
                end if;
            end if;
            
        end if;
        dig_out<=decoder(digit);
        sel<=dsel;
    end process;
end Behavioral;
