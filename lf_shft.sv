`timescale 1ns / 1ps


module lf_shft #(parameter Width = 4)(
  input wire [Width-1:0] a, b,
  output wire [Width-1:0] lft_shft
);
    assign lft_shft = a << b;
endmodule
