`include "decoder.v"

module decoder_tb ();
    //Inputs
    reg clk;
    reg [31:0] instruction;

    //Outputs
    wire [2:0] func3;     
    wire [6:0] func7;  
    wire [6:0] opcode;    
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [20:0] imm;     
    wire size; 

    decoder uut (clk,instruction,func3,func7,opcode,rs1,rs2,rd,imm,size);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0,decoder_tb);

        //Initialize inputs
        clk=0;#10

        instruction = 32'b00000000001000001000000010110011;#10 // add x1 x1 x2
        instruction = 32'b00000000001000001000000011100011;#10 // beq x1 x2 2048
        instruction = 32'b00000000000010000000000011101111;#10 // jal x1 262144
        instruction = 32'b00000000001000001000010000100011;#10 // sw x2 , 8(x1)

        $finish;
    end
endmodule