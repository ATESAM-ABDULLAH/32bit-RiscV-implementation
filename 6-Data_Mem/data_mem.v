`timescale 1ns / 1ps
//data_mem- Data Memory: 1024byte memory for data

module data_mem (clk,size,mem_read,mem_write,address,data_in,data_out);
input clk;              //system clock
input size;             //size of data: 0=byte or 1=word
input mem_read;         //control to read data
input mem_write;        //control to write data
input [31:0] address;   //address to read/write 
input [31:0] data_in;   //input data for write
output reg [31:0] data_out; //output data for read

reg [7:0] memory [1023:0];  // Data memory ibyte x 1024 index = 1024 byte memory



always @(posedge clk ) begin

    case(size)
    0:      //byte
    begin
        if(mem_write)
            memory[address] = data_in;
        if(mem_read)
            data_out = memory[address];
    end
    1:
    begin
        if(mem_write)//write byte by byte
            memory[address] = data_in[7:0];
            memory[address+1] = data_in[15:8];
            memory[address+2] = data_in[23:16];
            memory[address+3] = data_in[31:24];

        if(mem_read)//read byte by byte
            data_out[7:0] = memory[address];
            data_out[15:8] = memory[address+1]; 
            data_out[23:16] = memory[address+2]; 
            data_out[31:24] = memory[address+3];
    end
    endcase

end

endmodule

