`timescale 1ns/100ps
`default_nettype none

`include "../../PBL/Modules/parameters.sv"

module MEMORY (pc, instruction);
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
      $readmemh("pbl.hex", memory,0,50);
    `else
      $readmemh("hex.hex", memory, 0, 45);   
   `endif

endmodule  
