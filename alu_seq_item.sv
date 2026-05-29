class alu_seq_item extends uvm_sequence_item;
    // fields
    rand bit reset;
    rand bit [7:0] A, B;
    rand bit [2:0] op;

    bit [7:0] result;

    // utility macro
    `uvm_object_utils_begin(alu_seq_item)
        `uvm_field_int(reset, UVM_ALL_ON)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(op, UVM_ALL_ON)
    `uvm_object_utils_end

    // constructor function
    function new(string name = "alu_seq_item");
        super.new(name);
    endfunction

endclass