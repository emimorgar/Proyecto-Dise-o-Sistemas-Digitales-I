`timescale 1ns / 1ps

module ALU_sync #(parameter WIDTH = 4) (
    input  wire clk,                    // Clock signal
    input  wire arst,                  // Asynchronous reset
    input  wire en,                     // Enable signal for the register
    input  wire [3:0] op,        // Operation selector
    input  wire [WIDTH-1:0] a, b,       // ALU inputs
    output reg  [1:0] os,         //Overflow flag and Borrow flag
    output reg  [WIDTH-1:0] reg_out     // Registered output
);

    // ALU operation results
    wire [WIDTH-1:0] add_result;
    wire [WIDTH-1:0] sub_result;
    wire [WIDTH-1:0] mul_result;
    wire [WIDTH-1:0] div_result;
    wire [WIDTH-1:0] and_result;
    wire [WIDTH-1:0] or_result;
    wire [WIDTH-1:0] xor_result;
    wire [WIDTH-1:0] lsh_result;
    wire [WIDTH-1:0] rsh_result;
    wire OF, BF;

    // Instantiating modules
    Adder #(.WIDTH(WIDTH)) u_adder (
        .a(a), .b(b), .carry_out(OF), .result(add_result)
    );

    Substraction #(.WIDTH(WIDTH)) u_sub (
        .a(a), .b(b), .borrow_out(BF), .result(sub_result)
    );

    Multiplication #(.WIDTH(WIDTH)) u_mul (
        .a(a), .b(b), .result(mul_result)
    );

    Divide #(.WIDTH(WIDTH)) u_div (
        .a(a), .b(b), .result(div_result)
    );

    bitwise_AND #(.WIDTH(WIDTH)) u_and (
        .a(a), .b(b), .result(and_result)
    );

    bitwise_OR #(.WIDTH(WIDTH)) u_or (
        .a(a), .b(b), .result(or_result)
    );

    bitwise_XOR #(.WIDTH(WIDTH)) u_xor (
        .a(a), .b(b), .result(xor_result)
    );
    
    Left_Shift #(.WIDTH(WIDTH)) u_lsh (
        .a(a), .b(b), .result(lsh_result)
    );
    
    Right_Shift #(.WIDTH(WIDTH)) u_rsh (
        .a(a), .b(b), .result(rsh_result)
    );

    // Register logic
    always @(posedge clk or posedge arst) begin
        if (arst) begin
            reg_out <= {WIDTH{1'b0}}; // Reset register to 0
            os <= 2'b00;
        end else if (en) begin
            case(op)
                4'b0000 :   reg_out <= add_result;
                4'b0001 :   reg_out <= sub_result;
                4'b0010 :   reg_out <= mul_result;
                4'b0011 :   reg_out <= div_result;
                4'b0100 :   reg_out <= and_result;
                4'b0101 :   reg_out <= or_result;
                4'b0110 :   reg_out <= xor_result;
                4'b0111 :   reg_out <= lsh_result;
                4'b1000 :   reg_out <= rsh_result; 
                default :   reg_out <= {WIDTH{1'b0}}; 
            endcase
            os <= {OF, BF};
        end else begin
            reg_out <= {WIDTH{1'b0}}; // Output 0 if not enabled
            os <= 2'b00;
        end
    end
endmodule