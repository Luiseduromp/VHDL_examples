library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CORDIC is
    Port (
        clk, rst, start, sel, s_in: in  std_logic;
        angle: in  std_logic_vector(6 downto 0);
        idle, s_out: out std_logic;
        result: out std_logic_vector(9 downto 0));

end CORDIC;

architecture Behavioral of CORDIC is
    type angle_table_t is array (0 to 7) of integer;
    constant angle_table : angle_table_t := (450000, 265650, 140360, 71250, 35760, 17890, 8950, 4476);
    signal done: std_logic := '0';
    signal iter: integer;
    signal t_teta, t_act, t_inc, t_x, t_y: integer;
    signal dx, dy: signed(20 downto 0);

begin

    process(clk, rst)
        variable teta, act, inc, x, y: integer;
        variable res: unsigned(9 downto 0);
        variable dif_x, dif_y: signed(20 downto 0);
    begin
        if rst = '1' then           
            result <= (others =>'0');
            s_out <= '0';
            
            done <= '0';
            idle <= '0';

            iter <= 0;
            dif_x := (others =>'0');
            dif_y := (others =>'0');
            act := 0;
            teta := to_integer(unsigned(angle)) * 10000;
            
            if s_in = '1' then
                teta := -teta;
            end if;

            x := 6073;
            y := 0;
            
            dx <= (others=>'0');
            dy <= (others=>'0');     
            t_teta <= teta;
            t_inc <= 0;
            t_act <= 0;
            t_x <= x;
            t_y <= y;
            
        elsif rising_edge(clk) then
            if start = '1' then
                if done = '0' then                     
                    if iter >= 8 then
                        done <='1';
                        idle <= '1';
                    else 
                        dif_x := shift_right(to_signed(x, 21), iter);
                        dif_y := shift_right(to_signed(y, 21), iter);                       
                        inc := angle_table(iter);
                        
                        if teta >= act then
                            x := x - to_integer(dif_y);
                            y := y + to_integer(dif_x);
                            act := act + inc;
                        else
                            x := x + to_integer(dif_y);
                            y := y - to_integer(dif_x);
                            act := act - inc;
                        end if; 
                    end if;
                    iter <= iter + 1;
                else         
                    if sel = '1' then -- sin
                        --result <= std_logic_vector(to_unsigned(y/10, 10));
                        if y >= 0 then
                            res := to_unsigned(y/10, 10);
                            s_out <='0';
                        else 
                            res := to_unsigned(-y/10, 10);
                            s_out <='1';
                        end if;
                    else -- cos
                        --result <= std_logic_vector(to_unsigned(x/10, 10));
                        if x >= 0 then
                            res := to_unsigned(x/10, 10);
                            s_out <='0';
                        else 
                            res := to_unsigned(-x/10, 10);
                            s_out <='1';
                        end if;
                    end if;   
                    result <= std_logic_vector(res);
                end if;
            
            end if;
            
            dx <= dif_x;
            dy <= dif_y;
            t_teta <= teta;
            t_inc <= inc;
            t_act <= act;
            t_x <= x;
            t_y <= y;
        end if;
    end process;

end Behavioral;