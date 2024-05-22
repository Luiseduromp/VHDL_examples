library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity tb_cordic is
end tb_cordic;

architecture Behavioral of tb_cordic is
    component CORDIC is
        port (clk, rst, start, sel, s_in: in  std_logic;
              angle: in  std_logic_vector(6 downto 0);
              result: out std_logic_vector(9 downto 0);
              idle, s_out: out std_logic);
    end component;
    
    signal clk, rst, start, sel, s_in:  std_logic;
    signal angle: std_logic_vector(6 downto 0);
    
    signal result: std_logic_vector(9 downto 0);
    signal idle, s_out: std_logic;
    
    constant clk_per: time:= 10ns;
begin

    uut: CORDIC
        port map(clk => clk,
            rst => rst,
            start => start,
            sel => sel,
            s_in => s_in,
            angle => angle,
            result => result,
            idle => idle,
            s_out => s_out);
            
    clk_process: process
    begin
        clk <= '0'; wait for clk_per/2; 
        clk <= '1'; wait for clk_per/2;
    end process;
    
    s_in <= '1';
    sel <='0';

    sim_process: process
    begin
        angle <= std_logic_vector(to_unsigned(45,7));
        rst <= '1', '0' after clk_per*1;
        start <= '0', '1' after clk_per*2;
        wait for clk_per*25;
        
        angle <= std_logic_vector(to_unsigned(90,7));
        rst <= '1', '0' after clk_per*1;
        start <= '0', '1' after clk_per*2;
        wait for clk_per*25;
        
        angle <= std_logic_vector(to_unsigned(0,7));
        rst <= '1', '0' after clk_per*1;
        start <= '0', '1' after clk_per*2;
        wait for clk_per*25;
        
        angle <= std_logic_vector(to_unsigned(25,7));
        rst <= '1', '0' after clk_per*1;
        start <= '0', '1' after clk_per*2;
        wait for clk_per*25;
    end process;
    
end Behavioral;
