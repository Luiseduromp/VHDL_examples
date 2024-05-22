library ieee;
use ieee.std_logic_1164.all;

entity tb_chrono is
end tb_chrono;

architecture behavior of tb_chrono is
    -- Component Declaration for the Unit Under Test (UUT)
    component chrono
        port(clk : in std_logic;
             switches: in std_logic_vector(1 downto 0);
             sel: out std_logic;
             digit: out std_logic_vector(6 downto 0)
        );
    end component;
    
    -- Inputs
    signal clk: std_logic := '0';
    signal switches: std_logic_vector(1 downto 0);
    
    -- Outputs
    signal sel: std_logic;
    signal digit: std_logic_vector(6 downto 0):="0000000";

    constant clk_period : time := 8 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: chrono port map (
        clk => clk,
        switches=>switches,
        sel=>sel,
        digit=>digit
    );
    
    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
--    test_process: process
--    begin
--        enable<='1';
--        clear<='1';
--        wait for clk_period*1;
--        clear<='0';
--        wait for clk_period*80;
--        enable<='0';
--        wait for clk_period*20;
--        enable<='1';
--        wait for clk_period*10;
--        enable<='0';
--        wait for clk_period*5;
--        clear<='1';
--        wait for clk_period*1;
--        clear<='0';
--        enable<='1';
--        wait for clk_period*10;
--    end process;



    switches <= "00", "10" after clk_period, "01" after clk_period*2;
    --switches<="10" after clk_period;
     

end;
