`timescale 1ns / 1ps
//decoder- Decoder: split 32bit instruction into parts

module decoder (clk,instruction,func3,func7,opcode,rs1,rs2,rd,imm,size);
input clk;                  //System clock
input [31:0] instruction;   //instruction from instruction memory

output reg [2:0] func3;     
output reg [6:0] func7;  
output reg [6:0] opcode;    //opcode for control
output reg [4:0] rs1,rs2,rd;//read_reg1,read_reg2,write_reg
output reg [20:0] imm;      //immediate -> max 20bit for Jtype
output reg size;            //size of data: 0=byte , 1=word

parameter r_type = 7'b0110011;//add,sub,and,or
parameter s_type = 7'b0100011;//sw,sb
parameter i_type = 7'b0010011;//addi
parameter l_type = 7'b0000011;//lw,lb
parameter b_type = 7'b1100011;//beq,bge,blt
parameter jal    = 7'b1101111;//jal
parameter jalr   = 7'b1100111;//jalr

always @(posedge clk ) begin
    opcode = instruction[6:0]; //all instructions have opcode
    size = 1;//default size is word

    //Make all outputs 0 by default -> no garbage data
    func3=0;func7=0;imm=0;rs1=0;rs2=0;rd=0;

    //all regs (size N) not used are turned to N'bx

    case(opcode)
    r_type:
    begin
        rd = instruction[11:7];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        func7 = instruction[31:25];
    end
    s_type:
    begin
        imm[4:0] = instruction[11:7];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm[11:5] = instruction[31:25];
        rd = 5'bx;
        func7 = 7'bx;

        if(func3 == 3'b000)//sb
            size=0;
    end
    i_type:
    begin
        rd = instruction[11:7];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm[11:0] = instruction[31:25];
        func7 = 7'bx;
    end
    l_type:
    begin
        rd = instruction[11:7];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm[11:0] = instruction[31:25];
        func7 = 7'bx;

        if(func3 == 3'b000)//lb
            size=0;
    end
    b_type://shift right one
    begin
        imm[11] = instruction[7];
        imm[4:1] = instruction[11:8];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm[10:5] = instruction[30:25];
        imm[12] = instruction[31];
        //imm is arranged [12,11,10:5,4:1] and sign right shifted 1
        imm = imm>>>1;

        rd = 5'bx;
        func7 = 7'bx;
    end
    jal:
    begin
        rd = instruction[11:7];
        imm[19:12] = instruction[19:12];
        imm[11] = instruction[20];
        imm[10:1] = instruction[30:21];
        imm[20] = instruction[31];
        //imm is arranged [20,19:12,11,10:1] and sign right shifted 1
        imm = imm>>>1;

        func3=3'bx;
        rs1=5'bx;
        rs2=5'bx;
        func7=7'bx;
    end
    jalr:
    begin
        rd = instruction[11:7];
        func3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm[11:0] = instruction[31:25];
        func7 = 7'bx;
    end
    endcase
end

endmodule
