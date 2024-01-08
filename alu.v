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

assign in_a = (source1_choice[1] ? (source1_choice[0] ? imm_a : word_mem_a) : (source1_choice[0] ? bit_mem_a : rf_a));
assign in_b = (source2_choice[1] ? (source2_choice[0] ? imm_b : word_mem_b) : (source2_choice[0] ? bit_mem_b : rf_b));

initial begin
    alu_c_out = 1'b0;
    alu_b_out = 1'b0;
end

always @(*) begin
    case(op_code)
        8'h00: alu_out = in_a & in_b; //AND
        8'h01: alu_out = ~(in_a & in_b);//ANDN
        8'h02: alu_out = in_a | in_b; //OR
        8'h03: alu_out = ~(in_a | in_b); //ORN
        8'h04: alu_out = in_a ^ in_b; //XOR
        8'h05: alu_out = ~(in_a ^ in_b); //XORN
        8'h06: alu_out = ~in_a; //NOT
        8'h07: {alu_c_out, alu_out} = in_a + in_b + alu_c_in; //ADD
        8'h08: {alu_b_out, alu_out} = in_a - in_b - alu_b_in; //SUB
        8'h09: alu_out = in_a * in_b; //MUL
        8'h0A: alu_out = in_a / in_b; //DIV
        8'h0B: alu_out = in_a % in_b; //MOD
        8'h0C: alu_out = (in_a > in_b) ? 8'hFF : 8'h00; //GT
        8'h0D: alu_out = (in_a >= in_b) ? 8'hFF : 8'h00; //GE
        8'h0E: alu_out = (in_a == in_b);  //EQ
        8'h0F: alu_out = ~(in_a == in_b); //NE
        8'h10: alu_out = (in_a <= in_b) ? 8'hFF : 8'h00; //LE
        8'h11: alu_out = (in_a < in_b) ? 8'hFF : 8'h00; //LT
        8'h1B: alu_out = {WIDTH{1'b1}}; //S
        8'h1C: alu_out = {WIDTH{1'b0}}; //R
        8'h1D: alu_out = in_a; //ST
        8'h1E: alu_out = ~in_a; //STN
        8'h1F: alu_out = in_a; //LD
        8'h20: alu_out = ~in_a; //LDN
        default: alu_out = in_a;
    endcase
end

endmodule