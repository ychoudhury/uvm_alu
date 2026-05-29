class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    // counters
    int num_checked;
    int num_passed;
    int num_failed;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_analysis_imp #(alu_seq_item, alu_scoreboard) ap_imp;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction

    virtual function void write(alu_seq_item data);

        `uvm_info("write", $sformatf("Data Received: %s\n", data.sprint()), UVM_MEDIUM)

        num_checked++;

        if(data.op == 3'b000 && data.result == data.A + data.B) begin
            num_passed++;
           `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b001 && data.result == data.A - data.B) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if (data.op == 3'b010 && data.result == data.B - data.A) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b011 && data.result == data.A / data.B) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b100 && data.result == data.B / data.A) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b101 && data.result == data.A * data.B) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b110 && data.result == data.A << data.B) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else if(data.op == 3'b111 && data.result == data.B << data.A) begin
            num_passed++;
            `uvm_info("SCB", "testcase passed", UVM_LOW)
        end else begin
            num_failed++;
            `uvm_error("SCB", $sformatf("MISMATCH: op = %0h, A = %0h, B = %0h, result = %0h",  data.op, data.A, data.B, data.result))
        end
    endfunction

    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);

        if(num_failed > 0) begin
            `uvm_error("SCB", "testcase(s) failed")
        end else if(num_checked == 0) begin
            `uvm_error("SCB", "no testcases ran")
        end

        `uvm_info("SCB", $sformatf("SUMMARY: Testcases ran %0d Testcases passed %0d Testcases failed %0d", num_checked, num_passed, num_failed), UVM_LOW)
    endfunction

endclass
