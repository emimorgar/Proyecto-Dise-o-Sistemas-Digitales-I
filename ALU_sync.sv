`timescale 1ns / 1ps
//Módulo ALU

module ALU_sync #(parameter Width = 4) (
	input wire [Width-1:0] a, b,
  	input wire [Width-1:0] op,
  	input wire clk, enable, arst,
  	output reg cout, borrow,
	output reg [Width*2-1:0] alu_out
);
	reg [Width-1:0] res_suma, res_resta, res_div, res_and, res_or, res_xor, res_left_shift, res_right_shift;
	reg [Width*2-1:0] res_mult;
	reg a_greater, a_equal, a_less;
	
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
      		a, b, res_div
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
	lf_shft #(Width) lf_shft_i (
		a, b, res_left_shift
	);
	rg_shft #(Width) rg_shft_i (
		a, b, res_right_shift
	);

	always @(posedge clk or negedge arst) begin	//Espera un flanco positivo de clk
		if(arst) begin				//Si el arst esta activo pone la salida de la ALU en 0
			alu_out <= {Width{1'b0}};	
		end else begin
			case (op)
				4'b0000 alu_out <= res_suma;
				4'b0001 alu_out <= res_resta;
				4'b0010 alu_out <= res_mult;
				4'b0011 alu_out <= res_div;
				4'b0100 alu_out <= res_and;
				4'b0101 alu_out <= res_or;
				4'b0110 alu_out <= res_xor;
				4'b0111 alu_out <= a_greater or a_equal or a_less;  
				4'b1000 alu_out <= res_left_shift;
				4'b1001 alu_out <= res_right_shift;
				default alu_out <= {Width{1'b0}};	
			endcase
		end			
	end
endmodule
