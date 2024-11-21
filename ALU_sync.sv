`timescale 1ns / 1ps
//Módulo ALU
module ALU_sync #(parameter Width = 4) (
  input wire [Width-1:0] a, b,
  input wire [Width-1:0] op,
  input wire clk, enable, arst,
  output reg cout, borrow,
  output reg [Width*2-1:0] res_resta, res_division, res_and, res_or, res_xor, res_left_shift, res_rigth_shift,
  output reg [Width*2-1:0] res_suma, res_mult, alu_out,
  output reg a_greater, a_equal, a_less
);
    Adder #(Width) Adder_i (
      a, b, cout, res_suma
    );
    Substraction #(Width) Substractor_i (
      a, b, borrow, res_resta
    );
    Multiplication #(Width) Multiplicator_i (
      a, b, res_mult
    );
    Divide #(Width) Divide_i (
      a, b, res_division
    );
	 bitwise_AND #(Width) bitwise_AND_i (
		a, b, res_and
	 );
	 bitwise_OR #(Width) bitwise_OR_i (
		a, b, res_or
	 );
	 bitwise_XOR #(Width) bitwise_XOR_i (
		a, b, res_xor
	 );
    Comparator #(Width) Comparator_i (
      .a(a),
      .b(b),
      .a_greater(a_greater),
      .a_equal(a_equal),
      .a_less(a_less)
  );
    //assign alu_out = (op == 4'b0000) ? res_suma : (op == 4'b0001) ? res_resta : (op == 4'b0010) ? res_and : (op == 4'b0011) ? 
	// res_or : (op == 4'b0100) ? res_xor : (op == 4'b0101) ? a_equal : (op == 4'b0110) ? res_mult : (op == 4'b0111) ? res_division : (op == 4'b1000) ? res_left_shift : (op == 4'b1001) ? res_rigth_shift : 8'b00000000;
	always @(posedge clk or negedge arst) begin
	   
	end
endmodule
