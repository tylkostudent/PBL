`timescale 1ns/100ps

module alu_mod #(
	parameter WIDTH = 8,
	parameter IWIDTH = 8,
	parameter SOURCES = 4,
	parameter ADDR_WIDTH = 8,
	parameter PC_WIDTH = 6
)(
	//inputs
	clk, op_code, source1, source2, source1_choice, source2_choice,
	destination, dest_choice, push, pop, instr_addr, rst,
	//outputs
	alu_out, zero_flag 
);
	input [PC_WIDTH - 1:0] instr_addr;
	input [ADDR_WIDTH - 1:0] destination; 
	input [1:0] dest_choice;
	input clk, push, pop, rst;
	input [IWIDTH-1:0] op_code; 
	input [WIDTH-1:0]source1, source2;
	input [$clog2(SOURCES)-1:0] source1_choice;
	wire bit_mem_a;
	wire [WIDTH-1:0] word_mem_a;
	wire [WIDTH-1:0] rf_a;

	input [$clog2(SOURCES)-1:0] source2_choice;
	reg bit_mem_b;
	reg [WIDTH-1:0] word_mem_b;
	reg [WIDTH-1:0] rf_b;

	reg alu_c_in;
	reg alu_b_in;

	output [WIDTH-1:0] alu_out;
	wire alu_c_out;
	wire alu_b_out;
    wire alu_flag_reg_valid;

	wire f_zero;
	output zero_flag;

	//decoder destination_choice 
	wire rf_data_we;
	wire bit_mem_we;
	wire word_mem_we;
	assign rf_data_we = (dest_choice == 2'b00) ? 1'b1 : 1'b0; 
	assign bit_mem_we = (dest_choice == 2'b01) ? 1'b1 : 1'b0; 
	assign word_mem_we = (dest_choice == 2'b10) ? 1'b1 : 1'b0; 

alu # (
    .WIDTH(WIDTH),
    .IWIDTH(IWIDTH),
    .SOURCES(SOURCES)) 
alu(
    .op_code(op_code),
    .source1_choice(source1_choice),
    .bit_mem_a(bit_mem_a),
    .word_mem_a(word_mem_a),
    .rf_a(rf_a),
    .imm_a(source1),
    .source2_choice(source2_choice),
    .bit_mem_b(bit_mem_b),
    .word_mem_b(word_mem_b),
    .rf_b(rf_b),
    .imm_b(source2),
    .alu_c_in(alu_c_in),
    .alu_b_in(alu_b_in),
    .alu_c_out(alu_c_out),
    .alu_b_out(alu_b_out),
    .alu_flag_valid(alu_flag_reg_valid),
    .alu_out(alu_out)   
);

flag_reg flag_reg(
    .clk(clk),
    .flag_rst(rst),
    .flag_cb_valid(alu_flag_reg_valid),
    .flag_c_in(alu_c_out),
    .flag_z_in(f_zero),
    .flag_b_in(alu_b_out),
    .flag_c(alu_c_in),
    .flag_z(zero_flag),
    .flag_b(alu_b_in)
);

reg_f#(
    .WIDTH(8),
    .SIZE(11),
    .PC_WIDTH(6)
)reg_f(
    .clk(clk),
    .rf_addr_r1(source1[3:0]),
    .rf_data_out1(rf_a),
    .rf_addr_r2(source2[3:0]),
    .rf_data_out2(rf_b),
    .rf_addr_wr(destination[3:0]),
    .rf_data_we(rf_data_we),
    .rf_data_in(alu_out), 

    //Stack interface
    .rf_stack_push(push),
    .rf_stack_pop(pop),
    .rf_stack_pointer(instr_addr),
    .rf_acc_zero(f_zero)
);

ram_word#(
    .WIDTH(ADDR_WIDTH),
    .AWIDTH(ADDR_WIDTH)
)ram_word(
    .clk(clk),
    .port_a_address(source1),
    .port_a_out(word_mem_a),
    .port_b_address(source2),
    .port_b_out(word_mem_b),
    .port_c_address(destination),
    .port_c_data(alu_out),
    .port_c_we(word_mem_we)
);

ram_bit#(
    .AWIDTH(ADDR_WIDTH)
)ram_bit (
    .clk(clk),
    .port_a_address(source1),
    .port_a_out(bit_mem_a),

    .port_b_address(source2),
    .port_b_out(bit_mem_b),

    .port_c_address(destination),
    .port_c_data(alu_out[0]),
    .port_c_we(bit_mem_we)
);

    
endmodule 
