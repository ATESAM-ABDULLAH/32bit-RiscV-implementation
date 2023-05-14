`timescale 1ns / 1ps
//PC- Program Counter: for 1024B instruction memory

module pc(clk,reset,branch,zero_flag,mem_to_reg,immediate,reg_out1,pc_out);
input clk;		           	//clock
input reset;               	//reset whole circuit to default
input branch;              	//bool 0=nojump , 1=jump 
input zero_flag;			//flag = 0 if beq,blt,bge is True

input [1:0] mem_to_reg;		// x=b_type, 2 = jal , 3 = jalr 

input [31:0] reg_out1;    	//Reg[rs1] from Reg File
input [20:0] immediate;  	//immediate -> max 21bits for J type

output reg [9:0] pc_out;	//10bit address -> 2^10 index -> 1024 bytes

always@(posedge clk)begin

	if(reset) 		//reset pc_output
		pc_out = 0;

	else if(branch && zero_flag && mem_to_reg==2'bx) 			//b_type: PC = PC + imm
		pc_out = pc_out + immediate;

	else if(branch && mem_to_reg==2'b10) 	//jal: PC = PC + imm
		pc_out = pc_out + immediate;

	else if (branch && mem_to_reg==2'b11)	//jalr: PC = (rs1 + imm) 
		pc_out = immediate + reg_out1;
		
	else    		//no jump
		pc_out = pc_out + 4;
end
 
endmodule