`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 18:02:15
// Design Name: 
// Module Name: bitwise_OR
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


module bitwise_OR #(parameter WIDTH = 4) (
  input wire [WIDTH-1:0] a, b,
  output [WIDTH-1:0] btws_or
);
  assign btws_or = a | b;
endmodule
