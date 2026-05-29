interface alu_if();
    logic clk, reset;
    logic [7:0] A, B;
    logic [2:0] op;
    logic [7:0] result;

    // generate a clock, 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // clocking blocks for driver and monitor.
    // from driver perspective, outputs are inputs to the DUT.
    clocking drv_cb @(posedge clk);
        default input #1step output #2; // sample result 1 time unit pre-edge, then drive inputs 2 units post-edge.
        output reset, A, B, op;
        input result;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input reset, A, B, op, result;
    endclocking

    modport DRV (clocking drv_cb);
    modport MON (clocking mon_cb);

endinterface