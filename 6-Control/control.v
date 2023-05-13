`timescale 1ns / 1ps
module control(clk,opcode,branch,mem_read,mem_write,alu_src,reg_write,mem_to_reg,alu_op);
input clk;                  //System clock
input [6:0] opcode;         //opcode from instruction
output reg branch,mem_read,mem_write,alu_src,reg_write; //control signals
output reg [1:0] mem_to_reg;//control signal
output reg [1:0] alu_op;    //control signal for ALU

parameter r_type = 7'b0110011;//add,sub,and,or
parameter s_type = 7'b0100011;//sw,sb
parameter i_type = 7'b0010011;//addi
parameter l_type = 7'b0000011;//lw,lb
parameter b_type = 7'b1100011;//beq,bge,blt
parameter jal    = 7'b1101111;//jal
parameter jalr   = 7'b1100111;//jalr


always @(posedge clk ) begin
    case(opcode)
    r_type:
    begin
        alu_src = 0;
        mem_to_reg = 2'b00;
        reg_write = 1;
        mem_read = 0;
        mem_write = 0;
        branch = 0;
        alu_op = 2'b10;
	end
    s_type:
    begin
        alu_src = 1;
        mem_to_reg = 2'bx;
        reg_write = 0;
        mem_read = 0;
        mem_write = 1;
        branch = 0;
        alu_op = 2'b00;
	end
    i_type:
    begin
        alu_src = 0;
        mem_to_reg = 2'b0;
        reg_write = 1;
        mem_read = 0;
        mem_write = 0;
        branch = 0;
        alu_op = 2'b00;
	end
    l_type:
    begin
        alu_src = 1;
        mem_to_reg = 2'b01;
        reg_write = 1;
        mem_read = 1;
        mem_write = 0;
        branch = 0;
        alu_op = 2'b00;
	end
    b_type:
    begin
        alu_src = 0;
        mem_to_reg = 2'bx;
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        branch = 1;
        alu_op = 2'b01;
	end
    jal:
    begin
        alu_src = 0;
        mem_to_reg = 2'b0;
        reg_write = 1;
        mem_read = 0;
        mem_write = 0;
        branch = 1;//depends 
        alu_op = 2'b11;
	end
    jalr:
    begin
        alu_src = 1;
        mem_to_reg = 2'b0;
        reg_write = 1;
        mem_read = 0;
        mem_write = 0;
        branch = 1;//depends
        alu_op = 2'b11;
	end
    endcase
end
endmodule