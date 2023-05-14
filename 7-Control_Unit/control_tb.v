`include "control.v"

module control_tb ();
    //Inputs
    reg clk;
    reg [6:0] opcode;

    //Outputs
    wire branch,mem_read,mem_write,alu_src,reg_write;
    wire [1:0] mem_to_reg;    

    control uut (clk,opcode,branch,mem_read,mem_write,alu_src,reg_write,mem_to_reg);

    //Clock toggles every 5ns
    always#5 clk=~clk;

    initial begin
        $dumpfile("control.vcd");
        $dumpvars(0,control_tb);

        //Initialize inputs
        clk=0;#10
		
        opcode  = 7'b0110011;#10//add,sub,and,or
        opcode  = 7'b0100011;#10//sw,sb
        opcode  = 7'b0010011;#10//addi
        opcode  = 7'b0000011;#10//lw,lb
        opcode  = 7'b1100011;#10//beq,bge,blt
        opcode  = 7'b1101111;#10//jal
        opcode  = 7'b1100111;#10//jalr
    
		$finish;
    end
endmodule