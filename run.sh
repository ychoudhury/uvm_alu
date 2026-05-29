#!/bin/sh
# Compile and run the ALU UVM testbench via the sv_uvm (VCS) wrapper.
# Source order matters: interface and DUT before the package, top module last.

./sv_uvm +incdir+. alu_if.sv alu.sv alu_pkg.sv tb_top.sv
