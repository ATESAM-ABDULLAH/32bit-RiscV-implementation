`timescale 1ns / 1ps

module RiscV_implementation_PC_IMem_RegFile(
input clk,		           //clock
input reset,               //reset whole circuit to default
input [9:0] jump_addr
output reg [9:0] pc_out    //5bit address -> 2^5 index -> 32 index
);

always@(posedge clk)begin
	if(reset) //reset pc_output
		pc_out <= 0;
	else      //keep on increasing pc by 4 -> to skip over 1 word ~ 4 bytes
		pc_out <= pc_out + 4;
end
 
endmodule