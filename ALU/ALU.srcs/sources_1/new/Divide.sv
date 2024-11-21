`timescale 1ns / 1ps

module Divide #(parameter WIDTH = 4) (
  input wire [WIDTH-1:0] a,          // Dividend
  input wire [WIDTH-1:0] b,          // Divisor
  output wire [WIDTH-1:0] result,    // Quotient
  output wire [WIDTH-1:0] remainder  // Remainder
);
  // Handle division by zero gracefully
  assign result = (b != 0) ? (a / b) : {WIDTH{1'b0}};
  assign remainder = (b != 0) ? (a % b) : {WIDTH{1'b0}};
endmodule