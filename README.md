# 8-bit ALU UVM Testbench

A SystemVerilog/UVM verification environment for an 8-bit ALU. The DUT is a synchronous, single-cycle ALU; the testbench randomizes operands and operations, drives them in, and self-checks every result against a reference model in the scoreboard.

## DUT

`alu.sv` — registers an 8-bit `result` on each `posedge clk`, selected by a 3-bit `op`:

| `op`  | Operation   |
|-------|-------------|
| `000` | `A + B`     |
| `001` | `A - B`     |
| `010` | `B - A`     |
| `011` | `A / B`     |
| `100` | `B / A`     |
| `101` | `A * B`     |
| `110` | `A << B`    |
| `111` | `B << A`    |

Inputs: `clk`, `reset`, `A[7:0]`, `B[7:0]`, `op[2:0]`. Output: `result[7:0]`. Asserting `reset` clears `result` to 0.

## Testbench structure

| File | Role |
|------|------|
| `tb_top.sv` | HDL top: instantiates the interface + DUT, publishes the virtual interface, calls `run_test()` |
| `alu_if.sv` | Interface, clock generator (10 ns), and driver/monitor clocking blocks |
| `alu_seq_item.sv` | Transaction: randomized `reset`, `A`, `B`, `op` + captured `result` |
| `alu_sequence.sv` | Generates 100 randomized transactions (`reset == 0`) |
| `alu_sequencer.sv` | Routes sequence items to the driver |
| `alu_driver.sv` | Drives transactions onto the interface |
| `alu_monitor.sv` | Samples the bus and broadcasts transactions (1-cycle pipeline to align inputs with the registered `result`) |
| `alu_agent.sv` | Container for sequencer, driver, monitor |
| `alu_scoreboard.sv` | Recomputes the expected result per `op` and tallies pass/fail |
| `alu_environment.sv` | Wires the agent's monitor to the scoreboard |
| `alu_test.sv` | Top-level test: builds the env and starts the sequence |



## Results
Simulation produces `dump.vcd` for waveform viewing.

The scoreboard logs each comparison and prints a summary in `check_phase`:

```
SUMMARY: Testcases ran <N> Testcases passed <N> Testcases failed <N>
```

Any operand/result mismatch is reported as a `uvm_error`.
