`include "pc.v"

module pc_tb;
    //Inputs
    reg clk,reset,branch;
    reg [19:0] jump_offset;

    //Outputs
    wire [9:0] pc_out;

    pc uut (clk,reset,branch,jump_offset,pc_out);

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

        //Jump
        branch = 1;
        jump_offset = 196;#10
        jump_offset = 800;#10
        
        $finish;
    end
endmodule