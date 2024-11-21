`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 18:03:11
// Design Name: 
// Module Name: bitwise_XOR
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


module bitwise_XOR #(parameter WIDTH = 4) (

  input wire [WIDTH-1:0] a, b,
  output [WIDTH-1:0] result
);
  assign result = a ^ b;
endmodule
