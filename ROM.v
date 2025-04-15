module inst_rom #(parameter N=32, DEPTH=32)
(input [N-1:0]address, output reg [N-1:0] instruction); 	reg [N-1:0] memory [DEPTH-1:0]; 

	initial begin

                memory[0] = 32'b001011_00001_00011_00000_00000_000011; // opcode = 35; rs = 3;[3] rt = 1;[1] imm = 3; (LW); Mem_address = 6; mem[6] = reg[1] = 6;
                memory[1] = 32'b001010_00001_00011_01000_00000_000010; // opcode = 0; rs = 1;[6] rt = 3;[3] rd = 0; ALU_amswer = 3; reg[8] = 18; (MULTIPLY)
                //memory[1] = 32'b000000_00011_00000_00000_00000_000010; // opcode = 0; rs1 = 3;[3] rs2 = 0;[3] rd = 1; shamt = 0; funct = 2(MULTIPLY); ALU_answer = 9; reg[0] = 9;
                
 		//memory [0] = 32'b000010_00000_00000_00000_000000_00010; // opcode = 2; imm = 2 (JUMP) next_address = 4 
		//memory [1] = 32'b000100_00000_00011_00000_000000_00011; // opcode = 4; rs1 = 9; rs2 = 1; imm = 3; (BEQ) next_address = 6;
                                               // The answers below impley that the above lines are not executed
		//memory [1] = 32'b000000_00001_00000_00011_00000_000010; // opcode = 0; rs1 = 0;[9] rs2 = 4;[4] rd = 1; shamt = 0; funct = 0;(ADD); ALU_answer = 13; reg[1] = 13;
		//memory [2] = 32'b000000_00000_00100_00001_00000_000000; // opcode = 0; rs1 = 0;[9] rs2 = 4;[4] rd = 1; shamt = 0; funct = 0;(ADD); ALU_answer = 13; reg[1] = 13;
		memory [2] = 32'b000000_00001_01000_00011_00000_000010; // opcode = 0; rs1 = 1; rs2 = 8; rd = 3; shamt = 0; funct = 2(MULTIPLY); ALU_answer = 48; reg[3] = 48;
		memory [3] = 32'b001010_00011_00001_00100_00000_000011; // opcode = 35; rs1 = 1;[5] rs2 = 0;[0] imm = 3; (LW);    Mem_address = 8; mem[8] = 0;
		memory [5] = 32'b101011_00001_00000_00000_00000_001111; // opcode = 43; rs1 = 1;[5] rs2 = 0;[0] imm = 15; (SW);   Mem_address = 20; reg[0] = mem[20] = 20;
		memory [6] = 32'b001010_00001_00000_00011_00000_000010; // opcode = 0; rs1 = 1[5]; rs2 = 0[20]; rd = 3; shamt = 0; funct = 2(MULTIPLY); ALU_answer = 100; reg[3] = 100;
                memory [7] = 32'b101011_01001_01010_00000_00000_001000; // opcode = 43; rs1 = 9;[0] rs2 = 10;[x] imm = 8; (SW);   Mem_address = 8; reg[10] = mem[8] = 0;
		memory [8] = 32'b000000_01001_01010_00011_00000_000010; // opcode = 0; rs1 = 9;[0] rs2 = 10;[0] rd = 3; shamt = 0; funct = 2(MULTIPLY); ALU_answer = 0; reg[3] = 0;
		//memory [9] = 32'b000100_00000_00000_11111_111111_11110; // opcode = 4; rs1 = 0; rs2 = 0; imm = -2; shift_imm = -8 (BEQ) next_address = 2 
                memory [9] = 32'b000000_00001_00010_01010_11111_101010; // opcode = 6; rs1 = 1;[5] rs2 = 2;[2] rd = 10; shamt = 31; funct = 31; (SLT) ALU_answer = 1; reg[10] = 1;
               memory [10] = 32'b000000_00001_01010_00011_00000_000010; // opcode = 0; rs1 = 1;[5] rs2 = 10;[1] rd = 3; shamt = 0; funct = 2(MULTIPLY); ALU_answer = 5; reg[3] = 5;
               memory [11] = 32'b001111_00001_01010_00000_00000_000001; // opcode = 15; rt = 1; imm = 1; (LUI) shifted_imm = 2^16; reg[1] = 2^16
               memory [12] = 32'b001000_01010_00001_00000_00000_000001; // opcode = 8;  rt = 9; rs = 1;[2^16] alu_answer = 2^16+1; reg[9] = 2^16+1; addi
               
	end
	always@(address)
		instruction <= memory [address];
endmodule
