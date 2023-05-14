`include "../1-PC/pc.v"
`include "../2-Insn_Mem/insn_mem.v"
`include "../3-Decoder/decoder.v"
`include "../4-Reg_File/reg_file.v"
`include "../5-ALU/alu.v"
`include "../6-Data_Mem/data_mem.v"
`include "../7-Control_Unit/control.v"
`include "../8-ALU_Control/alu_control.v"
`include "../9-Mux_alu_src/alu_src.v"
`include "../10-Mux_mem_to_reg/mem_to_reg.v"

module processor (clk,reset,pc,insn,imm_out,alu_control,reg_out1,reg_out2,alu_result,flag,read_data);
input clk;          //System clock

//Processor output
output [9:0] pc;            //PC
output [31:0] insn;         //Reg file
output [20:0] imm_out;      //Decoder
output [2:0] alu_control;   //Alu control
output [31:0] reg_out1;     //Reg File
output [31:0] reg_out2;     //Reg File
output [31:0] alu_result;   //ALU
output flag;                //ALU
output [31:0] read_data;    //Data memory

assign pc = pc_out;
assign insn = insn_out; 
assign imm_out = imm;
assign alu_control = alu_op;
assign reg_out1 = out1;
assign reg_out2 = out2;
assign alu_result = result;
assign flag = zero_flag;
assign read_data = data_out;

//PC inputs
input reset;
// input branch;        -> outputs of other modules
// input zero_flag;      
// input [1:0] mem_to_reg;
// input [20:0] immediate;
// input [31:0] reg_out1;


//PC outputs 
wire [9:0] pc_out;  // -> insn mem

pc Pc(clk,reset,branch,zero_flag,mem_to_reg,imm,out1,pc_out);
//-------------------------------------------

//Instruction Memory output 
wire [31:0] insn_out;   // -> decoder

insn_mem Instruction_Memory(clk,insn_out,pc_out);
//-------------------------------------------

//Decoder output 
wire [2:0] func3; 
wire [6:0] func7;
wire [6:0] opcode;  // -> control , alu_control
wire [4:0] rs1;  
wire [4:0] rs2;
wire [4:0] rd;      // -> reg file
wire [20:0] imm;    // -> pc 
wire size;          // -> data mem

decoder Decoder(clk,insn_out,func3,func7,opcode,rs1,rs2,rd,imm,size);
//-------------------------------------------

//Control outputs
wire branch;        // -> pc
wire mem_read;
wire mem_write;     // -> data mem
wire alu_src;       // -> mux alu src
wire reg_write;     // -> reg file
wire [1:0] mem_to_reg; // -> pc, mux mem to reg

control Control_Unit(clk,opcode,branch,mem_read,mem_write,alu_src,reg_write,mem_to_reg);
//-------------------------------------------


//ALU control outputs
wire [2:0] alu_op;

alu_control ALU_COntrol(clk,func3,func7,opcode,alu_op);
//-------------------------------------------


//Reg File outputs
wire [31:0] out1;
wire [31:0] out2;

reg_file REGISTER_FILE(clk,reg_write,write_data,rs1,rs2,rd,out1,out2,reset);
//-------------------------------------------


//Mux alu src outputs
wire [31:0] selected;

alu_src MUX_ALU_src(clk,alu_src,out2,imm,selected); 
//-------------------------------------------


//ALU outputs
wire zero_flag;
wire [31:0] result;

alu ALU(clk,out1,selected,result,alu_op,zero_flag);
//-------------------------------------------

//DATA Memory outputs
//address = result -> from ALU
//data_in = out2 -> from reg file
wire [31:0] data_out;

data_mem Data_Memory(clk,size,mem_read,mem_write,result,selected,data_out);
//-------------------------------------------

//Mux mem to reg outputs
//pc_3 = pc_out -> from PC
//selected = write_data -> to Reg File
wire [31:0] write_data;

mem_to_reg Mem_to_Reg(clk,mem_to_reg,result,data_out,pc_out,write_data);
//-------------------------------------------

endmodule