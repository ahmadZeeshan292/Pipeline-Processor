module Pipelined_Processor(
input clk,
input rst
);
wire [31:0]out_address;
wire [31:0]PC_next;
wire[31:0]instruction;
wire [15:0] offset;
wire [4:0] rt;
wire [4:0] rs;
wire [4:0] rd;
wire [4:0] shamt;
wire [5:0] funct;
wire [6:0] opcode;
wire [25:0] imm;
wire [31:0] PC_next_IF;

// reg_file
  wire [31:0] read_data_1;
  wire [31:0] read_data_2;
// signed_extended_output
  wire [31:0] sign_extended_output;
// control signals
  wire RegDst;
  wire ALUsrc;
  wire Memwrite;
  wire Memread;
  wire Regwrite;
  wire Branch;
  wire [1:0] ALUop;
  wire MemtoReg;
  wire jump;
  wire IF_Flush;
  wire FP_instruction;
// DECODE REGISTER
wire[31:0]PC_next_DE;
wire [15:0]offset_DE;
wire [25:0]imm_DE;
wire [5:0]funct_DE;
wire [4:0]shamt_DE;
wire[4:0] DE_rt;
wire[4:0] DE_rs;
wire[4:0] DE_rd;
wire[31:0] read_data_1_DE;
wire[31:0] read_data_2_DE;
wire RegDst_DE;
wire ALUsrc_DE;
wire Memwrite_DE;
wire Memread_DE;
wire Regwrite_DE;
wire Branch_DE;
wire [1:0] ALUop_DE;
wire MemtoReg_DE;
wire jump_DE;
wire FP_instruction_DE;
wire [3:0] FP_ALUop_DE;
// EXECUTION REGISTER
wire [31:0]PC_next_Exe;
wire[4:0] Exe_rt;
wire [4:0] Exe_rs;
wire [4:0] Exe_rd;
wire [31:0] ALU_result_Exe;
wire [31:0] read_data_2_Exe;
wire Memwrite_Exe;
wire Memread_Exe;
wire Regwrite_Exe;
wire Branch_Exe;
wire MemtoReg_Exe;
wire jump_Exe;
// hazard control
wire register_write;
// ALU control unit
wire [3:0] select_signal;
wire [31:0] ALU_result;
wire zero_flag;
reg [31:0] ALU_data_1;
reg [31:0] ALU_data_2;
// Forwarding unit
wire [1:0] ALU_data_1_flag;
wire [1:0] ALU_data_2_flag;
// Data memory
wire [31:0]data_memory_output;
reg [31:0] write_data;
// Data memory register
wire Regwrite_Mem;
wire [31:0]write_data_Mem;
wire [4:0] Mem_rd;
// Decode ALU unit
//reg [31:0] DE_ALU_data_1;
//reg [31:0] DE_ALU_data_2;
reg [31:0] DE_results;
reg DE_zeroflag;
wire [31:0]DE_branchaddress;
//
reg [4:0]rd_;
reg [31:0] ALU_second_op;
reg [31:0] next_address;
// jump address
wire [31:0] jump_address;
reg jump_sig;
//
wire [31:0] FP_ALU_Results;
wire [3:0]FP_ALUop;
reg [31:0] ALU_results_actual;
wire [3:0] special_case_FP;

/////////////////////////////////////
////////////////////////////////////
//STAGE 1 IF/ID REGISTER FETCH STATE
///////////////////////////////////
//////////////////////////////////

PC uut (next_address, out_address, clk, rst,register_write);
PC_next_address pnau(out_address,PC_next);
inst_rom utt (out_address, instruction);

jump_address_CAL jac(PC_next,instruction[25:0],jump_address);

always@(*) begin
if(DE_zeroflag && Branch)
    next_address <= DE_branchaddress;
else if(jump_sig)
    next_address <= jump_address;
else 
    next_address <= PC_next;
end

always@(*) begin
  if(instruction[31:26] == 6'd2)
     jump_sig <= 1;
  else 
      jump_sig <= 0;
end

Fetch_register fru (clk,register_write,IF_Flush,instruction,PC_next,opcode,offset,rt,rs,rd,shamt,funct,imm,PC_next_IF);

//////////////////////////////////////
/////////////////////////////////////
//STAGE 2 ID/EX REGISTER DECODE STATE
///////////////////////////////////
//////////////////////////////////

Control_unit cut(opcode,RegDst,ALUsrc,Memwrite,Memread,Branch,Regwrite,ALUop,MemtoReg,jump,FP_instruction,FP_ALUop,IF_Flush);

/*reg [4:0] rs_,rt_,rd_1;

always@(*) begin

if(FP_instruction) begin
   rs_ <= rs+31;
   rt_ <= rt+31;
   rd_1 <= rd+31; end
else begin
   rs_<= rs;
   rt_<= rt;
   rd_1<= rd_; end
end*/

/* if(FP_instruction)
   rs = rs%3 + 31;
   rt = rt%3 + 31;
*/

register_file rfu(clk,Regwrite_Mem,rst,rs,rt,Mem_rd,read_data_1,read_data_2,write_data_Mem);
sign_extend seu (offset, sign_extended_output);

always@(*) begin
if(RegDst)
rd_ <= rd;
else
rd_ <= rt;
end

/*always@(*) begin
   if(DE_rd == rs) 
       DE_ALU_data_1 <= ALU_result;
   else if(Exe_rd == rs)
       DE_ALU_data_1 <= write_data;
   else 
       DE_ALU_data_1 <= read_data_1;

   if(DE_rd == rt)
       DE_ALU_data_2 <= ALU_result;
   else if(Exe_rd == rt)
       DE_ALU_data_2 <= write_data;
   else 
       DE_ALU_data_2 <= read_data_2;
end*/

always@(*) begin
// DE_results <= DE_ALU_data_1 - DE_ALU_data_2;
DE_results <= read_data_1 - read_data_2;

if(DE_results == 0)
   DE_zeroflag <= 1;
else
   DE_zeroflag <= 0;
end

Branch_address_ALU baau(PC_next_IF,imm,DE_branchaddress);

Decode_register dru(clk,register_write,offset,imm,shamt,funct,PC_next_IF,rt,rs,rd_,read_data_1,read_data_2,RegDst,ALUsrc,Memwrite,Memread,Branch,Regwrite,ALUop,MemtoReg,jump,FP_instruction,FP_ALUop,offset_DE,imm_DE,shamt_DE,funct_DE,PC_next_DE,DE_rt,DE_rs,DE_rd,read_data_1_DE,read_data_2_DE,RegDst_DE,ALUsrc_DE,Memwrite_DE,Memread_DE,Branch_DE,Regwrite_DE,ALUop_DE,MemtoReg_DE,jump_DE,FP_instruction_DE,FP_ALUop_DE);

Hazard_control hcu(rst,Memread_DE,jump,Branch,DE_rd,rs,rt,register_write);


//////////////////////////////////////////
/////////////////////////////////////////
//STAGE 3 ID/EXE REGISTER EXECUTION STATE
////////////////////////////////////////
///////////////////////////////////////

ALU_control acl (funct_DE,ALUop_DE,select_signal);
ALU auu(select_signal,ALU_data_1,ALU_data_2,shamt_DE,ALU_result,zero_flag);
FP_ALU fpalu (ALU_data_1,ALU_data_2,FP_ALUop_DE,FP_ALU_Results,special_case_FP);
forwarding_unit fuu(Memread_Exe,Mem_rd,Exe_rd,Exe_rs,Exe_rt,DE_rs,DE_rt,ALU_data_1_flag,ALU_data_2_flag);

always@(*) begin
if(FP_instruction_DE)
ALU_results_actual <= FP_ALU_Results;
else
ALU_results_actual <= ALU_result;
end


always@(*) begin
if(ALUsrc_DE)
   ALU_second_op <= offset_DE;
else 
   ALU_second_op <= read_data_2_DE;
end

always@(*) begin
if(ALU_data_1_flag == 0 || ALU_data_1_flag == 2)
   ALU_data_1 <= write_data_Mem;
else if(ALU_data_1_flag == 1)
   ALU_data_1 <= ALU_result_Exe;
else if(ALU_data_1_flag == 3)
   ALU_data_1 <= read_data_1_DE;
end

always@(*) begin
if(ALU_data_2_flag == 0 || ALU_data_2_flag == 2)
   ALU_data_2 <= write_data_Mem;              // fix when mem data register is made
else if(ALU_data_2_flag == 1)
   ALU_data_2 <= ALU_result_Exe; // Exe_rd 
else if(ALU_data_2_flag == 3)
   ALU_data_2 <= ALU_second_op;  // DE_rt
end

Execution_register eru(clk,PC_next_DE,DE_rt,DE_rs,DE_rd,ALU_results_actual,read_data_2_DE,Memwrite_DE,Memread_DE,Branch_DE,Regwrite_DE,MemtoReg_DE,jump_DE,PC_next_Exe,Exe_rt,Exe_rs,Exe_rd,ALU_result_Exe,read_data_2_Exe,Memwrite_Exe,Memread_Exe,Branch_Exe,Regwrite_Exe,MemtoReg_Exe,jump_Exe);

//////////////////////////////////////////
/////////////////////////////////////////
//STAGE 4 EXE/MEM DATA MEMORY STATE/////
////////////////////////////////////////
///////////////////////////////////////

data_mem dmu(ALU_result_Exe,read_data_2_Exe,data_memory_output,clk,Memwrite_Exe,Memread_Exe);

always@(*) begin
if(MemtoReg_Exe)
write_data <= data_memory_output;
else 
write_data <= ALU_result_Exe;
end

Data_Memory_register dmr(clk,Regwrite_Exe,write_data,Exe_rd,Regwrite_Mem,write_data_Mem,Mem_rd);
 
endmodule
