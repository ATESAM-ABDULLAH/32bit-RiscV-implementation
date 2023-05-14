`timescale 1ns / 1ps
//alu-control - ALU control: define type of ALU operation using func3,func7,opcode

module alu_control (clk,func3,func7,opcode,alu_control);
input clk;
input [2:0] func3;
input [6:0] func7;
input [6:0] opcode;
output reg [2:0] alu_control;

parameter r_type = 7'b0110011;//add,sub,and,or
parameter s_type = 7'b0100011;//sw,sb
parameter i_type = 7'b0010011;//addi
parameter l_type = 7'b0000011;//lw,lb
parameter b_type = 7'b1100011;//beq,bge,blt
parameter jal    = 7'b1101111;//jal
parameter jalr   = 7'b1100111;//jalr

always @(*) begin
    //Default value for debug
    alu_control=3'bx;
    
    case(opcode)
    r_type:
    begin
        if(func3==3'b111 && func7==7'b0)//And
            alu_control = 3'b000;
        else if(func3==3'b110 && func7==7'b0)//or
            alu_control = 3'b001;
        else if(func3==3'b0 && func7==7'b0)//Add
            alu_control = 3'b010;
        else if(func3==3'b0 && func7==7'b0100000)//Sub
            alu_control = 3'b011;
    end
    s_type:alu_control = 3'b010;
    i_type:alu_control = 3'b010;
    l_type:alu_control = 3'b010;
    b_type:
    begin
        if(func3==3'b100)//blt
            alu_control = 3'b100;

        else if(func3==3'b010)//bge
            alu_control = 3'b101;
            
        else if(func3==3'b000)//beq
            alu_control = 3'b110;

    end
    jal:alu_control = 3'b010;
    jalr:alu_control = 3'b010;
    endcase
end
endmodule