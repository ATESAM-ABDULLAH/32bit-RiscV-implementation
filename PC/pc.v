`timescale 1ns / 1ps
//PC- Program Counter: for 1024B instruction memory

module pc(clk,reset,branch,jump_offset,pc_out);
input clk;		           	//clock
input reset;               	//reset whole circuit to default
input branch;              	//bool 0=nojump , 1=jump usin jump_offset
input [19:0] jump_offset;  	//immediate -> max 20bits for J type
output reg [9:0] pc_out;	//10bit address -> 2^10 index -> 1024 bytes

always@(posedge clk)begin
	if(reset) 		//reset pc_output
		pc_out <= 0;

	if(branch)      //jump to current address + offset
		pc_out <= pc_out + jump_offset;
	else      		//keep on increasing pc by 4 -> to skip over 1 word ~ 4 bytes
		pc_out <= pc_out + 4;
end
 
endmodule