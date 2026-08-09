module control_unit (
    input [6:0] opcode,          // The operation code from the instruction
    output reg reg_write,        // 1 = Save data to Register Bank
    output reg [1:0] alu_op      // Tells ALU what operation to do
);

    always @(*) begin
        case(opcode)
            7'b0110011: begin    // Example code for Arithmetic (ADD/SUB)
                reg_write = 1'b1;
                alu_op    = 2'b00; // Tell ALU to add
            end
            7'b0010011: begin    // Example code for Logic (AND/OR)
                reg_write = 1'b1;
                alu_op    = 2'b10; // Tell ALU to perform logical AND
            end
            default: begin
                reg_write = 1'b0;
                alu_op    = 2'b11;
            end
        endcase
    end
endmodule
