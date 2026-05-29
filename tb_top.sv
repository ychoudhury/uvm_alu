`timescale 1ns/1ps
import uvm_pkg::*;
import alu_pkg::*;
module tb_top;

    alu_if vif();

    // instantiate DUT here
    alu dut (.clk(vif.clk), .reset(vif.reset), .A(vif.A), .B(vif.B), .op(vif.op), .result(vif.result));

    initial begin
        uvm_config_db #(virtual alu_if)::set(null, "*", "vif", vif);
        run_test("alu_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
