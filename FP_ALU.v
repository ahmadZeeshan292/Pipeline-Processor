module FP_ALU(
    input [31:0] operand_1,
    input [31:0] operand_2,
    input [2:0] operation,
    output reg [31:0] result,
    output reg [2:0] flag
);

wire [31:0]op1,op2 ;

assign op1 = operand_1;
assign op2 = operand_2;

wire [31:0]results_add_sub;
wire [31:0]results_mul;
wire [31:0]results_div;

FP_Addition_Subtraction fpas(op1,op2,operation,results_add_sub);
FP_Multiply FPm(op1,op2,results_mul);
FP_Divide fpdu (op1,op2,results_div);

always@(*) begin
if(operation == 3'b000 || operation == 3'b001)
result <= results_add_sub;
else if(operation == 3'b010)
result <= results_mul;
else if(3'b011)
result <= results_div;

if (result == 32'h7FC00000)  // NaN
   flag <= 3'b100;
else if(result == 32'h00000000) // zero
   flag <= 3'b010;
else if(result == 32'h7F800000) // infinity
   flag <= 3'b001;
else
   flag <= 3'b000;
end

endmodule
