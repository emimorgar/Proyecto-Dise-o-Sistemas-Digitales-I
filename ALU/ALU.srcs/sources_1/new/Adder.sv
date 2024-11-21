`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 17:44:43
// Design Name: 
// Module Name: Adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 

module Adder #(parameter WIDTH = 4) (
    input [(WIDTH-1):0] a,     // Input A
    input [(WIDTH-1):0] b,     // Input B
    output [(WIDTH-1):0] result, // Output Result
    output carry_out            // Carry-Out
);
    assign {carry_out, result} = a + b; // Add inputs and produce result with carry
endmodule