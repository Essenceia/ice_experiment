# ICE i40 quickstart 

Flow example for our lovely Sharon, this includes : 
- running a quick lint of the project `make lint`
- running a tb `make tb`
- opening the waves `make waves`
- building the i40 FPGA bitstream `make build` 
- flashing the bitstream to the fpga `make prog` ( tested with the nandland go board ) 
- getting critical path timing report `make time` ( note: your critical path upper bounds your max clk frequency ) 

# Adapt to your project 

In the makefile : 
1. Update the `DEVICE` and `PKG` to match your FPGA type.
2. Update pin mappings to match your board if you are not using a Go board `bpp.pcf`

This build flow assumes your top level module is going to be called `top` and contained in the 
`top.v` file. This is a common practice, if this isn't the case for you, update all instanced of `top` in 
the makefile.

If you are not running a nandland go board, update the board support package file `bsp.pcf`.

# Required tools

- iverilog ( icarus verilog ) https://steveicarus.github.io/iverilog/usage/installation.html
- i40 open source flow, project IceStorm : https://prjicestorm.readthedocs.io/en/latest/overview.html
- gtkwave, recomended wave viewer : https://gtkwave.sourceforge.net/
- yosys, synthsiser: https://github.com/YosysHQ/yosys
- arachne place and route: https://github.com/YosysHQ/arachne-pnr

# Quickstart 

- Install the tools. 
- Run lint `make lint`. 
- Run the tb `make tb`
- Open the waves `make waves`
- Sythesis your design `make syn`
- Build your design `make build` 
- Program your board `make prog`

Addional steps : 
- Report your worst path, this will constrain your maximum frequncy `make time` 
