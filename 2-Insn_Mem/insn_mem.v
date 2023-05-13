`timescale 1ns / 1ps
//insn_mem- Instruction Memory: 32bit x 1024 index memory for instruction

module insn_mem(clk,insn_out,pc_out);
input clk;                      //system clock
input [9:0] pc_out;             //instruction index from pc
output reg [31:0] insn_out;     //output instruction 

reg [31:0] memory [1023:0];   //32bit x 1024index memory

always@(posedge clk)begin
    //fill with instructions
    memory[0] = 32'b00000000000100010000000010110011; // add x1 x1 x2
    
    //output instruction at pc_out address
    insn_out = memory[pc_out]; 
end

endmodule