`timescale 1ns / 1ps
//mem_to_reg- Memeory to Register MUX: select Alu output or Data read from 
//            Memory to write in register rd
//0 = Alu_output
//1 = data_mem_output
//2,3 = pc + 4

module mem_to_reg (clk,mem_to_reg,alu_result,mem_data,pc_4,selected);
input clk;                  //System clock
input [1:0] mem_to_reg;           //control signal from Control
input [31:0] alu_result;    //Reg[rs2] from Register File
input [31:0] mem_data;      //Immediate from Decoder
input [9:0] pc_4;          //pc from PC add 4 to it
output reg [31:0] selected; //MUX output

always @(posedge clk ) begin
    if(mem_to_reg==1)
        selected = mem_data;
    else if (mem_to_reg==0)
        selected = alu_result;
    else if (mem_to_reg==2 || mem_to_reg==3)
        selected = pc_4 + 3'b100;//pc + 4
end
endmodule
