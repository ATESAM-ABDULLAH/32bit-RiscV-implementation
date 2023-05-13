`timescale 1ns / 1ps
//alu- Arithmetic Logic Unit: perform operations based on ISA.txt
// 
// ALU control | Function
// -----------------------------
//         000    Bitwise-AND
//         001    Bitwise-OR
//         010	  Add (A+B)
//         011    Subtract (A-B)
//         100	  Less than (A<B)
//         101    Greater than or equal (A>=B)
//         110    Equal (A==B)
//         111    xxxxxxxx
module alu (clk,in1,in2,result,alu_control,zero_flag);
input clk;                      //sytem clock
input [31:0] in1,in2;           //data inputs
input[2:0] alu_control;         //control for operation selection
output reg [31:0] result;   //output of ALU
output reg zero_flag;                //flag if beq,blt,bge TRUE

always @(posedge clk ) begin
        // Operating based on control input
        case(alu_control)

            3'b000: result = in1&in2; //AND
            3'b001: result = in1|in2; //OR
            3'b010: result = in1+in2; //Add
            3'b011: result = in1-in2; //Sub
            3'b100:                       //A<B
            begin 
                if(in1<in2)
                    result = 0;
                else
                    result = 32'bx;
            end
            3'b101: 
            begin 
                if(in1>=in2)            //A>=B
                    result = 0;
                else
                    result = 32'bx;
            end
            3'b011:                     //A==B
            begin 
                if(in1==in2)
                    result = 0;
                else
                    result = 32'bx;
            end
        endcase

        // Setting Zero_flag if ALU_result is zero
        if (result == 0)
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
end
    
endmodule 

