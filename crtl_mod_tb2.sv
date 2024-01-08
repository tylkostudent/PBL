module crtl_mod_tb2;
	reg clk, rst, zero_flag;
	wire [OPCODE_WIDTH - 1:0] op_code;
	wire [VALUE_WIDTH - 1:0] source1, source2, destination;
	wire [1:0] source1_choice, source2_choice, destination_choice;
	wire push, pop;

	control_module constrol_module(
		//inputs 
		.clk(clk), 
		.rst(rst), 
		.zero_flag(zero_flag),
		//outputs
		.op_code(op_code),
		.source1(source1), 
		.source2(source2), 
		.destination(destination), 
		.source1_choice(source1_choice), 
		.source2_choice(source2_choice), 
		.destination_choice(destination_choice),
		.push(push), 
		.pop(pop)
	);

	always begin 
		#5 clk = ~clk;
	end
	initial begin
		clk = 1;
		rst = 1;
		zero_flag = 1;
		#10
		rst = 0;
		#30 
		zero_flag = 0;
		#40
		zero_flag = 1;
		#70
		zero_flag = 0;
		#50
		zero_flag = 1;
		#100
		$finish;
	end

	initial begin
		$dumpfile("sim.vcd");
		$dumpvars(0, crtl_mod_tb2);
		$dumpon;
	end
	
endmodule

