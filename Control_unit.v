module Control_unit(
input [6:0]opcode,
output reg RegDst,
output reg ALUsrc,
output reg Memwrite,
output reg Memread,
output reg Branch,
output reg Regwrite,
output reg [1:0] ALUop,
output reg MemtoReg,
output reg jump,
output reg FP_instruction,
output reg [3:0]FP_ALUop,
output reg IF_Flush
);
always @(opcode)
begin
if(opcode == 7'dx)
begin RegDst <= 1'bx; ALUop <= 2'bxx; Memwrite <=1'bx; Memread <= 1'bx; Branch <= 1'bx; ALUsrc <= 1'bx; Regwrite <= 1'bx; MemtoReg <= 1'bx; jump <= 1'bx; IF_Flush <= 1'dx; FP_instruction <= 1'bx; FP_ALUop <= 4'bx; end // default
else if(opcode == 7'd0)
begin RegDst <= 1; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 0; FP_ALUop <= 4'bx; end // R type
else if(opcode == 7'd8)
begin RegDst <= 0; ALUop <= 2'b10; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 1; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 0; FP_ALUop <= 4'bx; end // addi
else if (opcode == 7'd35)
begin RegDst <= 0; ALUop <= 2'b10; Memwrite <=0; Memread <= 1; Branch <= 0; ALUsrc <= 1; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 0; FP_ALUop <= 4'bx; end // lw
else if(opcode == 7'd43)
begin RegDst <= 0; ALUop <= 2'b10; Memwrite <=1; Memread <= 0; Branch <= 0; ALUsrc <= 1; Regwrite <= 0; MemtoReg <= 1; jump <= 0; IF_Flush <= 0; FP_instruction <= 0; FP_ALUop <= 4'bx; end // sw
else if(opcode == 7'd4)
begin RegDst <= 0; ALUop <= 2'b01; Memwrite <=0; Memread <= 0; Branch <= 1; ALUsrc <= 0; Regwrite <= 0; MemtoReg <= 0; jump <= 0; IF_Flush <= 1; FP_instruction <= 0; FP_ALUop <= 4'bx; end // beq
else if(opcode == 7'd2)
begin RegDst <= 0; ALUop <= 2'bxx; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 0; MemtoReg <= 0; jump <= 1; IF_Flush <= 1; FP_instruction <= 0; FP_ALUop <= 4'bx; end // jump
else if(opcode == 7'd10)
begin RegDst <= 1; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 1; FP_ALUop <= 4'b0; end // FP add
else if(opcode == 7'd11)
begin RegDst <= 1; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 1; FP_ALUop <= 4'b1; end // FP sub
else if(opcode == 7'd12)
begin RegDst <= 1; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 1; FP_ALUop <= 4'd2; end // FP mul
else if(opcode == 7'd13)
begin RegDst <= 1; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 1; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 1; FP_ALUop <= 4'd3; end // FP div
else
begin RegDst <= 0; ALUop <= 2'b00; Memwrite <=0; Memread <= 0; Branch <= 0; ALUsrc <= 0; Regwrite <= 0; MemtoReg <= 0; jump <= 0; IF_Flush <= 0; FP_instruction <= 0; FP_ALUop <= 4'bx; end // invalid instruction

end

endmodule
