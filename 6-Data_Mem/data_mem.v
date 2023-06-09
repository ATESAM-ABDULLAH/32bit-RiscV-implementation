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

always @(*) begin
    //Temp data for debug
    memory[0]=8'h0;
    memory[1]=8'h0;
    memory[2]=8'h1;
    memory[3]=8'h0;//h0100 = 256

    memory[4]=8'h0;
    memory[5]=8'ha;
    memory[6]=8'h0;
    memory[7]=8'h1;//h10a0 = 4256

    memory[8]=8'h0;
    memory[9]=8'h7;
    memory[10]=8'h2;
    memory[11]=8'h3;//h3270 = 12912

    //Logic
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
        begin
            memory[address] = data_in[7:0];
            memory[address+1] = data_in[15:8];
            memory[address+2] = data_in[23:16];
            memory[address+3] = data_in[31:24];
        end

        if(mem_read)//read byte by byte
        begin
            data_out[7:0] = memory[address];
            data_out[15:8] = memory[address+1]; 
            data_out[23:16] = memory[address+2]; 
            data_out[31:24] = memory[address+3];
        end
    end
    endcase

end

endmodule

