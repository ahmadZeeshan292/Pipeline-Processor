module register_file #(parameter N=32, address_size=5) (clk,write ,reset ,rs_address,rt_address,rd_address,read_data_1,read_data_2,write_data);
  input [N-1:0] write_data;
  input wire clk,reset,write ;
  input [address_size-1:0] rs_address,rt_address,rd_address;
  output[N-1:0] read_data_1,read_data_2;

  reg [N-1:0] register_file[0:N-1];
  integer k;

initial  
begin
  register_file[0]<=32'h0000;
  register_file[1]<=32'h40200000; // 2.5
  register_file[2]<=32'h0002;
  register_file[3]<=32'h40700000; // 3.75
  register_file[4]<=32'h0004;
  register_file[5]<=32'h0005;
  register_file[6]<=32'h0006;
  register_file[7]<=32'h0007;
  register_file[8]<=32'h0008;
  register_file[9]<=32'h0009;
  register_file[10]<=32'h000a;
end

/*always @ (posedge clk)
begin 
 if (reset)
    for (k = 0; k<8; k = k+1)
       register_file[k] <= k;
 end*/

always@(negedge clk) begin
if(write)
      register_file [rd_address] <= write_data;
end
    assign read_data_1 = register_file[rs_address];
    assign read_data_2 = register_file[rt_address];


endmodule
