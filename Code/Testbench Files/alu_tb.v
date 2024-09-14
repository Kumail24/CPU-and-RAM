`timescale 1ns / 1ps

//Kumail Hossieni
//15-08-2024

module alu_tb;
    reg alu_start;
    reg [7:0] a;
    reg [7:0] b;
    reg [1:0] opcode;
    reg clk;
    wire [7:0] result;
    
    alu uut (
        .alu_start(alu_start),
        .a(a),
        .b(b),
        .opcode(opcode),
        .clk(clk),
        .result(result)
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        alu_start = 1'b1;
        a = 8'b0000_0010;
        b = 8'b0000_0100;
        opcode = 2'b00;
        
        #10;
        a = 8'b0000_1010;
        b = 8'b0000_0100;
        opcode = 2'b01;
        
        #10;
        a = 8'b0001_1010;
        b = 8'b0001_1110;
        opcode = 2'b10;
        
        #10;
        a = 8'b0001_1010;
        b = 8'b0001_1110;
        opcode = 2'b11;
        
        #10;
        alu_start = 1'b0;
        a = 8'b0000_0010;
        b = 8'b0000_0100;
        opcode = 2'b00;
        
        #10;
        a = 8'b0000_1010;
        b = 8'b0000_0100;
        opcode = 2'b01;
        
        #10;
        a = 8'b0001_1010;
        b = 8'b0001_1110;
        opcode = 2'b10;
        
        #10;
        a = 8'b0001_1010;
        b = 8'b0001_1110;
        opcode = 2'b11;
        
        #10;
        $finish;
    end     
endmodule
