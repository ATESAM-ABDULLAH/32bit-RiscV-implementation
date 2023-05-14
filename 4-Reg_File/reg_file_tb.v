`include "reg_file.v"

module reg_file_tb();
    //Inputs
    reg clk,reg_write;                
    reg [31:0] write_data;    
    reg [4:0] rs1,rs2,rd; 

    //Outputs
    wire [31:0] out1,out2;

    reg_file uut (clk,write,write_data,rs1,rs2,rd,out1,out2);

    //Clock togles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("reg_file.vcd");
        $dumpvars(0,reg_file_tb);

        //Initialize inputs
        clk=0;#10

        reg_write=0;//read
        rs1=1;rs2=2;#10

        reg_write=1;//write
        rd=3;write_data=7;#10

        reg_write=0;//read written data
        rs1=3;rs2=4;#10

        $finish;
    end
endmodule