//Models the IP Core RAM 2-Port MLAB used in Quartus
//Author: Paweł Orszulik

`timescale 1ns/100ps

module ram_bit #(
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
output port_a_out;

input [AWIDTH-1:0] port_b_address;
output port_b_out;

input [AWIDTH-1:0] port_c_address;
input port_c_data;
input port_c_we;

reg MEM [(2**AWIDTH)-1:0];

always @(posedge clk) begin
    if(port_c_we) begin
	MEM[port_c_address] <= port_c_data;
        `ifdef SIMULATION          
        if(port_c_we & 	
           (MEM [port_c_address] != port_c_data))
           case(port_c_address)
              8'd0 : if (port_c_data == 1)
               	        $display("    Starting.");
              8'd1 :  if (port_c_data == 0)
                        $display("    Stoping.");
              8'd3 : if (port_c_data == 0)
                        $display("    Lamp is on.");
     	             else
  		        $display("    Lamp is off.");
	     
              8'd4 : if (port_c_data == 1)
                        $display("    Motor is on. ");
     	            else 
		        $display("      Motor is off.");
              8'd5 : if (port_c_data == 1)
                        $display("    The motor was started 3 times.");
              default:;
           endcase
       ;
    `endif
	 end
end

assign port_a_out = MEM[port_a_address];
assign port_b_out = MEM[port_b_address];

endmodule
