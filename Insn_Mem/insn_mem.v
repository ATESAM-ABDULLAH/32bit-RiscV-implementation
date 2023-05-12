`timescale 1ns / 1ps
//insn_mem- Instruction Memory: 32bit x 1024 index memory for instruction

module insn_mem(clk,insn_out,pc_out,memory);
input clk;                      //system clock
input [9:0] pc_out;             //instruction index from pc
input [31:0] memory [1023:0];   //32bit x 1024index memory
output reg [31:0] insn_out;     //output instruction 


always@(posedge clk)begin
    insn_out <= memory[pc_out]; //output instruction at pc_out address
end

endmodule