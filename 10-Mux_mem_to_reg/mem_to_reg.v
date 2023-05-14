`timescale 1ns / 1ps
//mem_to_reg- Memeory to Register MUX: select Alu output or Data read from 
//            Memory to write in register rd
//0 = Alu_output
//1 = data_mem_output

module mem_to_reg (clk,mem_to_reg,alu_result,mem_data,selected);
input clk;                  //System clock
input mem_to_reg;           //control signal from Control
input [31:0] alu_result;    //Reg[rs2] from Register File
input [31:0] mem_data;      //Immediate from Decoder
output reg [31:0] selected; //MUX output

always @(posedge clk ) begin
    if(mem_to_reg==1)
        selected = mem_data;
    else if (mem_to_reg==0)
        selected = alu_result;
end
endmodule
