library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ripple_adder is
    port(a_in, b_in, c_in: in std_logic;
         s_out, c_out: out std_logic);
end ripple_adder;

architecture struct of ripple_adder is
begin
    s_out<=a_in xor b_in xor c_in;
    c_out<=(a_in and b_in) or (c_in and (a_in or b_in));
end struct;
