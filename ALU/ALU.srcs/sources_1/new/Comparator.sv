`timescale 1ns / 1ps

module Comparator #(parameter WIDTH = 4) (
  input wire [WIDTH-1:0] a, b,
  output wire a_greater, a_equal, a_less
);
  assign a_greater = (a > b);
  assign a_equal = (a == b);
  assign a_less = (a < b);
endmodule