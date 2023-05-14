`timescale 1ns / 1ps
//insn_mem- Instruction Memory: 32bit x 1024 index memory for instruction

module insn_mem(clk,insn_out,pc_out);
input clk;                      //system clock
input [9:0] pc_out;             //instruction index from pc
output reg [31:0] insn_out;     //output instruction 

reg [31:0] memory [1023:0];   //32bit x 1024index memory

always@(*)begin
    //fill with instructions
    memory[0] = 32'b00000000000100001000000010110011; // add x1 x1 x2
    memory[1] = 32'b00000000000100010000000100110011; // add x2 x2 x2
    memory[2] = 32'b00000000000100011000000110110011; // add x3 x3 x2
    memory[3] = 32'b00000000000100100111001000110011; // and x4 x4 x2


    // memory[0]=1;
    // memory[1]=2;
    // memory[2]=3;
    // memory[3]=4;

    //output instruction at pc_out address
    insn_out = memory[pc_out]; 
end

endmodule