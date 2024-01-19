from dataclasses import dataclass
from sys import argv


@dataclass
class Opcode:
    value: str
    args: list[str]
    arg_map: int

def read_opcodes(file_path)->dict[str, Opcode]:
    opcode_map: dict[str, Opcode] = {}
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.strip().split(' ')
            opcode_map[parts[0]] = Opcode(value = parts[1], arg_map = int(parts[2]), args = [])
    return opcode_map

def decode_choice(choice: str) -> str:
    bin_repr = ""
    match choice:
        case '0':
            bin_repr = "00"
        case '1':
            bin_repr = "01"
        case '2':
            bin_repr = "10"
        case '3':
            bin_repr = "11"
    return bin_repr

def decode_choices(choice: str, opcode_map: int) -> str:
    binary_str = ""
    if opcode_map == 2:
        binary_str = "000000" + decode_choice(choice[0])
    if opcode_map == 3:
        binary_str = "00" + decode_choice(choice[0]) + "0000"
    if opcode_map == 4:
        binary_str = "00" + decode_choice(choice[0]) + "00" + decode_choice(choice[1])
    if opcode_map == 5:
        binary_str = "00" + decode_choice(choice[0]) + decode_choice(choice[1]) + decode_choice(choice[2])
    decimal_number = int(binary_str, 2)
    hex_number = hex(decimal_number)[2:].zfill(2).upper()
    return hex_number 


def create_hex(opcode: Opcode) -> str:
    hex_str = ""
    match opcode.arg_map:
        case 0:
            hex_str = opcode.value + "00000000"
        case 1:
            hex_str = opcode.value + opcode.args[0] + "000000"
        case 2:
            hex_str = opcode.value + "0000" + opcode.args[0] + decode_choices(opcode.args[1], opcode.arg_map)
        case 3:
            hex_str = opcode.value + opcode.args[0] + "0000" + decode_choices(opcode.args[1], opcode.arg_map) 
        case 4:
            hex_str = opcode.value + opcode.args[0] + "00" + opcode.args[1] + decode_choices(opcode.args[2], opcode.arg_map) 
        case 5:
            hex_str = opcode.value + opcode.args[0] + opcode.args[1] + opcode.args[2] + decode_choices(opcode.args[3], opcode.arg_map) 
    return hex_str
    

def read_instr_file(file_path: str, opcode_map: dict[str, Opcode]) -> list[str]:
    hex_lines: list[str] = []
    with open(file_path, 'r') as file:
        for line in file:
            instr = line.strip().split(' ')
            opcode = opcode_map[instr[0]]
            opcode.args = instr[1:]
            hex_lines.append(create_hex(opcode))
    return hex_lines

def write_hex_file(file_path: str, hex_file_content: list[str]):
    with open(file_path, 'w') as file:
        for item in hex_file_content:
            file.write(str(item) + '\n')


opcode_map = read_opcodes(argv[1])
hex_file_contents = read_instr_file(argv[2], opcode_map)
write_hex_file(argv[3], hex_file_contents)


