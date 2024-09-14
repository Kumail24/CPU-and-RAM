`timescale 1ns / 1ps

//Kumail Hossieni
//18-08-2024

module cpu_tb;
    reg clk;
    reg [7:0] userinput;
    wire [7:0] reg0;
    wire [7:0] reg1;
    wire [7:0] reg2;
    wire [7:0] reg3;
    wire [7:0] ram_data_in;
    wire [7:0] ram_data_out;
    
    cpu uut (
        .clk(clk),
        .userinput(userinput),
        .reg0(reg0),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .ram_data_in(ram_data_in),
        .ram_data_out(ram_data_out)    
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        clk = 0;      
        #10;
        userinput = 8'b10000000;
        #20;
        userinput = 8'b10010001;
        #20;
        userinput = 8'b10100010;
        #20;
        userinput = 8'b10110011;
        #20;
        userinput = 8'b01000010;
        #50;
        userinput = 8'b01010000;
        #50;
        userinput = 8'b01100011;
        #50;
        userinput = 8'b01110001;
        #50;
        userinput = 8'b00000011;
        #40;
        userinput = 8'b00010111;
        #40;
        userinput = 8'b10110100;
        #20;
        $finish;
    end   
endmodule
