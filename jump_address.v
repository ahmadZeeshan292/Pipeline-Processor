module jump_address_CAL(
input [31:0]PC_next_address,
input [25:0] imm,
output [31:0] jump_address
);

assign jump_address = {PC_next_address[31:28],imm << 1};

endmodule
