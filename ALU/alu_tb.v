`include "alu.v"

module alu_tb ();
    //Inputs
    reg clk;                      
    reg [31:0] in1,in2;          
    reg [2:0] alu_control;

    //Outputs
    wire [31:0] result;
    wire zero_flag;

    alu uut (clk,in1,in2,result,alu_control,zero_flag);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0,alu_tb);

        //initialize inputs
        clk=0;#10

        in1=2;in2=3;

        alu_control=0;#10//AND
        alu_control=1;#10//OR
        alu_control=2;#10//Add
        alu_control=3;#10//sub
        alu_control=4;#10//<
        alu_control=5;#10//>=
        alu_control=6;#10//==

        $finish;
    end

endmodule