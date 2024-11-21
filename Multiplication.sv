`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 17:48:18
// Design Name: 
// Module Name: Multiplication
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

module Multiplication #(parameter Width = 4) (
  input wire [Width-1:0] a, b,
  output wire [Width*2-1:0] multiplication
);
  assign multiplication = a * b;
endmodule