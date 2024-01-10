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

ram_mlab_bit MEM1 (
	.clock(clk),
	.rdaddress({6'b00,port_a_address}),
	.wraddress({6'b00,port_c_address}),
	.data(port_c_data),
	.wren(port_c_we),
	.q(port_a_out)
);

ram_mlab_bit MEM2 (
	.clock(clk),
	.rdaddress({6'b00,port_b_address}),
	.wraddress({6'b00,port_c_address}),
	.data(port_c_data),
	.wren(port_c_we),
	.q(port_b_out)
);

endmodule