`timescale 1ns / 1ps
//alu_src- ALU src MUX: select Reg[rs2] or imm for second ALU inputs
//0 = Reg[rs2]
//1 = imm

module alu_src (clk,alu_src,reg_out2,imm,selected);
input clk;                  //System clock
input alu_src;              //control signal from Control
input [31:0] reg_out2;      //Reg[rs2] from Register File
input [20:0] imm;           //Immediate from Decoder
output reg [31:0] selected; //MUX output

always @(*) begin
    if(alu_src==1)
        selected = imm;
    else if (alu_src==0)
        selected = reg_out2;
end
endmodule
