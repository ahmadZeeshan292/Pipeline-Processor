module data_mem #(parameter N=32, DEPTH=32)
(input [N-1:0]address, input [N-1:0]data_in, output reg[N-1:0] data_out,  input clk, input we, input read); 

	reg [N-1:0] memory [DEPTH-1:0];

	initial begin
	memory[0] = 0;   memory[1] = 1;
	memory[2] = 2;   memory[3] = 3;
	memory[4] = 4;   memory[5] = 5;
	memory[6] = 6;   memory[7] = 7;
	memory[8] = 8;   memory[9] = 9;
	memory[10] = 10; memory[11] = 11; 
        memory[12] = 12; memory[13] = 13;
	memory[14] = 14; memory[15] = 15;
	memory[16] = 16; memory[17] = 17;
	memory[18] = 18; memory[19] = 19;
	memory[20] = 20; memory[21] = 21;
	end
	
	always@(*)  
		if(read)
	             data_out <= memory [address]; 
	
	always @(negedge clk)  
		if (we)
		     memory [address] <= data_in; 	
endmodule
