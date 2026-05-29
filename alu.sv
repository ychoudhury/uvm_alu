module alu(
        input logic  clk, 
        input logic  reset, 
        input logic  [7:0] A, 
        input logic  [7:0] B, 
        input logic  [2:0] op, 
        output logic [7:0] result);


        always_ff @(posedge clk) begin
            if(reset) begin
                result <= 8'b0;    
            end else begin
                case(op)
                    3'b000: result = A + B;     // ADD A + B
                    3'b001: result = A - B;     // SUB A - B
                    3'b010: result = B - A;     // SUB B - A
                    3'b011: result = A / B;     // DIV A / B
                    3'b100: result = B / A;     // DIV B / A
                    3'b101: result = A * B;     // MULT A * B 
                    3'b110: result = A << B;    // LSL A << B
                    3'b111: result = B << A;    // LSL B << A
                    default: result = 8'b00000000;
                endcase
            end
        end

endmodule
