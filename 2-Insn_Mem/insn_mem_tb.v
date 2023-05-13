`include "insn_mem.v"

module insn_mem_tb ();
    //Inputs
    reg clk;
    reg [9:0] pc_out;

    //Outputs
    wire [31:0] insn_out;

    insn_mem uut (clk,insn_out,pc_out);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("insn_mem.vcd");
        $dumpvars(0,insn_mem_tb);
        //Initialize
        clk=0;#10

        //Check output from stored memory
        pc_out = 0 ;#10
        $finish;
    end
endmodule