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
);                               //                                           |
                                 //                                           |  
always @(posedge clk)            //                                           |
begin    
if(register_write == 0)  begin                                                   
// common data between all instructions
 opcode <=  {1'b0,instruction [31 :26]};   // Note: in opcode we can concatinating the opcode bits of instruction with 0
// common data between R and I type
 rs1<= instruction [25 :21];
 rs2 <= instruction [20 :16];
// R type instruction
 rd <= instruction[15:11];
 shamt <= instruction[10:6];
 funct <= instruction[5:0];
// I type instruction
 offset <= instruction[15:0];
// J type instruction
 imm <= instruction[25:0];
 PC_next_IF <= PC_next;
end
if(IF_Flush) begin
 opcode <=  7'd50;   
 rs1<= 5'd0;
 rs2 <= 5'd0;
 rd <= 5'd0;
 shamt <= 5'd0;
 funct <= 6'd0;
 offset <= 16'd0;
 imm <= 26'd0;
 PC_next_IF <= 32'd0;
end
  end

endmodule
