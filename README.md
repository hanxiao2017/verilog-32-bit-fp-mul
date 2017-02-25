# 32-bit verilog FP multiplier

This is a slightly incomplete (no special cases) 32-bit floating point multiplier. 
There's also a SystemVerilog testbench and a random test vector that I generated with the Python script. 

You can test in ModelSim like so:
    
    vlog fp_mul.v main_tb.sv
    vsim work.main_tb
    run 200000

And the results are:

> Completed 10000 tests, 10000 passes and 0 fails.