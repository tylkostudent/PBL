module stack_test(
	clk,
	wren,
	addr,
	q1,
	q2,
	in_sel
);

input clk, wren;
input [4:0] addr;
input [1:0] in_sel;
output [6:0] q1;
output [6:0] q2;

wire [7:0] in;
wire [7:0] q;

assign in = (in_sel[1] ? (in_sel[0] ? 8'h69 : 8'h77) : (in_sel[0] ? 8'h12 : 8'h00));

stack_8bit UUT(
	.address(addr),
	.clock(!clk),
	.data(in),
	.wren(wren),
	.q(q)
);


led_disp tr1(
	.in(q[3:0]),
	.out(q1)
);

led_disp tr2(
	.in(q[7:4]),
	.out(q2)
);


endmodule