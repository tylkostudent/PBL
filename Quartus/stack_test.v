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


BCD_TO_7SEG tr1(
	.IN_BCD(q[3:0]),
	.OUT_7SEG(q1)
);

BCD_TO_7SEG tr2(
	.IN_BCD(q[7:4]),
	.OUT_7SEG(q2)
);


endmodule