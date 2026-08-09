module program_counter (
    input clk,                    // Clock signal to tick forward
    input reset,                  // Reset signal to start back at address 0
    input [63:0] next_pc,         // The next address calculated by the CPU
    output reg [63:0] current_pc  // The current address being executed
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_pc <= 64'b0;  // Start from the beginning on reset
        end else begin
            current_pc <= next_pc; // Move to the next address
        end
    end

endmodule
