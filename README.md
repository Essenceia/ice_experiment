# ICE i40 quickstart 

Flow example for our lovely Sharon, this includes : 
- running a quick lint of the project `make lint_top`
- running a tb `make tb`
- building the i40 FPGA bitstream `make build` 
- flashing the bitstream to the fpga `make prog` ( tested with the nandland board ) 
- getting timing information `make time`

# Adapt to your project 

In the makefile : 
1. Update the `DEVICE` and `PKG` to match your FPGA type.
2. Update `PROJ` to match your project name.
3. Upadate `sc_files` to list your verilog files

This build flow assumes your top level module is going to be called `top` and contained in the 
`top.v` file. This is a common practice, if this isn't the case for you, update all instanced of `top` in 
the makefile.

# Required tools

- iverilog ( icarus verilog ) https://steveicarus.github.io/iverilog/usage/installation.html
- i40 open source flow, project IceStorm : https://prjicestorm.readthedocs.io/en/latest/overview.html
- gtkwave, recomended wave viewer : https://gtkwave.sourceforge.net/
- yosys, synthsiser: https://github.com/YosysHQ/yosys
- arachne place and route: https://github.com/YosysHQ/arachne-pnr
