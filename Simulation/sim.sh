#!/bin/bash

#Hex generation
python3  ../scripts/hex_generator.py ../scripts/opcode_list.txt ../scripts/instruction_list.txt hex.hex

#Compilation
rm -f ./Output/sim.vcd

modules_dir="../Modules"
modules_list=""
modules_input="proc decoder stack memory pc2 control_module alu flag_reg ram_bit ram_word reg_f reg_f_stack stack_8bit alu_mod"


if [ "$#" -ne 0 ]; then
    if [ "$1" = "control" ]; then #Command ./sim.sh control -> iverilog will be provided with set of modules(listed below). It replaces the file sim.sh
        modules_input="proc decoder stack memory pc2 control_module"
    fi
fi

for i in $modules_input
do  
  modules_list+="$modules_dir/$i.sv "
done

iverilog -g2009 -Wall -s proc_tb -o ./Output/sim "$modules_dir"/tb/proc_tb.sv $modules_list 

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

#Simulation
vvp ./Output/sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi

rm -f ./Output/sim

