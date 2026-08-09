module alu_64bit (
    input  [63:0] a,      // 64-bit Input A
    input  [63:0] b,      // 64-bit Input B
    input  [1:0]  op,     // 2-bit Operation Selector
    output reg [63:0] out // 64-bit Output
);
    always @(*) begin
        case(op)
            2'b00: out = a + b; // Add
            2'b01: out = a - b; // Subtract
            2'b10: out = a & b; // Bitwise AND
            2'b11: out = a | b; // Bitwise OR
            default: out = 64'b0;
        endcase
    end
endmodule
