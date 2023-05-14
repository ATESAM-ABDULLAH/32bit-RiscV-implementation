`include "pc.v"

module pc_tb;
    //Inputs
    reg clk,reset,branch;
    reg [1:0] mem_to_reg;
    reg [20:0] immediate;
    reg [31:0] reg_out1;

    //Outputs
    wire [9:0] pc_out;

    pc uut (clk,reset,branch,mem_to_reg,immediate,reg_out1,pc_out);

    //Clock toggles in 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("pc.vcd");
        $dumpvars(0,pc_tb);

        //Reset
        clk = 0 ; reset = 1; #10
        reset=0;

        //PC+4
        branch = 0;#20

        //b_type or jal
        branch = 1;
        immediate = 196;#10
        mem_to_reg = 2;
        immediate = 800;#10

        //jalr
        branch = 1;
        mem_to_reg=3;reg_out1=15;
        immediate = 20;#10
        
        $finish;
    end
endmodule