module Hazard_control(
input rst,
input DE_Memread,
input IF_jump,
input IF_Branch,
input [4:0]DE_rd,
input [4:0]IF_rt,
input [4:0]IF_rs,
output reg register_write
);

always@(*) begin
if (rst)
   register_write <= 0;

if(DE_Memread && IF_jump == 0 && IF_Branch == 0) 
   if(DE_rd == IF_rt || DE_rd == IF_rs)
        register_write <= 1;
   else
        register_write <= 0; 
else 
   register_write <= 0;

end
endmodule
