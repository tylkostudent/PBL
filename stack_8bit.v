`timescale 1 ns / 100 ps
//Models the IP Core RAM 1-Port used in Quartus

module stack_8bit #(
	parameter WIDTH = 8,
	parameter SIZE = 32
)(
	address,
	clock,
	data,
	wren,
	q
);

input	[$clog2(SIZE+1)-1:0]  address; //address 6'h00 == empty stack
input						clock;
input	[WIDTH-1:0]  		data;
input	  					wren;
output	[WIDTH-1:0]  		q;

reg 	[WIDTH-1:0] 		STACK 	[SIZE-1:0]; 

integer i;

initial begin
	for(i=0; i<SIZE;i++) begin
		STACK[i] = 8'h00;
	end
end

always @(posedge clock) begin
	if(wren & address > 6'h00) 
		STACK[address] <= data;
end

assign q = ((address > 6'h00) ? STACK[address] : 8'h00);

endmodule