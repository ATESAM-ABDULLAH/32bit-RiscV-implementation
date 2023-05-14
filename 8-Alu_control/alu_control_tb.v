`include "alu_control.v"

module alu_control_tb ();
    //Inputs
    reg clk;
    reg [2:0] func3;
    reg [6:0] func7;
    reg [6:0] opcode;

    //Outputs
    wire [2:0] alu_control;

    alu_control uut (clk,func3,func7,opcode,alu_control);

    //Clock toggles every 5ns
    always#2 clk=~clk;

    initial begin
        $dumpfile("alu_control.vcd");
        $dumpvars(0,alu_control_tb);

        //Initialize inputs
        clk=0;#10

        opcode  = 7'b0110011;//r_type 
            func3=3'b111;func7=7'b0;#10//and
            func3=3'b110;func7=7'b0;#10//or
            func3=3'b0;func7=7'b0;#10//add
            func3=3'b0;func7=7'b0100000;#10//sub

        opcode  = 7'b0100011;#10//s_type = sw,sb
        opcode  = 7'b0010011;#10//i_type = addi
        opcode  = 7'b0000011;#10//type = lw,lb

        opcode  = 7'b1100011;//b-type
            func3=3'b100;#10//blt
            func3=3'b010;#10//bge
            func3=3'b0;#10//beq

        opcode  = 7'b1101111;#10//jal
        opcode  = 7'b1100111;#10//jalr

        $finish;
    end
endmodule