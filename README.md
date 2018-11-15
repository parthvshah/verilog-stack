# Stack with Register File
Implementation of a stack using Verilog hardware definitions. The circuit diagram is available in the resources folder with progress reports.

## Building the code
This command generated the VCD file for viewing on GTKWave.

```iverilog stack4.v -o stack4 reg.v lib.v alu.v tb_stack4_el.v && vvp stack4```

This command is to open GTKWave.

```gtkwave tb_stack4.vcd```
