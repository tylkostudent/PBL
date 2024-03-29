//`define PARAMETERS 1
//`ifndef PARAMETERS

parameter PC_WIDTH = 6;
parameter REGISTER_WIDTH = 8;
parameter NUMBER_OF_REGISTERS = 8;
parameter MEM_WIDTH = 8;

//Instruction is 4 bits instructin, 4 bits register, 8 bits address 
parameter INSTRUCTION_WIDTH = 40; 
parameter OPCODE_WIDTH = 6;
parameter REGISTER_ID_WIDTH = 8;
parameter VALUE_WIDTH = 8;
parameter ADDR_WIDTH = 8;

parameter TRUE   = 1'b1;
parameter FALSE  = 1'b0;

//DEFINE DEMO FOR A DEMO. 
`define DEMO 1
`define PBL 1

//`endif
