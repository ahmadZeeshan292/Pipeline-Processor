module Fetch_register(
  input clk,
  input register_write,
  input IF_Flush,
  input [31:0] instruction,
  input [31:0]PC_next,
  output reg [6:0] opcode,   // Note: opcode has 7 bits in order to avoid 2's complement subtraction when MSB is 1
// I type instruction            //                                           ^
  output reg [15:0] offset,      //                                           |
// R type instruction            //                                           |
  output reg [4:0] rs2,          //                                           |
  output reg [4:0] rs1,          //                                           |
  output reg [4:0] rd,           //                                           |
  output reg [4:0] shamt,        //                                           |
  output reg [5:0] funct,        //                                           |
// J type instruction            //                                           |
  output reg [25:0] imm,         //                                           |
  output reg [31:0] PC_next_IF
);
