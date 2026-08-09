module cpu_top (
    input clk,
    input reset,
    input [31:0] instruction // Incoming 32-bit instruction word
);

    // Internal wires to connect the components together
    wire [63:0] current_pc;
    wire [63:0] next_pc;
    wire reg_write;
    wire [1:0] alu_op;
    wire [63:0] read_data1;
    wire [63:0] read_data2;
    wire [63:0] alu_result;

    // 1. Automatically calculate the next Program Counter address (PC + 4)
    assign next_pc = current_pc + 64'd4;

    // 2. Connect the Program Counter
    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    // 3. Connect the Control Unit (reads bits 0-6 of the instruction)
    control_unit cu_inst (
        .opcode(instruction[6:0]),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    // 4. Connect the Register Bank (reads bits 15-19 and 20-24, writes to 11-15)
    register_bank reg_bank_inst (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(instruction[19:15]),
        .read_reg2(instruction[24:20]),
        .write_reg(instruction[11:7]),
        .write_data(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // 5. Connect the ALU
    alu_64bit alu_inst (
        .a(read_data1),
        .b(read_data2),
        .op(alu_op),
        .out(alu_result)
    );

endmodule
