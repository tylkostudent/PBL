![image](https://github.com/tylkostudent/PBL/assets/92595771/53e9f5f9-bac9-410e-a76b-e3913262146a)# PBL 
Our minimal PBL processor. Only base modules used in schematic added. 
Its working but needs further testing.
Tochange program edit instruction_list.txt file and change value of $readmemh last agrument to match the number of instructions
For testing run ./sim.sh located in Simulation directory
it generates new hex file from file with opcodes and instruction_list.txt then it simulates processor using iverilog 
TO add gtkwave_filter.txt as filter. 
-RIGTH CLICK on op_code and select data format and change to binary
-select op_code again, select data format, select translate filter file -> select and enable. 
-choose fileter file and select gtkwave_filter.txt file

Instruction list:
| op_code | Instruction  | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
|---------|--------------|---------------------|----------------------|-------------------------|-------------|----------------------|----------------------|---------------------------|
| 8’h00   | AND          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h01   | ANDN         | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h02   | OR           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h03   | ORN          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h04   | XOR          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h05   | XORN         | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h06   | NOT          | arg1 (source1) 8bit | -                    | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | -                    | Destination_choice 2 bits |
| 8’h07   | ADD          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h08   | SUB          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h09   | MUL          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0A   | DIV          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0B   | MOD          | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0C   | GT           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0D   | GE           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0E   | EQ           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h0F   | NE           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h10   | LE           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h11   | LT           | arg1 (source1) 8bit | arg2(source2) 8 bits | arg3(destination) 8bits | 2 free bits | Source1_choice 2bits | Source2_choice 2bits | Destination_choice 2 bits |
| 8’h12   | JMP          | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h13   | JMP0         | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h14   | JMP1         | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h15   | CAL          | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h16   | CAL0         | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h17   | CAL1         | jmp_addr            | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h18   | RET          | -                   | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h19   | RET0         | -                   | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h1A   | RET1         | -                   | -                    | -                       | 2 free bits | -                    | -                    | -                         |
| 8’h1B   | S            | -                   | -                    | arg3(destination) 8bits | 2 free bits | -                    | -                    | Destination_choice 2 bits |
| 8’h1C   | R            | -                   | -                    | arg3(destination) 8bits | 2 free bits | -                    | -                    | Destination_choice 2 bits |
| 8’h1D   | ST           | -                   | -                    | arg3(destination) 8bits | 2 free bits | -                    | -                    | Destination_choice 2 bits |
| 8’h1E   | STN          | -                   | -                    | arg3(destination) 8bits | 2 free bits | -                    | -                    | Destination_choice 2 bits |
| 8’h1F   | LD           | arg1 (source1) 8bit | -                    | -                       | 2 free bits | Source1_choice 2bits | -                    | -                         |
| 8’h20   | LDN          | arg1 (source1) 8bit | -                    | -                       | 2 free bits | Source1_choice 2bits | -                    | -                         |

Source_choice / destination_choice table:
| choice  |             |
|---------|-------------|
| 2’b00   | register    |
| 2’b01   | bit memory  |
| 2’b10   | word memory |
| 2’b11   | immediate   |

![Processor_schematic drawio](https://github.com/tylkostudent/PBL/assets/92595771/1bd06a28-bdaa-4e59-9b97-0def459166c3)
Instruction:
![Instructions](https://github.com/tylkostudent/PBL/assets/92595771/664ae416-33ba-4bcf-828a-521518de8dc3)
