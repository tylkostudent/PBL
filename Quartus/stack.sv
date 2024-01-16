module stack (clock, call, ret, reset, called_from, return_to);
   input call;
   input ret;
   input reset;
   input		      clock;
   input [PC_WIDTH-1:0] called_from;
   output reg [PC_WIDTH-1:0] return_to;   
   reg  [PC_WIDTH-1:0]	       returnStack[16];
   reg  [3:0]		       stackOffset;
   reg  [3:0]	               previousStackOffset;  

//We do not want a negative stack offset   
assign previousStackOffset = stackOffset ? (stackOffset -1) : 0;
assign return_to = returnStack [previousStackOffset];


//BIT INSTRUCTION VERSION  
always @(posedge clock)
  if (call == 1'b1)begin
    returnStack [stackOffset] <= called_from + 1;
  end
   
always @ (posedge clock) begin  
  case ({call,ret,reset})
    3'b100: stackOffset <= stackOffset + 1'b1;
    3'b010: stackOffset <= stackOffset - 1'b1;
    3'b001: stackOffset <= 0;
    default: stackOffset <= stackOffset; 
  endcase // case (reset_code)
end

initial begin
  stackOffset = 0;
end

endmodule  
