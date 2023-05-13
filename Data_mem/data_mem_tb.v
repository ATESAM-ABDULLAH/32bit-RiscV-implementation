`include "data_mem.v"

module data_mem_tb ();
    //inputs
    reg clk,mem_read,mem_write;
    reg [31:0] address,data_in;

    //Ouputs
    wire [31:0] data_out;

    data_mem uut (clk,mem_read,mem_write,address,data_in,data_out);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("data_mem.vcd");
        $dumpvars(0,data_mem_tb);
        //Initialize inputs
        clk=0;#10

        mem_write=1;//write
        address=1;data_in=9;#10

        mem_read=1;//read
        address=1;data_in=10;#10

        $finish;
    end
endmodule