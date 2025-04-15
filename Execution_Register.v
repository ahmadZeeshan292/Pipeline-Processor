module Execution_register(
input clk,
input [31:0]PC_next,
input[4:0] rt,
input [4:0] rs,
input [4:0] rd,
input [31:0] ALU_result,
input [31:0] read_data_2_DE,
input Memwrite,
input Memread,
input Regwrite,
input Branch,
input MemtoReg,
input jump,
output reg[31:0]PC_next_Exe,
output reg[4:0] Exe_rt,
output reg[4:0] Exe_rs,
output reg[4:0] Exe_rd,
output reg [31:0] ALU_result_Exe,
output reg [31:0] read_data_2_Exe,
output reg Memwrite_Exe,
output reg Memread_Exe,
output reg Regwrite_Exe,
output reg Branch_Exe,
output reg MemtoReg_Exe,
output reg jump_Exe

);

always@(posedge clk)
begin
//if(register_write == 0) begin
PC_next_Exe <= PC_next;
Exe_rt <= rt;
Exe_rs <= rs;
Exe_rd <= rd;
ALU_result_Exe <= ALU_result;
Memwrite_Exe <= Memwrite;
Memread_Exe <= Memread;
Regwrite_Exe <= Regwrite;
Branch_Exe <= Branch;
MemtoReg_Exe <= MemtoReg;
jump_Exe <= jump;
// end
/*else begin
PC_next_Exe <= 32'dx;
Exe_rs2 <= 5'dx;
Exw_rs1 <= 5'dx;
Exe_rd <= 5'dx;
Memwrite_Exe <= 1'dx;
Memread_Exe <= 1'dx;
Regwrite_Exe <= 1'dx;
Branch_Exe <= 1'dx;
MemtoReg_Exe <= 1'dx;
jump_Exe <= 1'dx;
end*/
end
endmodule
