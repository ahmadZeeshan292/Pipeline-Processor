module PC_next_address(
input [31:0]PC_current_address,
output [31:0]PC_next_address
);

assign PC_next_address = PC_current_address + 1;

endmodule 
