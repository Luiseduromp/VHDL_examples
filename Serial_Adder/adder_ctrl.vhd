library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_ctrl is
    port(clk, load, c_in: in std_logic;
         rdy, c_out: out std_logic);
end adder_ctrl;

architecture Behavioral of adder_ctrl is
begin
    parcial: process(clk)
        variable nper: unsigned(2 downto 0):="000";
    begin
        if rising_edge(clk) then
            if load='1' then        -- Con load en 1 se reinicia todo
                c_out<='0';         
                nper:="000";        -- Se resetea el contador
                rdy<='0';
            else              
                if nper="111" then  -- Cuando el conteo llega a 8
                    rdy<='1';       -- el bit de ready se activa
                else
                    nper:=nper+1;     -- Caso contrario continua contando
                    c_out<=c_in;    -- Se actualizan el bit de carry
                end if;
            end if;
        end if;      
    end process;
end Behavioral;
