`timescale 1ns/100ps

module linked_reg#(
	parameter PC_SIZE = 5
)(
	input clk, ret, cal,
	input [PC_SIZE - 1:0] instr_addr,
	output reg [PC_SIZE - 1:0] ret_addr
);
	always @(posedge clk) begin 
		if (cal) begin 
			ret_addr <= instr_addr + 1;	
		end
	end
endmodule
