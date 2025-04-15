module FP_Divide(
    input [31:0] dividend,
    input [31:0] divisor,
    output reg [31:0] result
);

reg [7:0] exponent_dividend, exponent_divisor, result_exponent;
reg [23:0] mantissa_dividend, mantissa_divisor;
reg [47:0] mantissa_quotient;
reg sign_dividend, sign_divisor, result_sign;
reg [22:0] result_mantissa;

always @(*) begin
    // Initialize the result to zero
    result = 32'b0;
    
    // Special case for zero divisor
    if (divisor == 32'b0) begin
        result = {dividend[31], 8'hFF, 23'b0}; // +/-Infinity

    end else if (dividend == 32'b0) begin
        result = 32'b0; // Zero
    end else begin
        // Extract sign from dividend and divisor
        sign_dividend = dividend[31];
        sign_divisor = divisor[31];
        
        // Extract exponent from dividend and divisor
        exponent_dividend = dividend[30:23];
        exponent_divisor = divisor[30:23];

        // Extract mantissa from dividend
        if (exponent_dividend == 0) begin
            mantissa_dividend = {1'b0, dividend[22:0]};
        end else begin
            mantissa_dividend = {1'b1, dividend[22:0]};
        end

        // Extract mantissa from divisor
        if (exponent_divisor == 0) begin
            mantissa_divisor = {1'b0, divisor[22:0]};
        end else begin
            mantissa_divisor = {1'b1, divisor[22:0]};
        end

        // Compute the sign of the result
        result_sign = sign_dividend ^ sign_divisor;

        // Compute the exponent of the result
        result_exponent = exponent_dividend - exponent_divisor + 8'd127;

        // Perform mantissa division
        mantissa_quotient = {mantissa_dividend, 24'b0} / mantissa_divisor;

        // Normalize the result mantissa
        if (mantissa_quotient[47] == 0) begin
            // Find the first 1 in mantissa_quotient
            while (mantissa_quotient[47] == 0 && result_exponent > 0) begin
                mantissa_quotient = mantissa_quotient << 1;
               // result_exponent = result_exponent - 1;
            end
        end

        result_mantissa = mantissa_quotient[46:24];

        // Handle underflow and overflow
       /* if (result_exponent >= 255) begin
            // Overflow
            result_exponent = 8'd255;
            result_mantissa = 0;
        end else if (result_exponent <= 0) begin
            // Underflow
            result_exponent = 8'd0;
            result_mantissa = 0;
        end
*/
        // Assemble the final result
        result = {result_sign, result_exponent, result_mantissa};
    end
end

endmodule
