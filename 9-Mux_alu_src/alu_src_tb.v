`include "alu_src.v"

module alu_src_tb ();
    //Inputs
    reg clk;
    reg alu_src;
    reg [31:0] reg_out2;
    reg [20:0] imm;

    //Outputs
    wire [31:0] selected;

    alu_src uut (clk,alu_src,reg_out2,imm,selected);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("alu_src.vcd");
        $dumpvars(0,alu_src_tb);

        //Initialize inputs
        clk=0;imm=20;reg_out2=15;#10

        alu_src=0;#10 //select reg_out2
        alu_src=1;#10 //select imm

        $finish;
    end
endmodule