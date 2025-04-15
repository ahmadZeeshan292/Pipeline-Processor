module Data_Memory_register(
input clk,
input Regwrite_Exe,
input [31:0] write_data,
input [4:0] Exe_rd,
output reg Regwrite_Mem,
output reg [31:0] write_data_Mem,
output reg [4:0] Mem_rd
);

always@(posedge clk) begin
Regwrite_Mem <= Regwrite_Exe;
write_data_Mem <= write_data;
Mem_rd <= Exe_rd;
end

endmodule

module forwarding_unit(
input Exe_Memread,
input [4:0] Mem_rd,
input [4:0] Exe_rd,

input [4:0] Exe_rs,
input [4:0] Exe_rt,

input [4:0] ID_rs,
input [4:0] ID_rt,

output reg [1:0] ALU_data_1_flag,
output reg [1:0] ALU_data_2_flag
);

always@(*) begin
if (Exe_Memread) begin
  if(Mem_rd == Exe_rs)
       ALU_data_1_flag = 0;
  if(Mem_rd == Exe_rt)
       ALU_data_2_flag = 0; end
else begin
if(Exe_rd == Mem_rd && Exe_rd == ID_rs)
    ALU_data_1_flag = 1;
else if (Exe_rd == ID_rs)
    ALU_data_1_flag = 1;
else if (Mem_rd == ID_rs)
    ALU_data_1_flag = 2;
else 
    ALU_data_1_flag = 3;

if(Exe_rd == Mem_rd && Exe_rd == ID_rt)
    ALU_data_2_flag = 1;
else if (Exe_rd == ID_rt)
    ALU_data_2_flag = 1;
else if (Mem_rd == ID_rt)
    ALU_data_2_flag = 2;
else 
    ALU_data_2_flag = 3;
end

end
endmodule
