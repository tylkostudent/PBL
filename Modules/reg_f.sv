//Register File
//R0 - constant 8'h00
//R1 - constant 8'hFF
//R2 - accumulator(ACC)
//Author: Paweł Orszulik 

`timescale 1ns/100ps

module reg_f #(
    parameter PC_WIDTH = 5,
    parameter WIDTH = 8,
    parameter SIZE = 11
)(
    clk,
    rf_addr_r1,
    rf_data_out1,
    rf_addr_r2,
    rf_data_out2,
    rf_addr_wr,
    rf_data_we,
    rf_data_in, 

    //Stack interface
    rf_stack_push,
    rf_stack_pop,
    rf_stack_pointer,
    rf_acc_zero
);
input [$clog2(SIZE)-1:0] rf_addr_r1;
input [$clog2(SIZE)-1:0] rf_addr_r2;
input [$clog2(SIZE)-1:0] rf_addr_wr;
input rf_data_we;
input [WIDTH-1:0] rf_data_in;
input clk;
//Stack interface
input rf_stack_pop;
input rf_stack_push;
input [PC_WIDTH - 1:0] rf_stack_pointer;

output [WIDTH-1:0] rf_data_out1;
output [WIDTH-1:0] rf_data_out2;
output rf_acc_zero;

wire [WIDTH-1:0] st1_reg_out;
wire [WIDTH-1:0] st2_reg_out;
wire [WIDTH-1:0] st3_reg_out;
wire [WIDTH-1:0] st4_reg_out;
wire [WIDTH-1:0] st5_reg_out;
wire [WIDTH-1:0] st6_reg_out;
wire [WIDTH-1:0] st7_reg_out;
wire [WIDTH-1:0] st8_reg_out;
wire [WIDTH-1:0] st9_reg_out;

reg [WIDTH-1:0] REG_FILE [SIZE-1:0];

reg_f_stack stack(
    .clk(clk),
    .addr(rf_stack_pointer),
    .wren(rf_stack_push),
    .reg1_data(REG_FILE[2]),
    .reg2_data(REG_FILE[3]),
    .reg3_data(REG_FILE[4]),
    .reg4_data(REG_FILE[5]),
    .reg5_data(REG_FILE[6]),
    .reg6_data(REG_FILE[7]),
    .reg7_data(REG_FILE[8]),
    .reg8_data(REG_FILE[9]),
    .reg9_data(REG_FILE[10]),
    .stack1_out(st1_reg_out),
    .stack2_out(st2_reg_out),
    .stack3_out(st3_reg_out),
    .stack4_out(st4_reg_out),
    .stack5_out(st5_reg_out),
    .stack6_out(st6_reg_out),
    .stack7_out(st7_reg_out),
    .stack8_out(st8_reg_out),
    .stack9_out(st9_reg_out)
);

integer i;
initial begin
	REG_FILE[0] = {WIDTH{1'b0}};
	REG_FILE[1] = {WIDTH{1'b1}}; 
	//REG_FILE[2] - ACC
    //REG_FILE[3..10] - R0-R8 work registers

    for(i=2; i<SIZE;i++) begin
		REG_FILE[i] = 8'h00;
	end
end

always @(posedge clk) begin
    if(rf_data_we) begin
        if(rf_addr_wr > 1) 
            REG_FILE[rf_addr_wr] = rf_data_in;
    end
    if(rf_stack_push) begin
        //Clear the registers
		REG_FILE[2] <= REG_FILE[0];
		REG_FILE[3] <= REG_FILE[0];
		REG_FILE[4] <= REG_FILE[0];
		REG_FILE[5] <= REG_FILE[0];
		REG_FILE[6] <= REG_FILE[0];
		REG_FILE[7] <= REG_FILE[0];
		REG_FILE[8] <= REG_FILE[0];
		REG_FILE[9] <= REG_FILE[0];
		REG_FILE[10] <= REG_FILE[0];
	 end
	if(rf_stack_pop & rf_stack_pointer > 6'h00) begin
		REG_FILE[2] <= st1_reg_out;
		REG_FILE[3] <= st2_reg_out;
		REG_FILE[4] <= st3_reg_out;
		REG_FILE[5] <= st4_reg_out;
		REG_FILE[6] <= st5_reg_out;
		REG_FILE[7] <= st6_reg_out;
		REG_FILE[8] <= st7_reg_out;
		REG_FILE[9] <= st8_reg_out;
		REG_FILE[10] <= st9_reg_out;
	 end
end

assign rf_data_out1 = REG_FILE[rf_addr_r1];
assign rf_data_out2 = REG_FILE[rf_addr_r2];
assign rf_acc_zero = (((REG_FILE[2] == {WIDTH{1'b0}}) || ((rf_addr_wr == {{$clog2(SIZE)-2{1'b0}},2'b10} && rf_data_we && rf_data_in == {WIDTH{1'b0}}))) ? 1'b1 : 1'b0); 
//^^ Zero flag activation: If in ACC already is 8'h00 
// or if the data comming to ACC is equal to 8'h00 and the write enable is active. 
// The second check is made in order to set the Z flag earlier - this avoids the need to wait 
// in situation when we had just put 8'h00 in ACC and in next instruction we want to perform conditional jump(IFJUMP0).

endmodule 
