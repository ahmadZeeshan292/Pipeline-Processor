module PC ( jump_address,out_address, clk, rst,register_write);
  input [31:0]jump_address;
  input clk , rst;
  input register_write;
  output reg [31:0]out_address;

  always@ (posedge clk)
    begin 
         if(register_write == 0) begin
            if(rst)
               out_address <= 0;
            else
               begin
                 if(jump_address < 0)
                    out_address <= 0;
                 else
                    out_address <= jump_address;
                 end
              end 
          end
endmodule
