`timescale 1ns / 1ps

//Kumail Hossieni
//14-08-2024

module ram (
    input wire [3:0] addr,
    input wire [7:0] data_in,
    input wire clk,
    input wire wr,
    input wire rd,
    output reg [7:0] data_out
);
    reg [7:0] ram [15:0];

    always @(posedge clk) begin
        if (wr && !rd) begin
            ram[addr] <= data_in; end
        else if (rd && !wr) begin
            data_out <= ram[addr]; end
    end 
endmodule



