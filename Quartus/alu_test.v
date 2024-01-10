//ALU TEST - Addition test
//Author: Paweł Orszulik

module alu_test #(
    parameter WIDTH = 3,
	 parameter AWIDTH = 2
)
(
    clk,
	a_addr,
	b_addr,
	c_addr,
	c_we,
	c_in,
	c_din,
	a_data_7,
	b_data_7,
	c_data_7,
	out_7,
	carry_out
);

input clk, c_we, c_in;
input [AWIDTH-1:0] a_addr;
input [AWIDTH-1:0] b_addr;
input [AWIDTH-1:0] c_addr;
input [WIDTH-1:0] c_din;

wire [WIDTH-1:0] a_data;
wire [WIDTH-1:0] b_data;
wire [WIDTH-1:0] c_data;
wire [WIDTH-1:0] alu_out;

output [6:0] a_data_7;
output [6:0] b_data_7;
output [6:0] c_data_7;
output [6:0] out_7;
output carry_out;

assign c_data = (c_in ? c_din : alu_out);

ram_word #(.AWIDTH(AWIDTH),.WIDTH(WIDTH))
ram_module (
    .clk(!clk),
    .port_a_addressS(a_addr),
    .port_a_out(a_data),

    .port_b_address(b_addr),
    .port_b_out(b_data),

    .port_c_address(c_addr),
    .port_c_data(c_data),
    .port_c_we(!c_we)
);


alu #(.DWIDTH(WIDTH))
alu_module (
	.op_code(8'h05),

    .source1_choice(2'b10),
    .bit_mem_a(1'b0),
    .word_mem_a(a_data),
    .rf_a(8'h00),
    .imm_a(8'h00), 

    .source2_choice(2'b10),
    .bit_mem_b(1'b0),
    .word_mem_b(b_data),
    .rf_b(8'h00),
    .imm_b(8'h00),

    .alu_c_in(1'b0),
    .alu_b_in(1'b0),
    .alu_c_out(carry_out),
    .alu_b_out(),
    .alu_flag_valid(),
    .alu_out(alu_out)
);

led_disp tr1(
	.in({1'b0, a_data}),
	.out(a_data_7)
);

led_disp tr2(
	.in({1'b0, b_data}),
	.out(b_data_7)
);

led_disp tr3(
	.in({1'b0, c_data}),
	.out(c_data_7)
);

led_disp tr4(
	.in({1'b0, alu_out}),
	.out(out_7)
);

endmodule