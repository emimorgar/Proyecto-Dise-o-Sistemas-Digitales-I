`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2024 14:07:24
// Design Name: 
// Module Name: Right_Shift
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


module Right_Shift #(parameter WIDTH = 4)(
    input [(WIDTH-1):0] a,
    input [(WIDTH-1):0] b,
    output [(WIDTH-1):0] result 
    );
    
    assign result = a >> b;
endmodule
