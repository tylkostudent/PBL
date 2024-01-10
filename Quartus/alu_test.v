module alu_test #(
    parameter WIDTH = 3,
	 parameter AWIDTH = 2
)
(
    CLK,
	 A_ADDR,
	 B_ADDR,
	 C_ADDR,
	 C_WE,
	 C_IN,
	 C_DIN,
	 A_DATA_7,
	 B_DATA_7,
	 C_DATA_7,
	 OUT_7,
	 CARRY_OUT
);

input CLK, C_WE, C_IN;
input [AWIDTH-1:0] A_ADDR;
input [AWIDTH-1:0] B_ADDR;
input [AWIDTH-1:0] C_ADDR;
input [WIDTH-1:0] C_DIN;

wire [WIDTH-1:0] A_DATA;
wire [WIDTH-1:0] B_DATA;
wire [WIDTH-1:0] C_DATA;
wire [WIDTH-1:0] ALU_OUT;

output [6:0] A_DATA_7;
output [6:0] B_DATA_7;
output [6:0] C_DATA_7;
output [6:0] OUT_7;
output CARRY_OUT;

assign C_DATA = (C_IN ? C_DIN : ALU_OUT);

ram_word #(.AWIDTH(AWIDTH),.WIDTH(WIDTH))
ram_module (
    .CLK(!CLK),
    .PORT_A_ADDRESS(A_ADDR),
    .PORT_A_OUT(A_DATA),

    .PORT_B_ADDRESS(B_ADDR),
    .PORT_B_OUT(B_DATA),

    .PORT_C_ADDRESS(C_ADDR),
    .PORT_C_DATA(C_DATA),
    .PORT_C_WE(!C_WE)
);


alu #(.DWIDTH(WIDTH))
alu_module (
    .IN_INSTR(4'h5),
    .IN_A(A_DATA),
    .IN_B(B_DATA),
    .Cin(1'b0),
    .Cout(CARRY_OUT),
    .Bin(1'b0),
    .Bout(),
    .OUT(ALU_OUT)
);

led_disp tr1(
	.IN_BCD({1'b0, A_DATA}),
	.OUT_7SEG(A_DATA_7)
);

led_disp tr2(
	.IN_BCD({1'b0, B_DATA}),
	.OUT_7SEG(B_DATA_7)
);

led_disp tr3(
	.IN_BCD({1'b0, C_DATA}),
	.OUT_7SEG(C_DATA_7)
);

led_disp tr4(
	.IN_BCD({1'b0, ALU_OUT}),
	.OUT_7SEG(OUT_7)
);

endmodule