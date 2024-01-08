module pc#(
    parameter INSTR_ADDR_SIZE = 5
) (
    //inputs
    clk,
    rst, 
    jmp, // jmp == 1'b1 set counter to value specyfied in jmp_addr 
    ret, // specyfies if we use return address and sets values of instr_addr to ret_addr
    jmp_addr, //
    ret_addr,
   
    instr_addr // current instruction address (which instruction is currently used by alu)
);
    input clk, rst, jmp, ret;
    input [INSTR_ADDR_SIZE - 1:0] jmp_addr, ret_addr;
    output reg [INSTR_ADDR_SIZE - 1:0] instr_addr;

    always @(posedge clk)begin 
        if (rst) begin 
            instr_addr <= {INSTR_ADDR_SIZE{1'b0}}; 
        end
        else if (jmp) begin 
            instr_addr <= jmp_addr;
        end
        else if (ret) begin 
            instr_addr <= ret_addr;
        end
        else begin 
            instr_addr <= instr_addr + 1;
        end
    end 
endmodule
