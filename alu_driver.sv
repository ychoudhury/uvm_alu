class alu_driver extends uvm_driver #(alu_seq_item);
    // utility macro
    `uvm_component_utils(alu_driver)

    // constructor function
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // declare virtual interface handle
    virtual alu_if vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface")
    endfunction

    virtual task run_phase (uvm_phase phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            seq_item_port.item_done();
        end
    endtask


    task reset;
        $display("[DRIVER] ----------------- Reset Started -----------------\n");
        @(vif.drv_cb);
        vif.drv_cb.reset <= 0; // 0 because we are resetting the entire DUT, not checking reset functionality
        vif.drv_cb.A <= 0;
        vif.drv_cb.B <= 0;
        vif.drv_cb.op <= 0;
        $display("[DRIVER] ----------------- Reset Complete -----------------\n");
    endtask

    task drive;
        @(vif.drv_cb);
        vif.drv_cb.reset <= req.reset;
        vif.drv_cb.A <= req.A;
        vif.drv_cb.B <= req.B;
        vif.drv_cb.op <= req.op;
    endtask

endclass
