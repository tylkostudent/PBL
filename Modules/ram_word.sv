//Models the IP Core RAM 2-Port MLAB used in Quartus
//Author: Paweł Orszulik

`timescale 1ns/100ps

module ram_word #(
    parameter WIDTH = 8,
    parameter AWIDTH = 8
) (
    clk,
    port_a_address,
    port_a_out,

    port_b_address,
    port_b_out,

    port_c_address,
    port_c_data,
    port_c_we
);

input clk;
input [AWIDTH-1:0] port_a_address;
output [WIDTH-1:0] port_a_out;

input [AWIDTH-1:0] port_b_address;
output [WIDTH-1:0] port_b_out;

input [AWIDTH-1:0] port_c_address;
input [WIDTH-1:0] port_c_data;
input port_c_we;

reg [WIDTH-1:0] MEM [(2**AWIDTH)-1:0];

always @(posedge clk) begin
	 if(port_c_we) begin
		  MEM[port_c_address] <= port_c_data;
`ifdef SIMULATION   
`ifdef DEMO   
    $display (port_c_address, "        ",port_c_data);
`endif   
`endif
	 end
end


assign port_a_out = MEM[port_a_address];
assign port_b_out = MEM[port_b_address];

endmodule
