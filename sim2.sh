python3  scripts/hex_generator.py scripts/opcode_list.txt scripts/instruction_list.txt hex.hex
rm sim_files/sim sim_files/sim.vcd
iverilog -g2009 -Wall -s proc_tb -o sim_files/sim proc.sv proc_tb.sv decoder.sv stack.sv memory.sv pc2.sv control_module.sv alu.v flag_reg.v ram_bit.v ram_word.v reg_f.v reg_f_stack.v stack_8bit.v alu_mod.sv
vvp sim_files/sim 
