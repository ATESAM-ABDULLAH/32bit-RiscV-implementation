`include "processor.v"

module processor_tb ();
    //Inputs
    reg clk,reset;

    //Outputs
    wire [9:0] pc;
    wire [31:0] insn;
    wire [20:0] imm_out;
    wire [2:0] alu_control;
    wire [31:0] reg_out1;
    wire [31:0] reg_out2;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire flag;

    processor uut (clk,reset,pc,insn,imm_out,alu_control,reg_out1,reg_out2,alu_result,flag,read_data);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0,processor_tb);
        //Initialize
        clk=0;reset=1;#10
        reset=0;

        #125 // 14 cycles

        $finish;
    end
endmodule