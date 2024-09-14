`timescale 1ns / 1ps

//Kumail Hossieni
//18-08-2024

module cpu(
    input wire clk,
    input wire [7:0] userinput,
    output wire [7:0] reg0,
    output wire [7:0] reg1,
    output wire [7:0] reg2,
    output wire [7:0] reg3,
    output wire [7:0] ram_data_in,
    output wire [7:0] ram_data_out
    );
    
    wire [7:0] alu_a;
    wire [7:0] alu_b;
    wire [1:0] alu_opcode;
    wire [7:0] alu_result;
    
    wire ram_rd;
    wire ram_wr;
    wire [3:0] ram_addr;
    //wire [7:0] ram_data_in;
    //wire [7:0] ram_data_out;
           
    control_unit control (
        .clk(clk),
        .userinput(userinput),
        .ram_rd(ram_rd),
        .ram_wr(ram_wr),
        .addr(ram_addr),
        .ram_data_out(ram_data_out),
        .ram_data_in(ram_data_in),
        .alu_a(alu_a),
        .alu_b(alu_b),
        .alu_opcode(alu_opcode),
        .alu_result(alu_result),
        .reg0(reg0),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3)
    );
    
    alu alu (
        .a(alu_a),
        .b(alu_b),
        .opcode(alu_opcode),
        .clk(clk),
        .result(alu_result)
    );
    
    ram ram (
        .addr(ram_addr),
        .data_in(ram_data_out),
        .clk(clk),
        .wr(ram_wr),
        .rd(ram_rd),
        .data_out(ram_data_in)
    );
        
endmodule
