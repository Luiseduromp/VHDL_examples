library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity chrono is
    port(
        clk: in std_logic;
        switches: in std_logic_vector(1 downto 0);
        sel: out std_logic;
        digit: out std_logic_vector(6 downto 0));
end chrono;

architecture structural of chrono is
    signal en_t, clk_t, en_d, clk_d: std_logic;
    signal ms_dig, ls_dig: std_logic_vector(3 downto 0);
begin
    div_1: entity work.divider
    generic map (fact => 125e6)
    --generic map (fact => 16)
    port map (
        clk => clk,
        clk_out => en_t
    );
    clk_t<=(en_t and switches(0));
    
    
    div_400: entity work.divider
    generic map (fact => 312500)
    --generic map (fact => 4)
    port map (
        clk => clk,
        clk_out => clk_d
    );
    
    
    timer: entity work.timer
    port map (
        clk=>clk,
        enable=>clk_t,
        clear=>switches(1),
        dig0=>ls_dig,
        dig1=>ms_dig 
    );
    
    decoder: entity work.decoder
    port map (
        clk=>clk, 
        enable=>clk_d,
	    dig0=>ls_dig,
	    dig1=>ms_dig,
	    sel=>sel,
	    dig_out=>digit
    );
    
end structural;
