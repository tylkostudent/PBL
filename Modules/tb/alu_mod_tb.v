`timescale 1ns/100ps

module alu_mod_tb;
    reg clk, rst;
    reg [7:0] op_code;
    reg [7:0]source1;
    reg [7:0]source2;
    reg [1:0]source1_choice;
    reg [1:0]source2_choice;
    reg [7:0]destination;
    reg [1:0]dest_choice;
    reg push;
    reg pop;
    reg [5:0]instr_addr;
    //outputs
    wire [7:0] alu_out;

    alu_mod#(
        .WIDTH(8),
        .IWIDTH(8),
        .SOURCES(4)
    )alu_mod(
        //inputs
        .clk(clk),
        .op_code(op_code),
        .source1(source1),
        .source2(source2),
        .source1_choice(source1_choice),
        .source2_choice(source2_choice),
        .destination(destination), 
        .dest_choice(dest_choice),
        .push(push),
        .pop(pop),
        .rst(rst),
        .instr_addr(instr_addr),
        //outputs
        .alu_out(alu_out) 
    );

	always begin 
		#5 clk = ~clk;
	end
	initial begin
		clk = 1;
		rst = 1;
		#100
		$finish;
	end

	initial begin
		$dumpfile("./Output/sim.vcd");
		$dumpvars(0, alu_mod_tb);
		$dumpon;
	end
	
endmodule
