\# Lab 7: Counters (FPGA)



\*\*Board:\*\* Nexys 4 DDR (Artix-7)

\*\*Language:\*\* Verilog

\*\*IDE:\*\* Xilinx Vivado



\## Description

This repository contains the source code for Lab 7. It implements four distinct counter-based problems on a single FPGA board.



\## Modules

\* \*\*Lab7\_Master\_Top.v:\*\* The top-level wrapper that connects all sub-modules to the board's I/O (LEDs, Switches, 7-Segment, PMOD).

\* \*\*led\_blinker.v (Problem 1):\*\* A 29-bit counter that blinks LED\[0] with a period of 3 seconds (2s ON, 1s OFF).

\* \*\*clock\_10kHz.v (Problem 2):\*\* A clock divider that steps down the 100MHz system clock to 10kHz for observations.

\* \*\*phone\_number\_disp.v (Problem 3):\*\* Displays "867-5309" on the 7-segment display using time-division multiplexing (Persistence of Vision).

\* \*\*rgb\_pwm.v (Problem 4):\*\* Controls the RGB LED color mixing using Pulse Width Modulation (PWM) driven by switches.



\## How to Run

1\. Create a new RTL Project in Vivado targeting the Nexys 4 DDR.

2\. Add all `.v` files as Design Sources.

3\. Add the `.xdc` file as a Constraint.

4\. Generate Bitstream and Program Device.

