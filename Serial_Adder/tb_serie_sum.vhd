library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_serie_sum is
end tb_serie_sum;

architecture Behavioral of tb_serie_sum is
    component serie_sum
        port(load, clk: in std_logic;
             x, y: in std_logic_vector;
             ready, sat: out std_logic;
             z: out std_logic_vector(7 downto 0));
    end component;
    
    -- Entradas
    signal load, clk: std_logic:='0';
    signal x, y: std_logic_vector(7 downto 0):="00000000";
    
    -- Salidas
    signal ready, sat: std_logic;
    signal z: std_logic_vector(7 downto 0);
    
    -- Reloj
    constant clk_period: time:= 10ns;
begin
    uut: serie_sum port map(
        clk=>clk,
        load=>load,
        x=>x,
        y=>y,
        ready=>ready,
        sat=>sat,
        z=>z);
        
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;    

    sim_process: process
    begin
        x<="10110101";
        y<="00101110";
        load<='1';
        wait for clk_period*2;
        load<='0';
        wait for clk_period*18;
        
        x<="11111111";
        y<="00000001";
        load<='1';
        wait for clk_period*2;
        load<='0';
        wait for clk_period*18;
        
        x<="11000000";
        y<="01000000";
        load<='1';
        wait for clk_period*2;
        load<='0';
        wait for clk_period*18;
        
        x<="11000000";
        y<="11000000";
        load<='1';
        wait for clk_period*2;
        load<='0';
        wait for clk_period*18;
        
        x<="00101101";
        y<="11100100";
        load<='1';
        wait for clk_period*2;
        load<='0';
        wait for clk_period*18;
    end process;
    


end Behavioral;
