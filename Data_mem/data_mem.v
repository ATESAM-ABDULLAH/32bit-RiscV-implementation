`timescale 1ns / 1ps
//data_mem- Data Memory: 1024byte memory for data

module data_mem (clk,mem_read,mem_write,address,data_in,data_out);
input clk;              //system clock
input mem_read;         //control to read data
input mem_write;        //control to write data
input [31:0] address;   //address to read/write 
input [31:0] data_in;   //input data for write
output reg [31:0] data_out; //output data for read

reg [32:0] memory [256:0];  // Data memory 32bit/1word x 256 index = 1024 byte memory

always @(posedge clk ) begin
    //Temp data
    memory[0]=2;

    //Logic
    if(mem_write)
        memory[address] = data_in;

    if(mem_read)
        data_out = memory[address];
end

endmodule

