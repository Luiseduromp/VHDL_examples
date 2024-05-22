library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serial_add is
    port(clk, load: in std_logic;
         x, y: in std_logic_vector(7 downto 0);
         ready, sat: out std_logic;
         z: out std_logic_vector(7 downto 0));
end serial_add;

architecture structural of serial_add is
    signal sum_x, sum_y: std_logic_vector(7 downto 0); 
    signal c_par, z_par, carry, ce, rdy: std_logic:='0';
begin
    -- Instancia shift_reg para el sumando X
    shift_sumx: entity work.shift_reg
        generic map (n=>8)
        port map (ce=>ce,
                  par_load=>load,
                  ser_din=>'0',
                  clk=>clk,
                  par_din=>x,
                  dout=>sum_x);
                  
    -- Instancia shift_reg para el sumando Y            
    shift_sumy: entity work.shift_reg
        generic map (n=>8)
        port map (ce=>ce,
                  par_load=>load,
                  ser_din=>'0',
                  clk=>clk,
                  par_din=>y,
                  dout=>sum_y);
    
    -- Instancia del sumador de 1 bit      
    adder_1b: entity work.ripple_adder
        port map (a_in=>sum_x(0),
                  b_in=>sum_y(0),
                  c_in=>carry,
                  s_out=>z_par,
                  c_out=>c_par);
    
    -- Instancia de la lógica de control            
    ctrl: entity work.adder_ctrl
        port map (clk=>clk,
                  load=>load,
                  c_in=>c_par,
                  rdy=>rdy,
                  c_out=>carry);
          
    sat<=carry;   -- Bit de saturación, carry final
    ready<=rdy;   -- Bit de fin de operación
    ce<= not rdy; -- Control de flujo de shift_reg
    
    -- Instancia shift_reg para el resultado             
    shift_resp: entity work.shift_reg
        generic map (n=>8)
        port map (ce=>ce,
                  par_load=>load,
                  ser_din=>z_par,
                  clk=>clk,
                  par_din=>(others=>'0'),
                  dout=>z);

end structural;
