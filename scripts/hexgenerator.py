from dataclasses import dataclass
from sys import argv


@dataclass
class Opcode:
    value: str
    args: list[str]
    arg_map: int

defines: dict = {} 

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
        case '4':
            bin_repr = "01"
        case '5':
            bin_repr = "10"
            
    return bin_repr

def decode_choices(choice: str, opcode_map: int) -> str:
    binary_str = ""
    if opcode_map == 1:  # IF0JUMP
        binary_str = (
                      "00" +
                      decode_choice(choice[0]) +
                      decode_choice(choice[1]) +
                      "00"               
                     )
        print (binary_str)   
    if opcode_map == 2:
        binary_str = "000000" + decode_choice(choice[0])
        
    if opcode_map == 3:  # ONLY LOAD
        output = choice[1]
        inRegisterAddress = (("4" == choice[0]) or
                              ("5" == choice[0]))
        
        outRegisterAddress = (("4" == choice[1]) or
                              ("5" == choice[1]))                             
        binary_str = (
                      ("1" if inRegisterAddress else "0")+
                      ("1" if outRegisterAddress else "0")+            
                      decode_choice(choice[0]) +
                      "00" +
                      decode_choice(choice[1]) 
                      )
        print (binary_str)
    if opcode_map == 4:  # ONLY NOT
        binary_str = "00" + decode_choice(choice[0]) + "00" + decode_choice(choice[1])
    if opcode_map == 5:  # ALU OPERATIONS
        output = choice[1]
        oneRegisterAddress =(("4" == choice[0]) or
                              ("5" == choice[0]))
        
        twpRegisterAddress = (("4" == choice[1]) or
                              ("5" == choice[1]))                             
        binary_str = (
                      ("1" if oneRegisterAddress else "0")+
                      ("1" if twpRegisterAddress else "0")+            
                        decode_choice(choice[0]) +
                        decode_choice(choice[1]) +
                        decode_choice(choice[2])
            )
    if opcode_map == 6:
        binary_str = "000000" + decode_choice(choice[0])  
    decimal_number = int(binary_str, 2)
    hex_number = hex(decimal_number)[2:].zfill(2).upper()
    return hex_number 

def decode_arg(arg: str)->str:
    hex = defines.get(arg)
    if hex == None:
        return arg 
    return hex

def create_hex(opcode: Opcode) -> str:
    hex_str = ""
    match opcode.arg_map:
        case 0:
            hex_str = opcode.value + "00000000"
        case 1:
            hex_str = (opcode.value +
                       decode_arg(opcode.args[0]) +
                       decode_arg(opcode.args[1]) +
                       "00" +
                       decode_choices(opcode.args[2], opcode.arg_map) )             
            print (opcode.value + " " +
                   decode_arg(opcode.args[0]) +  " " +
                   decode_arg(opcode.args[1]) +  " " +                   
                       decode_choices(opcode.args[2], opcode.arg_map) )

        case 2:
            hex_str = opcode.value + "0000" + decode_arg(opcode.args[0]) + decode_choices(opcode.args[1], opcode.arg_map)
        case 3:
            hex_str = (opcode.value +
                      decode_arg(opcode.args[0]) +
                      "00" +
                      decode_arg(opcode.args[1]) +                       
                      decode_choices(opcode.args[2], opcode.arg_map) )
        case 4:
            hex_str = opcode.value + decode_arg(opcode.args[0]) + "00" + decode_arg(opcode.args[1]) + decode_choices(opcode.args[2], opcode.arg_map)
            print (opcode.value + " " + 
                   decode_arg(opcode.args[0]) +  " " + 
                   "00" +  " " + 
                   decode_arg(opcode.args[1]) +   " " + 
                   decode_choices(opcode.args[2], opcode.arg_map) +  " "  
                   )
        case 5:
            hex_str = (opcode.value +
                       decode_arg(opcode.args[0]) +
                       decode_arg(opcode.args[1]) +
                       decode_arg(opcode.args[2]) +
                       decode_choices(opcode.args[3], opcode.arg_map))
            
            print (opcode.value +  " " +
                   decode_arg(opcode.args[0]) + " " +
                   decode_arg(opcode.args[1]) + " " +
                   decode_arg(opcode.args[2]) + " " +
                   decode_choices(opcode.args[3], opcode.arg_map))
                     
        case 6:
            hex_str = opcode.value + "0200" + decode_arg(opcode.args[0]) + decode_choices(opcode.args[1], opcode.arg_map)
    print (hex_str)        
    return hex_str
    

def read_instr_file(file_path: str, opcode_map: dict[str, Opcode]) -> list[str]:
    hex_lines: list[str] = []
    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('//'):
                continue 
            if line.isspace():
                continue
            print ("\n", line[0:-1])
            #Allow comments on each line. 
            parts = line.split ("//")[0]
            #The next line splits on one or more spaces. 
            instr = parts.strip().split()
            if instr[0] == "def":
                defines[instr[1]] = instr[2] 
            else: 
                opcode = opcode_map[instr[0]]
                opcode.args = instr[1:]
                try:
                  hex = create_hex(opcode)
                except:
                    breakpoint()
                hex_lines.append(hex)
    return hex_lines

def write_hex_file(file_path: str, hex_file_content: list[str]):
    with open(file_path, 'w') as file:
        for item in hex_file_content:
            file.write(str(item) + '\n')


opcode_map = read_opcodes(argv[1])
hex_file_contents = read_instr_file(argv[2], opcode_map)
write_hex_file(argv[3], hex_file_contents)


