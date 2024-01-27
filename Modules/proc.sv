`timescale 1ns/100ps
`include "instructions.sv"

module proc(
	input clk, rst,
	output zero_flag,
	output [OPCODE_WIDTH - 1:0]op_code,
	output [VALUE_WIDTH - 1:0] alu_out,
	output [VALUE_WIDTH - 1:0] source1_addr,
	output [VALUE_WIDTH - 1:0] source2_addr,
	output [VALUE_WIDTH - 1:0] dest_addr,
	output [1:0] source1_choice, source2_choice, dest_choice
);
wire push, pop, zero_flag_wire;

assign zero_flag = zero_flag_wire;

wire [PC_WIDTH - 1:0] instr_addr;
control_module control_module(
	//inputs 
	.clk(clk), 
	.rst(rst), 
	.zero_flag(zero_flag_wire),
	//outputs
	.op_code(op_code),
	.source1(source1_addr), 
	.source2(source2_addr), 
	.destination(dest_addr), 
	.source1_choice(source1_choice), 
	.source2_choice(source2_choice), 
	.destination_choice(dest_choice),
	.push(push), 
	.pop(pop),
	.instr_addr(instr_addr)
);

alu_mod#(
	.WIDTH(VALUE_WIDTH),
	.IWIDTH(VALUE_WIDTH),
	.SOURCES(4),
	.ADDR_WIDTH(ADDR_WIDTH),
	.PC_WIDTH(PC_WIDTH)
)alu_mod(
	//inputs
	.clk(clk), 
	.op_code({2'b00, op_code}), 
	.source1(source1_addr), 
	.source2(source2_addr), 
	.source1_choice(source1_choice), 
	.source2_choice(source2_choice),
	.destination(dest_addr), 
	.dest_choice(dest_choice), 
	.push(push),
	.pop(pop), 
	.instr_addr(instr_addr), 
	.rst(rst),
	//outputs
	.alu_out(alu_out), 
	.zero_flag(zero_flag_wire) 
);


endmodule
