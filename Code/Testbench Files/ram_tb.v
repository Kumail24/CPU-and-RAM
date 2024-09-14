`timescale 1ns / 1ps

//Kumail Hossieni
//14-08-2024

module ram_tb;
    reg [3:0] addr;
    reg [7:0] data_in;
    reg clk;
    reg wr;
    reg rd;
    wire [7:0] data_out;
    
    ram uut (
        .addr(addr),
        .data_in(data_in),
        .clk(clk),
        .wr(wr),
        .rd(rd),
        .data_out(data_out)    
    );
    
    always begin
        #5 clk = ~clk; 
    end
     
    initial begin
        clk = 0;
        rd = 0;
        wr = 0;
        data_in = 8'b0;
        
        #10;
        wr = 1;
        addr = 4'b0;
        data_in = 8'b1111_1111;
        
        #10;
        addr = 4'b0001;
        data_in = 8'b1111_1110;
        
        #10;
        addr = 4'b0010;
        data_in = 8'b1111_1100;
        
        #10;
        addr = 4'b0011;
        data_in = 8'b1111_1000;
        
        #10;
        addr = 4'b0100;
        data_in = 8'b1111_0000;
        
        #10;
        wr = 0;
        rd = 1;
        addr = 4'b0;
        
        #10;
        addr = 4'b0001;
        
        #10;
        addr = 4'b0010;
        
        #10;
        addr = 4'b0011;
        
        #10;
        addr = 4'b0100;        
        $finish;
   end 
endmodule
