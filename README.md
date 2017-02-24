# 32-bit verilog FP multiplier

This is a slightly incomplete 32-bit floating point multiplier. There's also a SystemVerilog testbench and a random test vector that I generated with the Python script. 

You can all tests in ModelSim like so:

    run 100000

And the results are:

> Completed 9999 tests, 6485 passes and 3514 fails.
> Of the fails, 3488 had a LSB off by one

There's a bug where about 1/3 of the time the least significant bit of the mantissa is off by one. I think I'm making a mistake with my implementation of rounding to the nearest even.
