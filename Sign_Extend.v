module sign_extend(
  input [15:0] imm,
  output [31:0] full
);

  assign full = {{16{imm[15]}}, imm};

endmodule
