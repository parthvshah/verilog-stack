# Stack with Register File
Implementation of a stack using Verilog hardware definitions. The circuit diagram is available in the resources folder with progress reports.

## Building the code
This command generated the VCD file for viewing on GTKWave.
```iverilog stack3.v -o stack3 reg.v lib.v alu.v tb_stack3_el.v && vvp stack3```

This command is to open GTKWave.
```gtkwave tb_stack3.vcd```
