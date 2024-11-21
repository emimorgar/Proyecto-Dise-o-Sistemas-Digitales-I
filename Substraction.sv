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

module Substraction #(parameter Width = 4)(
  input wire [Width-1:0] a, b,
  output wire borrow,
  output wire [Width-1:0] resta_end
);
	//assign resta_end = a - b;
   wire [Width-1:0] aux_b, comp_b, resta, resta_aux, resta_comp;
   assign aux_b = b ^ 8'b1111;
   assign comp_b = aux_b + 1'b1;
   assign resta = a + comp_b;
   assign resta_aux = resta ^ 8'b1111;
   assign resta_comp = resta_aux + 1'b1;
   assign resta_end = (a >= b) ? resta : resta_comp;
   assign borrow = (a >= b) ? 1 : 0;
endmodule