module Decode_register(
input clk,
input register_write,
input [15:0] offset,
input [25:0] imm,
input [4:0] shamt,
input [5:0] funct,
input [31:0]PC_next,
input[4:0] rs2,
input [4:0] rs1,
input [4:0] rd,
input [31:0] read_data_1,  // missing imm ,funct, offset
input [31:0] read_data_2,
input RegDst,
input ALUsrc,
input Memwrite,
input Memread,
input Regwrite,
input Branch,
input [1:0] ALUop,
input MemtoReg,
input jump,
input FP_instruction,
input [3:0]FP_ALUop,
output reg [15:0] offset_DE,
output reg [25:0] imm_DE,
output reg [4:0] shamt_DE,
output reg [5:0] funct_DE,
output reg[31:0]PC_next_IF,
output reg[4:0] IF_rs2,
output reg[4:0] IF_rs1,
output reg[4:0] IF_rd,
output reg[31:0] read_data_1_IF,
output reg[31:0] read_data_2_IF,
output reg RegDst_IF,
output reg ALUsrc_IF,
output reg Memwrite_IF,
output reg Memread_IF,
output reg Regwrite_IF,
output reg Branch_IF,
output reg [1:0] ALUop_IF,
output reg MemtoReg_IF,
output reg jump_IF,
output reg FP_instruction_DE,
output reg [3:0]FP_ALUop_DE

);

always@(posedge clk)
begin
if(register_write == 0) begin
offset_DE <= offset;
imm_DE <= imm;
shamt_DE <= shamt;
funct_DE <= funct;
PC_next_IF <= PC_next;
IF_rs2 <= rs2;
IF_rs1 <= rs1;
IF_rd <= rd;
read_data_1_IF <= read_data_1;
read_data_2_IF <= read_data_2;
RegDst_IF <= RegDst;
ALUsrc_IF <= ALUsrc;
Memwrite_IF <= Memwrite;
Memread_IF <= Memread;
Regwrite_IF <= Regwrite;
Branch_IF <= Branch;
ALUop_IF <= ALUop;
MemtoReg_IF <= MemtoReg;
jump_IF <= jump;
FP_instruction_DE <= FP_instruction;
FP_ALUop_DE <= FP_ALUop;
 end
else begin
offset_DE <= 16'dx;
imm_DE <= 26'dx;
shamt_DE <= 4'dx;
funct_DE <= 5'dx;
PC_next_IF <= 32'dx;
IF_rs2 <= 5'dx;
IF_rs1 <= 5'dx;
IF_rd <= 5'dx;
read_data_1_IF <= 32'dx;
read_data_2_IF <= 32'dx;
RegDst_IF <= 1'dx;
ALUsrc_IF <= 1'dx;
Memwrite_IF <= 1'dx;
Memread_IF <= 1'dx;
Regwrite_IF <= 1'dx;
Branch_IF <= 1'dx;
ALUop_IF <= 2'dx;
MemtoReg_IF <= 1'dx;
jump_IF <= 1'dx;
FP_instruction_DE <= 1'dx;
FP_ALUop_DE <= 4'bx;
end
end
endmodule
