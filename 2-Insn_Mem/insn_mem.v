`timescale 1ns / 1ps
//insn_mem- Instruction Memory: 32bit x 1024 index memory for instruction

module insn_mem(clk,insn_out,pc_out);
input clk;                      //system clock
input [9:0] pc_out;             //instruction index from pc
output reg [31:0] insn_out;     //output instruction 

reg [31:0] memory [1023:0];   //32bit x 1024index memory

always@(*)begin
    //fill with instructions
    memory[0] = 32'b00000000001000001000000010110011; // add x1 x1 x2
    memory[1] = 32'b01000000001100010000000100110011; // sub x2 x2 x3
    memory[2] = 32'b00000000010100011110000110110011; // or x3 x3 x5
    memory[3] = 32'b00000000000100100111001000110011; // and x4 x4 x1
    memory[4] = 32'b00000000010100011000000110000011; // lb x5 5(x3)
    memory[5] = 32'b00000000010000010000001001100011; // beq x4 x2 1

    //output instruction at pc_out address
    insn_out = memory[pc_out]; 
end

endmodule