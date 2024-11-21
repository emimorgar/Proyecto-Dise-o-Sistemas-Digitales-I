`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 17:46:57
// Design Name: 
// Module Name: Substraction
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
//////////////////////////////////////////////////////////////////////////////////

module Substraction #(parameter WIDTH = 4) (
    input [(WIDTH-1):0] a,        // Input A
    input [(WIDTH-1):0] b,        // Input B
    output [(WIDTH-1):0] result,  // Subtraction Result
    output borrow_out             // Borrow-Out
);

    // Perform the subtraction
    assign {borrow_out, result} = {1'b0, a} - {1'b0, b};

endmodule