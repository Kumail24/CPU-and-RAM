`timescale 1ns / 1ps

//Kumail Hossieni
//15-08-2024

module alu (
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [1:0] opcode,
    input wire clk,
    output reg [7:0] result
);
    
    always @(posedge clk) begin
        case(opcode)
            2'b00:   result <= a + b;
            2'b01:   result <= a - b;
            2'b10:   result <= a & b;
            2'b11:   result <= a | b;
        endcase
    end
endmodule