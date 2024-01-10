//Tests reg_F stack functionality - for Intel Quartus FPGA only

module reg_f_test(
    clk,
	seg1, 
	seg2,
    data_we,
	acc_zero,
	stack_push,
    stack_pop,
	stack_pointer,
);

input clk;
reg [3:0] addr_r1 = 4'h2;
reg [3:0] addr_wr = 4'h2;
reg [7:0] data_in = 8'h69; 
input data_we;
input stack_pop;
input stack_push;

output [6:0] seg1;
output [6:0] seg2;
output [6:0] stack_pointer;
output acc_zero;

wire [7:0] in_seg;

integer st_ptr = 0;

always @(*) begin
	if(stack_push) st_ptr = st_ptr + 1;
	else st_ptr = st_ptr;
	if(stack_pop) begin
		if(st_ptr > 0)
			st_ptr = st_ptr - 1;
		else st_ptr = st_ptr;
	end
end

reg_f REG_F(
    .clk(!clk),
    .rf_addr_r1(addr_r1),
    .rf_data_out1(in_seg),
    .rf_addr_r2(4'h0),
    .rf_data_out2(),
    .rf_addr_wr(addr_wr),
    .rf_data_we(data_we),
    .rf_data_in(data_in),

    //Stack interface
    .rf_stack_push(stack_push),
    .rf_stack_pop(stack_pop),
	.rf_stack_pointer(str_ptr),
    .rf_acc_zero(acc_zero)
);

BCD_TO_7SEG tr1(
	.IN_BCD(in_seg[3:0]),
	.OUT_7SEG(seg1)
);

BCD_TO_7SEG tr2(
	.IN_BCD(in_seg[7:4]),
	.OUT_7SEG(seg2)
);

BCD_TO_7SEG tr3(
	.IN_BCD(st_ptr),
	.OUT_7SEG(stack_pointer)
);

endmodule