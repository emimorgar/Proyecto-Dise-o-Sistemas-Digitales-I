`timescale 1ns / 1ps

module Vectorial_ALU #(parameter WIDTH = 4, N = 8)(
        input [((WIDTH)*N)-1:0] A, B,
        input [3:0] sel,
        input clk, arst,
        input [N-1:0] enable,
        output reg [(2*N)-1:0] os,
        output reg [((WIDTH)*N)-1:0] Z
    );
    
    genvar i;
    
    generate 
        for (i=0;i<N;i=i+1) begin
            ALU_sync DUT (clk, arst, enable[i], sel, A[(WIDTH*(i+1))-1:WIDTH*i], B[(WIDTH*(i+1))-1:WIDTH*i], os[(2*(i+1))-1:2*i] ,Z[(WIDTH*(i+1))-1:WIDTH*i]);
        end 
    endgenerate 
endmodule