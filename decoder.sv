module decoder#(
	parameter PC_WIDTH = 5,
	parameter INSTR_ADDR_SIZE = 5,
	parameter OPCODE_WIDTH = 5,
	parameter VALUE_WIDTH = 8,
	parameter INSTRUCTION_WIDTH = 40
)
(
//	`include"instructions.h"
//	`include"parameters.h"
	//inputs
	instr, zero_flag,//instruction code from hex file
	//outputs
	op_code, //operation code if possible 4 bits
	source1, source2, //addresses for alu inputs 
	destination, //address for alu output 
	source1_choice, //source one choice 
	source2_choice, //source two choice
	destination_choice,
	jmp_addr,
	jmp, //jump to instruction given by jmp_addr
	cal, //jump to  instruction given by jmp_addr adn save return address in stack
	ret,  //jump to return address
	push, //push registers to stack	
	pop   //pop stack registers
);
	input [INSTRUCTION_WIDTH - 1:0] instr;
	input zero_flag;
	output [OPCODE_WIDTH - 1:0] op_code;
	output [VALUE_WIDTH - 1:0] source1;
	output [VALUE_WIDTH - 1:0] source2;
	output [VALUE_WIDTH - 1:0] destination;
	output [1:0] source1_choice, source2_choice, destination_choice;
	output [INSTR_ADDR_SIZE - 1:0] jmp_addr;
	output reg push, pop, jmp, cal, ret;
	
	assign op_code = instr[36:32];
	assign source1 = instr[31:24];
	assign source2 = instr[23:16];
	assign destination = instr[15:8];
	//[7:6] 
	assign source1_choice = instr[5:4];
	assign source2_choice = instr[3:2];
	assign destination_choice = instr[1:0]; 
	assign jmp_addr = source1[PC_WIDTH - 1:0]; 
	
	assign {push, pop, jmp, cal, ret} = (op_code == JMP) ? 5'b00100 :
				(op_code == IF0JUMP & zero_flag == 1'b0) ? 5'b00100 :
				(op_code == IF1JUMP & zero_flag == 1'b1) ? 5'b00100 :
									   (op_code == CALL) ? 5'b10110 : 
				   (op_code == CAL0 & zero_flag == 1'b0) ? 5'b10110 :
				   (op_code == CAL1 & zero_flag == 1'b1) ? 5'b10110 :
									    (op_code == RET) ? 5'b01001 :
				   (op_code == RET0 & zero_flag == 1'b0) ? 5'b01001 :
				   (op_code == RET1 & zero_flag == 1'b1) ? 5'b01001 :
														   5'b00000 ;	

	/*
	always @(op_code)begin 
		if (op_code == JMP)begin 
			{push, pop, jmp, cal, ret} <= 5'b00100;
		end
		else if (op_code == IF0JUMP & zero_flag == 1'b0)begin 
			{push, pop, jmp, cal, ret} <= 5'b00100;
		end
		else if (op_code == IF1JUMP & zero_flag == 1'b1)begin 
			{push, pop, jmp, cal, ret} <= 5'b00100;
		end
		else if(op_code == CALL)begin 
			{push, pop, jmp, cal, ret} <= 5'b10110;
		end
		else if (op_code == CAL0 & zero_flag == 1'b0)begin 
			{push, pop, jmp, cal, ret} <= 5'b10110;
		end
		else if (op_code == CAL1 & zero_flag == 1'b1)begin 
			{push, pop, jmp, cal, ret} <= 5'b10110;
		end
		else if(op_code == RET)begin 
			{push, pop, jmp, cal, ret} <= 5'b01001;
		end
		else if (op_code == RET0 & zero_flag == 1'b0)begin 
			{push, pop, jmp, cal, ret} <= 5'b01001;
		end
		else if (op_code == RET1 & zero_flag == 1'b1)begin 
			{push, pop, jmp, cal, ret} <= 5'b01001;
		end
		else begin
			{push, pop, jmp, cal, ret} <= 5'b00000;
		end 
	end
	*/
endmodule

