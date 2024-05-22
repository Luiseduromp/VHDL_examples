library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg is
    generic(n: positive:=4);
    port(ce, par_load, ser_din, clk: in std_logic;
         par_din: in std_logic_vector(n-1 downto 0);
         dout: out std_logic_vector(n-1 downto 0));
end shift_reg;

architecture behavior of shift_reg is
    signal reg: std_logic_vector(n-1 downto 0);
begin
    p1: process(clk)
    begin
        if rising_edge(clk) then
            if ce='1' then                  -- Desplaza solo con ce en alto
                if par_load = '1' then
                    reg<=par_din;           -- En load se carga el dato en par_din
                else
                    reg(n-1)<=ser_din;      -- Ingresa el bit en la pos. MSB
                    for i in 1 to n-1 loop  -- Desplaza resto de bits a la derecha
                        reg(n-i-1)<=reg(n-i);
                    end loop;
                end if;
            end if;
        end if;
    end process p1;
    
    dout<=reg;    
end behavior;
