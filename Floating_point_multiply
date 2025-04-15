module FP_Multiply(
    input [31:0] operand1,
    input [31:0] operand2,
    output reg [31:0] result
);

reg [7:0] exponent_1, exponent_2, result_exponent;
reg [23:0] mantissa_1, mantissa_2;
reg [47:0] mantissa_product;
reg sign_1, sign_2, result_sign;
reg [23:0] result_mantissa;

always @(*) begin
    // Extract sign, exponent, and mantissa from operand1
    sign_1 = operand1[31];
    exponent_1 = operand1[30:23];
    mantissa_1 = {1'b1, operand1[22:0]};

    // Extract sign, exponent, and mantissa from operand2
    sign_2 = operand2[31];
    exponent_2 = operand2[30:23];
    mantissa_2 = {1'b1, operand2[22:0]};

    // Compute the sign of the result
    result_sign = sign_1 ^ sign_2;

    // Compute the exponent of the result
    result_exponent = exponent_1 + exponent_2 - 8'd127;

    // Compute the product of the mantissas
    mantissa_product = mantissa_1 * mantissa_2;

    // Normalize the result mantissa
    if(mantissa_product[47] == 1) begin
        result_mantissa = mantissa_product[46:24];
        result_exponent = result_exponent + 1;
    end else begin
        result_mantissa = mantissa_product[45:23];
    end

    if(operand1 == 32'h7FC00000 || operand2 == 32'h7FC00000) // NaN
       result = 32'h7FC00000;
    else if(operand1 == 0 || operand2 == 0) // zero
       result = 32'd0;
     else
       result = {result_sign, result_exponent, result_mantissa[22:0]};
end  

endmodule
