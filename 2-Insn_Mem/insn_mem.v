`timescale 1ns / 1ps
//insn_mem- Instruction Memory: 32bit x 1024 index memory for instruction

module insn_mem(clk,insn_out,pc_out);
input clk;                      //system clock
input [9:0] pc_out;             //instruction index from pc
output reg [31:0] insn_out;     //output instruction 

reg [31:0] memory [1023:0];   //32bit x 1024index memory

always@(*)begin
    //fill with instructions
    memory[0] = 32'b00000000001000001000000010110011;   // add x1 x1 x2
    memory[1] = 32'b01000000001100010000000100110011;   // sub x2 x2 x3
    memory[2] = 32'b00000000000100100111001000110011;   // and x4 x4 x1
    memory[3] = 32'b00000000010100011110000110110011;   // or x3 x3 x5

    memory[4] = 32'b00000000110000010000001000010011;   // addi x4 x2 12

    memory[5] = 32'b00000000000000000010000110000011;   // lw x3 0(x0)
    memory[6] = 32'b00000000010100001000001010000011;   // lb x5 5(x1)

    memory[7] = 32'b00000000010100011010001010100011;   // sw x5 5(x3)
    memory[8] = 32'b0000000000100001000110100100011;   // sb x6 90(x1)

    memory[9] = 32'b00000001000000010000001001100011;   // beq x4 x2 26
    memory[10] = 32'b00000001000000010101000101100011;   // bge x2 x2 26
    memory[11] = 32'b00000001000000010100010001100011;   // blt x8 x2 26

    memory[12] = 32'b00000001100000000000000101101111; // jal x2 6
    memory[13] = 32'b00000000011000001000000101100111; // jalr x2 x1 6 


    //output instruction at pc_out address
    insn_out = memory[pc_out]; 
end


endmodule