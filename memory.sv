`default_nettype none


module MEMORY (pc, instruction);
    parameter INSTRUCTION_WIDTH = 40;
    parameter PC_WIDTH = 5;
    input [PC_WIDTH - 1 : 0] pc;
    output reg [INSTRUCTION_WIDTH - 1 : 0] instruction;
    `ifdef PBL   
       reg [INSTRUCTION_WIDTH - 1: 0] memory [0:255];
    `else
      reg [INSTRUCTION_WIDTH - 1: 0] memory [0:255];       
    `endif
   
    assign instruction = memory [pc];

   
initial
    `ifdef PBL
      $readmemh("pbl.hex", memory);
    `else
      $readmemh("hex.hex", memory, 0, 29);
   `endif
endmodule  
