import sys     

def read_opcodes(file_path):
    op_code_map = {}
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.strip().split('=')
            if len(parts) == 2:
                op_code_name = parts[0].strip()
                op_code_value = parts[1].strip()
                op_code_map[op_code_name] = op_code_value
    return op_code_map

def read_instructions(file_path):
    instructions = []
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.strip().split()
            opcode_name = parts[0]
            instructions.append([opcode_name, parts[1], parts[2], parts[3], parts[4]])
    return instructions

def change_to_hex(number_string: str)->str:
    binary_string = "00"
    for char in number_string:
        match char:
            case "0":
                binary_string = binary_string + "00"
            case "1":
                binary_string = binary_string + "01"
            case "2":
                binary_string = binary_string + "10"
            case "3":
                binary_string = binary_string + "11"
    decimal_number = int(binary_string, 2)
    hex_number = hex(decimal_number)[2:].zfill(2).upper()
    return hex_number

def create_hexfile(op_code_map, instructions)->list[str]:
    lines = []
    for instruction in instructions:
        line = op_code_map[instruction[0]] + "_" + instruction[1] + "_" + instruction[2] + "_" + instruction[3] + "_" + change_to_hex(instruction[4])  
        lines.append(line) 
    return lines

def write_hex_file(file_path: str, hex_file_content: list[str]):
    with open(file_path, 'w') as file:
        for item in hex_file_content:
            file.write(str(item) + '\n')
      

op_code_map = read_opcodes(sys.argv[1])
instructions = read_instructions(sys.argv[2])
hex_file_content = create_hexfile(op_code_map, instructions)
write_hex_file(sys.argv[3], hex_file_content)
    
