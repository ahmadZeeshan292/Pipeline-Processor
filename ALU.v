module ALU(
    input [3:0] op,
    input [31:0] a,
    input [31:0] b,
    input [4:0]shamt,
    output reg [31:0] f,
    output reg zero_flag         // for beq instruction
);

parameter Add = 4'b0000, Sub = 4'b0001, Mul = 4'b0010, Shift_Left = 4'b0100, Shift_Right = 4'b0011, And = 4'b0100, Or = 4'b0101, Slt = 4'b0111;

  always @(*) begin
    case(op)
        Add:         f <= a + b;
        Sub:         f <= a - b;
        Mul:         f <= a * b;
        Shift_Right: f <= a >> shamt;
        Shift_Left : f <= a << shamt;
        And:         f <= a & b;
        Or:          f <= a | b;
        Slt:         begin 
                       if(a>b)
                          f <= 32'd1;
                       else 
                          f <= 32'd0;
                     end
        default: f <= 16'b0000000000000000; // Default case for any other operation
    endcase
  end

  always@(*)begin
    if(f == 32'd0)
       zero_flag = 1;
    else
       zero_flag = 0;
    end
endmodule
