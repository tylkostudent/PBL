module reg_f_stack #(
    parameter WIDTH = 8
)(
    clk,
    addr,
    wren,
    reg1_data,
    reg2_data,
    reg3_data,
    reg4_data,
    reg5_data,
    reg6_data,
    reg7_data,
    reg8_data,
    reg9_data,
    stack1_out,
    stack2_out,
    stack3_out,
    stack4_out,
    stack5_out,
    stack6_out,
    stack7_out,
    stack8_out,
    stack9_out
);

input clk;
input [4:0] addr;
input wren;

input [WIDTH-1:0] reg1_data;
input [WIDTH-1:0] reg2_data;
input [WIDTH-1:0] reg3_data;
input [WIDTH-1:0] reg4_data;
input [WIDTH-1:0] reg5_data;
input [WIDTH-1:0] reg6_data;
input [WIDTH-1:0] reg7_data;
input [WIDTH-1:0] reg8_data;
input [WIDTH-1:0] reg9_data;

output [WIDTH-1:0] stack1_out;
output [WIDTH-1:0] stack2_out;
output [WIDTH-1:0] stack3_out;
output [WIDTH-1:0] stack4_out;
output [WIDTH-1:0] stack5_out;
output [WIDTH-1:0] stack6_out;
output [WIDTH-1:0] stack7_out;
output [WIDTH-1:0] stack8_out;
output [WIDTH-1:0] stack9_out;

stack_8bit reg_stack1(
	.address(addr),
	.clock(clk),
	.data(reg1_data),
	.wren(wren),
	.q(stack1_out)
);

stack_8bit reg_stack2(
	.address(addr),
	.clock(clk),
	.data(reg2_data),
	.wren(wren),
	.q(stack2_out)
);

stack_8bit reg_stack3(
	.address(addr),
	.clock(clk),
	.data(reg3_data),
	.wren(wren),
	.q(stack3_out)
);

stack_8bit reg_stack4(
	.address(addr),
	.clock(clk),
	.data(reg4_data),
	.wren(wren),
	.q(stack4_out)
);

stack_8bit reg_stack5(
	.address(addr),
	.clock(clk),
	.data(reg5_data),
	.wren(wren),
	.q(stack5_out)
);

stack_8bit reg_stack6(
	.address(addr),
	.clock(clk),
	.data(reg6_data),
	.wren(wren),
	.q(stack6_out)
);

stack_8bit reg_stack7(
	.address(addr),
	.clock(clk),
	.data(reg7_data),
	.wren(wren),
	.q(stack7_out)
);

stack_8bit reg_stack8(
	.address(addr),
	.clock(clk),
	.data(reg8_data),
	.wren(wren),
	.q(stack8_out)
);

stack_8bit reg_stack9(
	.address(addr),
	.clock(clk),
	.data(reg9_data),
	.wren(wren),
	.q(stack9_out)
);

endmodule 