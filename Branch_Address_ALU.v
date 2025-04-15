module Branch_address_ALU(
input [31:0] PC_next_address,
input [15:0] imm,
output reg [31:0] branch_address
);

always@(*)
branch_address <= PC_next_address + {{16{imm[15]}}, imm};

endmodule
