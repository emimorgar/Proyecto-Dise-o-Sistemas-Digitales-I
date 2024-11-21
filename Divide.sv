`timescale 1ns / 1ps

module Divide #(parameter Width = 4) (
  input wire [Width-1:0] a, b,
  output wire [Width-1:0] division
);
  assign division = a / b;
endmodule