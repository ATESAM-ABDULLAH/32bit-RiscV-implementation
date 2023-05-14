`include "mem_to_reg.v"

module mem_to_reg_tb ();
    //Inputs
    reg clk;
    reg mem_to_reg;
    reg [31:0] alu_result;
    reg [31:0] mem_data;

    //Outputs
    wire [31:0] selected;

    mem_to_reg uut (clk,mem_to_reg,alu_result,mem_data,selected);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("mem_to_reg.vcd");
        $dumpvars(0,mem_to_reg_tb);

        //Initialize inputs
        clk=0;mem_data=20;alu_result=15;#10

        mem_to_reg=0;#10 //select alu_result
        mem_to_reg=1;#10 //select mem_data

        $finish;
    end
endmodule