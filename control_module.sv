module control_module (
	//inputs 
	clk, rst, zero_flag,
	//outputs
	op_code,
	source1, source2, destination, 
	source1_choice, source2_choice, destination_choice,
	push, pop
);
	input clk, rst, zero_flag;
	output [OPCODE_WIDTH - 1:0] op_code;
	output [REGISTER_WIDTH - 1:0] source1, source2, destination;
	output [1:0] source1_choice, source2_choice, destination_choice;
	output push, pop; 
	wire [PC_WIDTH - 1:0] jmp_addr, ret_addr;
	wire [PC_WIDTH - 1:0] instr_addr;
	wire [INSTRUCTION_WIDTH - 1:0] instruction; 
	wire [OPCODE_WIDTH - 1:0] op_code;
	wire [VALUE_WIDTH - 1:0] source1, source2, destination;
	wire [1:0] source1_choice, source2_choice, destination_choice;
	wire cal, jmp, ret;	

	pc#(
		.INSTR_ADDR_SIZE(PC_WIDTH)
	)pc(
		//inputs
		.clk(clk),
		.rst(rst), 
		.jmp(jmp), // jmp == 1'b1 set counter to value specyfied in jmp_addr 
		.ret(ret), // specyfies if we use return address and sets values of instr_addr to ret_addr
		.jmp_addr(jmp_addr), //
		.ret_addr(ret_addr),
		.instr_addr(instr_addr) // current instruction address (which instruction is currently used by alu)
	);		

	MEMORY memory(
		.pc(instr_addr),
		.instruction(instruction)
	);	
	
	decoder#(
		.PC_WIDTH(PC_WIDTH),
		.INSTR_ADDR_SIZE(PC_WIDTH),
		.OPCODE_WIDTH(OPCODE_WIDTH),
		.VALUE_WIDTH(VALUE_WIDTH),
		.INSTRUCTION_WIDTH(INSTRUCTION_WIDTH)
	)
	decoder(
		.instr(instruction),
		.zero_flag(zero_flag),//instruction code from hex file
		//outputs
		.op_code(op_code), //operation code if possible 4 bits
		.source1(source1),
		.source2(source2), //addresses for alu inputs 
		.destination(destination), //address for alu output 
		.source1_choice(source1_choice), //source one choice 
		.source2_choice(source2_choice), //source two choice
		.destination_choice(destination_choice),
		.jmp_addr(jmp_addr),
		.jmp(jmp), //jump to instruction given by jmp_addr
		.cal(cal), //jump to  instruction given by jmp_addr adn save return address in stack
		.ret(ret),  //jump to return address
		.push(push), //push registers to stack	
		.pop(pop)   //pop stack registers
	);
	
	linked_reg#(
		.PC_SIZE(PC_WIDTH)
	)linked_reg(
		.clk(clk), 
		.ret(ret), 
		.cal(cal),
		.instr_addr(instr_addr),
		.ret_addr(ret_addr)
	);

endmodule
