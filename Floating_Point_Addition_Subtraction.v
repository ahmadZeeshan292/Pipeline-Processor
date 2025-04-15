module FP_Addition_Subtraction(
    input [31:0] operand_1,
    input [31:0] operand_2,
    input [2:0] operation,
    output reg [31:0] result
);

reg [7:0] exponent_1, exponent_2, exponent_diff;
reg [23:0] mantissa_1, mantissa_2;
reg [24:0] mantissa_result;
reg [23:0] shifted_mantissa;
reg sign_1, sign_2, result_sign;
reg [7:0] result_exponent;
reg [23:0] result_mantissa;
reg [23:0] mantissa_result_1;

reg[4:0] k;

always @(*) begin
    // Extract fields from operand_1
    sign_1 = operand_1[31];
    exponent_1 = operand_1[30:23];
    mantissa_1 = {1'b1, operand_1[22:0]}; // Add implicit leading 1
    
    // Extract fields from operand_2
    sign_2 = operand_2[31];
    exponent_2 = operand_2[30:23];
    mantissa_2 = {1'b1, operand_2[22:0]}; // Add implicit leading 1

    // Align exponents by shifting the mantissa of the smaller exponent
    if (exponent_1 > exponent_2) begin
        exponent_diff = exponent_1 - exponent_2;
        shifted_mantissa = mantissa_2 >> exponent_diff;
        result_exponent = exponent_1;
        mantissa_result = (operation == 3'b000) ? (mantissa_1 + shifted_mantissa) : (mantissa_1 - shifted_mantissa);
        if(sign_1 == sign_2)
             if(operation == 3'b000)
             result_sign = sign_1;
             else
             result_sign = (mantissa_1 > shifted_mantissa) ? 0 : 1;
        else if(sign_1 > sign_2) 
             if(operation == 3'b000)
             result_sign = (mantissa_1 > shifted_mantissa) ? 1 : 0;
             else
             result_sign = 1;
        else 
             if(operation == 3'b000)
             result_sign = (mantissa_1 > shifted_mantissa) ? 0 : 1;
             else
             result_sign = 1;
        end else begin
        exponent_diff = exponent_2 - exponent_1;
        shifted_mantissa = mantissa_1 >> exponent_diff;
        result_exponent = exponent_2;
        mantissa_result = (operation == 3'b000) ? (mantissa_2 + shifted_mantissa) : (-shifted_mantissa + mantissa_2);
        if(sign_1 == sign_2)
             if(operation == 3'b000)
             result_sign = sign_1;
             else
             result_sign = (shifted_mantissa > mantissa_2) ? 0 : 1;
        else if(sign_1 > sign_2)
             if(operation == 3'b000)
             result_sign = (shifted_mantissa > mantissa_2) ? 1 : 0;
             else
             result_sign = 1;
        else 
             if(operation == 3'b000)
             result_sign = (shifted_mantissa > mantissa_2) ? 0 : 1;
             else
             result_sign = 1;
    end
                
    // Normalize the result
    if (mantissa_result[24] == 1) begin
         result_mantissa = mantissa_result >> 1;
        result_exponent = result_exponent + 1;
    end else begin
        result_mantissa = mantissa_result[22:0];
        // If subtraction, result might need normalization
        if (operation == 3'b001) begin
            for (k = 0; k<23 &&result_mantissa[23] == 0 && result_exponent > 0 ;k = k+1) begin
                result_mantissa = result_mantissa << 1;
                result_exponent = result_exponent - 1;
            end
        end
    end
    
    if(operand_1 == 32'h7FC00000 || operand_2 == 32'h7FC00000) // NaN
       result = 32'h7FC00000;
    else if(operand_1 == operand_2 && operation == 3'b001) // zero
       result = 32'd0;
    else
       result = {result_sign, result_exponent, result_mantissa[22:0]};
end

endmodule
