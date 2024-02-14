//Arithmetic Logic Unit (ALU)
//Author: Paweł Orszulik

`timescale 1ns/100ps

module alu #(
    parameter WIDTH = 8,
    parameter IWIDTH = 8,
    parameter SOURCES = 4
)(
    op_code,

    source1_choice,
    bit_mem_a,
    word_mem_a,
    rf_a,
    imm_a, 

    source2_choice,
    bit_mem_b,
    word_mem_b,
    rf_b,
    imm_b,

    alu_c_in,
    alu_b_in,
    alu_c_out,
    alu_b_out,
    alu_flag_valid,
    alu_out
);

input [IWIDTH-1:0] op_code; 

input [$clog2(SOURCES)-1:0] source1_choice;
input bit_mem_a;
input signed [WIDTH-1:0] word_mem_a;
input signed [WIDTH-1:0] rf_a;
input signed [WIDTH-1:0] imm_a;
wire signed [WIDTH-1:0] in_a;

input [$clog2(SOURCES)-1:0] source2_choice;
input bit_mem_b;
input  signed [WIDTH-1:0] word_mem_b;
input signed [WIDTH-1:0] rf_b;
input signed [WIDTH-1:0] imm_b;
wire signed [WIDTH-1:0] in_b;

input alu_c_in;
input alu_b_in;

output reg signed [WIDTH-1:0] alu_out;
output reg alu_c_out;
output reg alu_b_out;
output reg alu_flag_valid;
reg signed [31:0] product;
   
assign in_a = (source1_choice[1] ? (source1_choice[0] ? imm_a : word_mem_a) : (source1_choice[0] ? bit_mem_a : rf_a));
assign in_b = (source2_choice[1] ? (source2_choice[0] ? imm_b : word_mem_b) : (source2_choice[0] ? bit_mem_b : rf_b));

initial begin
    alu_c_out = 1'b0;
    alu_b_out = 1'b0;
    alu_flag_valid = 1'b0;
end

always @(*) begin
    case(op_code)
        8'h00: begin //AND
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a & in_b; 
            alu_flag_valid = 1'b0;
        end

        8'h01: begin //ANDN 
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a & ~in_b;
            alu_flag_valid = 1'b0;
        end

        8'h02: begin //OR 
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a | in_b;
            alu_flag_valid = 1'b0;
        end

        8'h03: begin //ORN
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a | ~in_b;
            alu_flag_valid = 1'b0;
        end

        8'h04: begin //XOR
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a ^ in_b;
            alu_flag_valid = 1'b0;
        end

        8'h05: begin //XORN
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a ^ ~in_b; 
            alu_flag_valid = 1'b0;
        end

        8'h06: begin //NOT
            alu_c_out = 1'b0;
            alu_b_out = in_a ? 8'b0: 8'b1; 
            alu_out = in_a ? 8'b0: 8'b1;
            //alu_out = ~in_a ; 	   
            alu_flag_valid = 1'b0;
        end

        8'h07: begin //ADD
            alu_b_out = 1'b0;
            {alu_c_out, alu_out} = in_a + in_b + alu_c_in; 
            alu_flag_valid = 1'b1;
        end

        8'h08: begin //SUB
            alu_c_out = 1'b0;
            //{alu_b_out, alu_out} = in_a - in_b - alu_b_in;
            alu_out = in_a - in_b;	   
            alu_flag_valid = 1'b1;
	   //$display (in_a, "  ", in_b, "  ", alu_out,  " IN ALU");
	   
        end

        8'h09: begin //MUL
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
	   //$display ("MULTIPly %b", in_a, " * %b", in_b, "= %b", product, " or %b", alu_out);	   
            product = in_a * in_b;
            alu_out = {product[31], product[14:0]};
	   //$display ("MULTIPly %b", in_a, " * %b", in_b, "= %b", product, " or %b", alu_out);
	   
            alu_flag_valid = 1'b0;
        end

        8'h0A: begin //DIV
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a / in_b; 
            alu_flag_valid = 1'b0;
	    //$display (in_a, "  ", in_b, "  ", alu_out,  " IN DIV");
	    end

        8'h0B: begin //MOD
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a % in_b; 
            alu_flag_valid = 1'b0;
        end

        8'h0C: begin //GT
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = (in_a > in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        8'h0D: begin //GE
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = (in_a >= in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        8'h0E: begin //EQ
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = (in_a == in_b);
            alu_flag_valid = 1'b0;
        end

        8'h0F: begin //NE
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = ~(in_a == in_b); 
            alu_flag_valid = 1'b0;
        end

        8'h10: begin //LE
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = (in_a <= in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        8'h11: begin //LT
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = (in_a < in_b) ? 8'hFF : 8'h00; 
            alu_flag_valid = 1'b0;
        end

        8'h1B: begin //S
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = {WIDTH{1'b1}}; 
            alu_flag_valid = 1'b0;
        end

        8'h1C: begin //R
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = {WIDTH{1'b0}};
            alu_flag_valid = 1'b0;
        end

        8'h1D: begin //ST
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a; 
            alu_flag_valid = 1'b0;
        end

        8'h1E: begin //STN
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = ~in_a;
            alu_flag_valid = 1'b0;
        end 

        8'h1F: begin //LD
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a;
            alu_flag_valid = 1'b0;
        end

        8'h20: begin //LDN
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = ~in_a; 
            alu_flag_valid = 1'b0;
        end

        default: begin 
            alu_c_out = 1'b0;
            alu_b_out = 1'b0;
            alu_out = in_a;
            alu_flag_valid = 1'b0;
        end
    endcase
end

endmodule
