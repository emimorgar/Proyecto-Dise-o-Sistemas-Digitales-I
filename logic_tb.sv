`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2024 18:21:00
// Design Name: 
// Module Name: ALU_tb
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
module ALU_tb;
    parameter WIDTH_flags = 4;
    parameter N_flags = 1;
   
    bit clk;//clock signal
    always #1 clk = !clk;
        
    logic_intf #(WIDTH_flags,N_flags)logic_i();
        Vectorial_ALU #(WIDTH_flags, N_flags) DUT1 (
            .A(logic_i.A),
            .B(logic_i.B),
            .clk(clk),
            .arst(logic_i.arst),
            .enable(logic_i.enable),
            .os(logic_i.os),
            .Z(logic_i.Z),
            .sel(logic_i.sel)
    );
   
   //asserts para probar el funcionamiento de la AND
   assert property ( @(posedge clk) logic_i.sel == 4'b0100 && logic_i.A == 4'b1111 && logic_i.B == 4'b1111 |-> logic_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0100 && logic_i.A == 4'b1111 && logic_i.B == 4'b0000 |-> logic_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0100 && logic_i.A == 4'b1010 && logic_i.B == 4'b0101 |-> logic_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   //asserts para probar el funcionamiento de la OR
   assert property ( @(posedge clk) logic_i.sel == 4'b0101 && logic_i.A == 4'b1111 && logic_i.B == 4'b1111 |-> logic_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0101 && logic_i.A == 4'b1111 && logic_i.B == 4'b0000 |-> logic_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0101 && logic_i.A == 4'b1010 && logic_i.B == 4'b0101 |-> logic_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   //asserts para probar el funcionamiento de la XOR
   assert property ( @(posedge clk) logic_i.sel == 4'b0110 && logic_i.A == 4'b1111 && logic_i.B == 4'b1111 |-> logic_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0110 && logic_i.A == 4'b0000 && logic_i.B == 4'b0000 |-> logic_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b0110 && logic_i.A == 4'b1010 && logic_i.B == 4'b0101 |-> logic_i.result == 4'b1111)
   else begin 
   $error;
   end    
 
 //asserts para probar el funcionamiento de shift
   assert property ( @(posedge clk) logic_i.sel == 4'b0111 && logic_i.A == 4'b1111 && logic_i.B == 4'b0001 |-> logic_i.result == 4'b1110)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) logic_i.sel == 4'b1000 && logic_i.A == 4'b1111 && logic_i.B == 4'b0001 |-> logic_i.result == 4'b0111)
   else begin 
   $error;
   end
 
   
   //`define TEST1
   //`define TEST2
   //`define TEST3
   //`define TEST4
   //`define TEST5
   
    `define TEST1
        `ifdef TEST1
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_zero_b_random();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif
        
    `define TEST2
        `ifdef TEST2
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.b_zero_a_random();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif        

    `define TEST3
        `ifdef TEST3
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.b_random_a_random();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif
                
    `define TEST4
        `ifdef TEST4
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_b_max();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif  

    `define TEST5
        `ifdef TEST5
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_b_alternate();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif   

    `define TEST6
        `ifdef TEST6
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_shft_b_1();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif  

    `define TEST7
        `ifdef TEST7
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_1_b_shft();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif    

    `define TEST8
        `ifdef TEST8
            always @(posedge clk) begin
                repeat (6) begin  
                    logic_i.a_b_shft();
                    $display("Resultado: %b", logic_i.Z);
                end
            end
        `endif                        
endmodule :ALU_tb

interface logic_intf#(parameter WIDTH=4, N=2)();
/////////////////////////////////////////////////////////////////
// Interface to generate a conection to the DUT, these is only //
// to test logic operations                                   //
/////////////////////////////////////////////////////////////////
    logic [(WIDTH*N)-1:0] A;
    logic [(WIDTH*N)-1:0] B;       // ALU inputs
    logic [(8*N)-1:0] os;        //Overflow flag and Borrow flag
    logic [3:0] sel;
    logic clk;
    logic arst;
    logic [N-1:0] enable;
    logic[((WIDTH)*N)-1:0] Z;
    bit[3:0] temp1,temp2;
    
  //A equal to cero and B a random numbers
  function a_zero_b_random();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    A = '0;
    std::randomize(B);
    enable={N{1'b1}};
    arst=0;
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction
  
    //This function gives a random number (a) to 0 (b)
  function b_zero_a_random();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    B = '0;
    enable={N{1'b1}};
    arst=0;
    std::randomize(A);
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction  
  
  //This function adds a random number (a) to 0 (b)
  function b_random_a_random();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    std::randomize(B);
    std::randomize(A);
    enable={N{1'b1}};
    arst=0;
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction 
  
   //This function gives A and B max values
  function a_b_max();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    A = 8'b1111;
    B = 8'b1111;    
    enable={N{1'b1}};
    arst=0;
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction
  
  //This function alternates the value of a(10101010) and b(01010101)
  function a_b_alternate();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    A = 8'b1010;
    B = 8'b0101;
    enable={N{1'b1}};
    arst=0;    
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction 
  
   //This function alternates the value of a(10101010) and b(01010101)
  function a_shft_b_1();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(A);
    B = 4'b0001;
    enable={N{1'b1}};
    arst=0;    
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction 
  
    //This function alternates the value of a(10101010) and b(01010101)
  function a_1_b_shft();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(B);
    A = 4'b0001;
    enable={N{1'b1}};
    arst=0;    
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction 
    
    //This function alternates the value of a(10101010) and b(01010101)
  function a_b_shft();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(B);
    std::randomize(A);
    enable={N{1'b1}};
    arst=0;    
    $display("a: %b", A);
    $display("b: %b", B);
  endfunction   
  
endinterface:logic_intf
