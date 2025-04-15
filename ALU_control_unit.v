module ALU_control(
input [5:0] funct,
input [1:0] ALUop,
output reg [3:0] sel_signal
);

always @(funct or ALUop)
begin
  if(ALUop == 2'b00)  // R type instruction
  begin
    case(funct)
      6'd0: sel_signal = 4'd0;  // addition
      6'd1: sel_signal = 4'd1;  // subtraction
      6'd2: sel_signal = 4'd2;  // multiply
      6'd3: sel_signal = 4'd3;  // shift_right
      6'd4: sel_signal = 4'd4;  // shift_left
      6'd5: sel_signal = 4'd5;  // And
      6'd6: sel_signal = 4'd6;  // Or
      6'h2a: sel_signal = 4'd7; // slt
    endcase
  end
  else if(ALUop == 2'b10)  // I type instruction
    sel_signal = 4'd0; // addition
  else if(ALUop == 2'b01)  // B type instruction
    sel_signal = 4'd1; // subtraction
end

endmodule
