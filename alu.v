`timescale 1ns/100ps

module alu #(
    parameter WIDTH = 8,
    parameter IWIDTH = 8,
    parameter SOURCES = 4
)(
    op_code,

    source1_choice,
    bit_mem_a,
    word_mem_a,
    rf_a,
    imm_a, 

    source2_choice,
    bit_mem_b,
    word_mem_b,
    rf_b,
    imm_b,

    alu_c_in,
    alu_b_in,
    alu_c_out,
    alu_b_out,
    alu_flag_valid,
    alu_out
);

input [IWIDTH-1:0] op_code; 

input [$clog2(SOURCES)-1:0] source1_choice;
input bit_mem_a;
input [WIDTH-1:0] word_mem_a;
input [WIDTH-1:0] rf_a;
input [WIDTH-1:0] imm_a;
wire [WIDTH-1:0] in_a;

input [$clog2(SOURCES)-1:0] source2_choice;
input bit_mem_b;
input [WIDTH-1:0] word_mem_b;
input [WIDTH-1:0] rf_b;
input [WIDTH-1:0] imm_b;
wire [WIDTH-1:0] in_b;

input alu_c_in;
input alu_b_in;

output reg [WIDTH-1:0] alu_out;
output reg alu_c_out;
output reg alu_b_out;
output reg alu_flag_valid;

assign in_a = (source1_choice[1] ? (source1_choice[0] ? imm_a : word_mem_a) : (source1_choice[0] ? bit_mem_a : rf_a));
assign in_b = (source2_choice[1] ? (source2_choice[0] ? imm_b : word_mem_b) : (source2_choice[0] ? bit_mem_b : rf_b));

initial begin
    alu_c_out = 1'b0;
    alu_b_out = 1'b0;
    alu_flag_valid = 1'b0;
end

always @(*) begin
    case(op_code)
        `AND: begin 
            alu_out = in_a & in_b; 
            alu_flag_valid = 1'b0;
        end

        `ANDN: begin 
            alu_out = ~(in_a & in_b);
            alu_flag_valid = 1'b0;
        end

        `OR: begin 
            alu_out = in_a | in_b;
            alu_flag_valid = 1'b0;
        end

        `ORN: begin
            alu_out = ~(in_a | in_b);
            alu_flag_valid = 1'b0;
        end

        `XOR: begin
            alu_out = in_a ^ in_b;
            alu_flag_valid = 1'b0;
        end

        `XORN: begin
            alu_out = ~(in_a ^ in_b); 
            alu_flag_valid = 1'b0;
        end

        `NOT: begin
            alu_out = ~in_a; 
            alu_flag_valid = 1'b0;
        end

        `ADD: begin
            {alu_c_out, alu_out} = in_a + in_b + alu_c_in; 
            alu_flag_valid = 1'b1;
        end

        `SUB: begin
            {alu_b_out, alu_out} = in_a - in_b - alu_b_in;
            alu_flag_valid = 1'b1;
        end

        `MUL: begin alu_out = in_a * in_b;
            alu_flag_valid = 1'b0;
        end

        `DIV: begin
            alu_out = in_a / in_b; 
            alu_flag_valid = 1'b0;
        end

        `MOD: begin 
            alu_out = in_a % in_b; 
            alu_flag_valid = 1'b0;
        end

        `GT: begin
            alu_out = (in_a > in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        `GE: begin
            alu_out = (in_a >= in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        `EQ: begin
            alu_out = (in_a == in_b);
            alu_flag_valid = 1'b0;
        end

        `NE: begin
            alu_out = ~(in_a == in_b); 
            alu_flag_valid = 1'b0;
        end

        `LE: begin
            alu_out = (in_a <= in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        `LT: begin
            alu_out = (in_a < in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        `S: begin
            alu_out = {WIDTH{1'b1}}; 
            alu_flag_valid = 1'b0;
        end

        `R: begin
            alu_out = {WIDTH{1'b0}};
            alu_flag_valid = 1'b0;
        end

        `ST: begin
            alu_out = in_a; 
            alu_flag_valid = 1'b0;
        end

        `STN: begin
            alu_out = ~in_a;
            alu_flag_valid = 1'b0;
        end 

        `LD: begin
            alu_out = in_a;
            alu_flag_valid = 1'b0;
        end

        `LDN: begin
            alu_out = ~in_a; 
            alu_flag_valid = 1'b0;
        end

        default: begin 
            alu_out = in_a;
            alu_flag_valid = 1'b0;
        end
    endcase
end

endmodule
