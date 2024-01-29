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

   initial #1 $display ("TIME   EVENT");
   
always @(posedge clk) begin
    if(port_c_we)
       	MEM[port_c_address] <= port_c_data;

    `ifdef SIMULATION          
    if(port_c_we & 	
       (MEM [port_c_address] != port_c_data))
           case(port_c_address)
              8'd0 : $display(MEM[3], "Pressure =", port_c_data);
              8'd2 : $display(MEM[3]," Motor Starts =", port_c_data);
              8'd3 : $display(MEM[3], " TEMP =", port_c_data);
              default:;
           endcase
       ;
    `endif
end

assign port_a_out = MEM[port_a_address];
assign port_b_out = MEM[port_b_address];

endmodule
