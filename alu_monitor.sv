class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // declare virtual interface handle
    virtual alu_if vif;

    uvm_analysis_port #(alu_seq_item) mon_analysis_port;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(), "DUT interface not found\n")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        alu_seq_item curr, prev;
        prev = null;

        forever begin
            @(vif.mon_cb);
            
            // 1 stage pipeline. Align inputs with 1-cycle delayed output.
            // scoreboard now has aligned input -> output result.
            if(prev != null) begin
                prev.result = vif.mon_cb.result;
                mon_analysis_port.write(prev);
            end

            curr = alu_seq_item::type_id::create("curr");
            curr.reset = vif.mon_cb.reset;
            curr.A = vif.mon_cb.A;
            curr.B = vif.mon_cb.B;
            curr.op = vif.mon_cb.op;
            prev = curr;
        end
    endtask
endclass
