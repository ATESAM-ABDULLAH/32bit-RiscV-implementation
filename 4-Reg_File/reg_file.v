`timescale 1ns / 1ps
//reg_file- Register File: stores the 32 registers

module reg_file (clk,reg_write,write_data,rs1,rs2,rd,out1,out2);
input clk;                  //system clock
input reg_write;            //0=read , 1=write
input [31:0] write_data;    //32bit data -> Reg[rd]=rwrite_data
input [4:0] rs1,rs2,rd;     //5bit reg address 
output [31:0] out1,out2;//32bit reg output -> out1,out2 = Reg[rs1],Reg[rs2]

reg [31:0] Reg [31:0];      //32 registers each 32bit

always @(posedge clk) begin
	//Temp data for debug
	Reg[1]=5;
	Reg[2]=6;
	Reg[3]=7;
	Reg[4]=8;

    //Reg[0] is hardcoded 0
	Reg[0]=0;

    //Logic
    if(reg_write) 	//write to rd
		Reg[rd] = write_data;

end

//read rs1,rs2
assign	out1 = Reg[rs1];
assign	out2 = Reg[rs2];

endmodule
