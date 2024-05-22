# VHDL Example Projects
This repository contains simple VHDL projects. Each project is explained below


# Chrono 99
This project is a simple chronometer that counts from 0 to 99. It adds up one unit each second.
The count is displayed in a double 7 segment display. The code was tested in a ZYNQ-7010 Development Board.
The design was implemented using four entities, one timer entity, one decoder entity, and two clock divider entities, which control the timing of the other entities.

# Cordic_Sin_Cos
This is a very simple implementation of the CORDIC algorithm to compute the sine and cosine functions for angles between -90 to 90 degrees. The input is given in a 7 bit std_logic_vector, and the sign of the input angle is a separate bit. The function to compute is selected through a "sel" input (1 bit). The algorithm computes the function selected when there is a '1' in the "start" input, and it gives only the decimal part of the sine or cosine of the input angle, represented as a 10 bit std_logic_vector.

# Serial_Adder
This small project is a serial adder, which takes two 8 bit numbers, and it adds them using shift registers (coded as individual entities), and a 1 bit full adder. The operation starts after both numbers have been loaded (pulse in the "load" input), and the answer is given at the output when the "ready"bit sets to '1'.
