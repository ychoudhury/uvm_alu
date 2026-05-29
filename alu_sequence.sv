class alu_sequence extends uvm_sequence #(alu_seq_item);
    `uvm_object_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    virtual task body();

        repeat(100) begin
            req = alu_seq_item::type_id::create("req");

            start_item(req);
            if(!req.randomize() with {

                reset == 1'b0;
            }) begin
                `uvm_error("REQ", "Randomization failed")
            end
            
            finish_item(req);
        end
    endtask

endclass