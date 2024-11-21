`timescale 1ns / 1ps


module rg_shft #(parameter Width = 4)(
  input wire [Width-1:0] a, b,
  output wire [Width-1:0] rgt_shft
);
    assign rgt_shft = a >> b;
endmodule
