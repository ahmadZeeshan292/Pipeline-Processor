module shift_left_2(
input [31:0] offset,
output [31:0] shift_left_offset
);

assign shift_left_offset = offset << 2;

endmodule
