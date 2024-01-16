`ifndef INSTUCTIONS_H
`define INSTUCTIONS_H
`include"parameters.sv"
enum bit [OPCODE_WIDTH - 1:0] {
  AND  = 6'h00,
  ANDN = 6'h01,
  OR   = 6'h02,
  ORN  = 6'h03,
  XOR  = 6'h04,
  XORN = 6'h05,
  NOT  = 6'h06,
  ADD  = 6'h07,
  SUB  = 6'h08,
  MUL  = 6'h09,
  DIV  = 6'h0A,
  MOD  = 6'h0B,
  GT   = 6'h0C,
  GE   = 6'h0D,
  EQ   = 6'h0E,
  NE   = 6'h0F,
  LE   = 6'h10,
  LT   = 6'h11,
  JMP  = 6'h12,
  IF0JUMP = 6'h13,
  IF1JUMP = 6'h14,
  CALL = 6'h15,
  CAL0 = 6'h16,
  CAL1 = 6'h17,
  RET  = 6'h18,
  RET0 = 6'h19,
  RET1 = 6'h1A,
  SET  = 6'h1B,
  RST  = 6'h1C,
  ST   = 6'h1D,
  STN  = 6'h1E,
  LD   = 6'h1F,
  LDN  = 6'h20
}opCodes;
`endif
