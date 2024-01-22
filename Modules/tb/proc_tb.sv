`timescale 1ns/100ps
`include "instructions.sv" 
`define SIMULATION //if define includes simulation only code dont delete it 
module proc_tb;

reg rst, clk;
wire [OPCODE_WIDTH - 1:0]op_code;
wire [VALUE_WIDTH - 1:0] alu_out;
wire [MEM_WIDTH - 1:0] source1_addr, source2_addr, dest_addr;
wire [1:0] source1_choice, source2_choice, dest_choice;

proc u_proc(
    .clk(clk),
    .rst(rst),
    .op_code(op_code),
    .alu_out(alu_out),
    .source1_addr(source1_addr),
    .source2_addr(source2_addr),
    .dest_addr(dest_addr),
    .source1_choice(source1_choice),
    .source2_choice(source2_choice),
    .dest_choice(dest_choice)
);

    always begin 
	    #5 clk = ~clk;
    end
    initial begin
	    clk = 1;
	    rst = 1;
	    #10
	    rst = 0;
	    #1000
	    $finish;
    end

    initial begin
	    $dumpfile("./Output/sim.vcd");
	    $dumpvars(0, proc_tb);
	    $dumpon;
    end

endmodule
