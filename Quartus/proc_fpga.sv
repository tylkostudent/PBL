`include "instructions.sv"

module proc_fpga(
	input clk, rst,
	output zero_flag,
	output [6:0] op_code_disp1,
    output [6:0] op_code_disp2,
	output [6:0] alu_out_disp1,
    output [6:0] alu_out_disp2,
	// output [6:0] source1_addr_disp,
	// output [6:0] source2_addr_disp,
	// output [6:0] dest_addr_disp,
	output [1:0] source1_choice_disp, source2_choice_disp, dest_choice_disp
);

wire [OPCODE_WIDTH-1:0] op_code_to_7seg;
wire [VALUE_WIDTH-1:0] alu_out_to_7seg;

proc cpu1(
	.clk(clk), 
    .rst(rst),
	.zero_flag(zero_flag),
	.op_code(op_code_to_7seg),
	.alu_out(alu_out_to_7seg),
	.source1_addr(),
	.source2_addr(),
	.dest_addr(),
	.source1_choice(source1_choice_disp), 
    .source2_choice(source2_choice_disp), 
    .dest_choice(dest_choice_disp)
);

led_disp op_code_led_disp1(
    .in(op_code_to_7seg[5:4]),
    .out(op_code_disp1)
);

led_disp op_code_led_disp2(
    .in(op_code_to_7seg[3:0]),
    .out(op_code_disp2)
);

led_disp alu_out_led_disp1(
    .in(alu_out_to_7seg[7:4]),
    .out(alu_out_disp1)
);

led_disp alu_out_led_disp2(
    .in(alu_out_to_7seg[3:0]),
    .out(alu_out_disp2)
);

endmodule