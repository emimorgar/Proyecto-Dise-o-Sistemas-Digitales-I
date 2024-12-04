`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CINVESTAV
// Engineer: Martha Macias
// 
// Create Date: 26.11.2024 18:21:00
// Design Name: ALU_VECTORIAL
// Module Name: tb_flags
// Project Name: tb_flags
// Target Devices: ~~~~~
// Tool Versions: ~~~~~
// Description: This is the code to test the flags in differents situation
// 
// Dependencies:~~~~~
// 
// Revision:#1
// Revision 0.01 - File Created
// Additional Comments:In this moment don't had the correct result in the add
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_flags;
//Parameter to declare the parametric
    parameter WIDTH_flags = 4;
    parameter N_flags = 1;
 //clock signal
    bit clk;
    always #1 clk = !clk;
 //assert property ( @(posedge clk)(Interfaz_to_flags_i.A == 1 && Interfaz_to_flags_i.B == 0 && Interfaz_to_flags_i.sel = 4'b0010)|->(Interfaz_to_flags_i.os[4]== 1));
 //request the interfaces    
    Interfaz_to_flags #(WIDTH_flags,N_flags)Interfaz_to_flags_i();
    Vectorial_ALU #(WIDTH_flags, N_flags) DUT1 (
        .A(Interfaz_to_flags_i.A),
        .B(Interfaz_to_flags_i.B),
        .clk(clk),
        .arst(Interfaz_to_flags_i.arst),
        .enable(Interfaz_to_flags_i.enable),
        .os(Interfaz_to_flags_i.os),
        .Z(Interfaz_to_flags_i.Z),
        .sel(Interfaz_to_flags_i.sel)
    );
  //List of test    
    //`define A_big_B
    //`define B_big_A
   // `define result_zero
    `define sign_flags
 
    `ifdef A_big_B
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // greater than flags on                                   //
    ////////////////////////////////////////////////////////////////
        initial begin
        repeat (10)begin
        //para la suma
        Interfaz_to_flags.os=4'b0000;
        Interfaz_to_flags_i.A_big_B();//Mentio the function
        @(posedge clk)//Wait the clk
        $display("Result: %b",Interfaz_to_flags_i.os);//display the result
        assert(Interfaz_to_flags_i.os[2]==1)else $error("It's gone wrong in the greater flag");//assertio to result
        end
        repeat(10)begin
        // para le resta
        Interfaz_to_flags.os=4'b0001;
        Interfaz_to_flags_i.A_big_B();
        @(posedge clk)//Wait the clk
        $display("Result: %b",Interfaz_to_flags_i.os);//display the result
        assert(Interfaz_to_flags_i.os[2]==1)else $error("It's gone wrong in the greater flag");//assertio to result
        $finish;        
        end
    `endif
    
    `ifdef B_big_A
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // less than flags on                                          //
    ////////////////////////////////////////////////////////////////
        initial begin
        repeat (10)begin
        Interfaz_to_flags.os=4'b0000;
        Interfaz_to_flags_i.B_big_A();//Mentio the function
        @(posedge clk)//Wait the clk
        $display("Result: %b",Interfaz_to_flags_i.os);//display the result
        assert(Interfaz_to_flags_i.os[1]==1)else $error("It's gone wrong in the less than flag");//assertio to result
        end
        $finish;        
        end
    `endif
     
    `ifdef result_zero
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // zero flags, with the substraction operation                //
    ////////////////////////////////////////////////////////////////
        initial begin 
            repeat (10) begin
            Interfaz_to_flags_i.sel=4'b0001;
            Interfaz_to_flags_i.result_zero();
            @(posedge clk)//Wait the clk
            $display("Result: %b",Interfaz_to_flags_i.os);//display the result
            //assertio to result
            assert(Interfaz_to_flags_i.os[5]==1)else $error("It's gone wrong in the zero flag");
            assert(Interfaz_to_flags_i.os[0]==1)else $error("It's gone wrong in equal flag");
            end
        $finish;
        end
    `endif
   
    `ifdef sign_flags
     /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // sign flag, with the multiplication operation                //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
            //assign the multiplication
            Interfaz_to_flags_i.sel=4'b0010;
            Interfaz_to_flags_i.sign_flag();
            @(posedge clk)//Wait the clk
            $display("Result: %b",Interfaz_to_flags_i.os);//display the result
            assert(Interfaz_to_flags_i.os[4]==1)else $error("It's gone wrong in the sign flag");//assertio to result
            end
        $finish;
        end
    `endif
    
    
    
endmodule :tb_flags

interface Interfaz_to_flags#(parameter WIDTH=4, N=1)();
/////////////////////////////////////////////////////////////////
// Interface to generate a conection to the DUT, these is only //
// to teste the flags                                          //
/////////////////////////////////////////////////////////////////
    logic [(WIDTH*N)-1:0] A;        //ALU inputs
    logic [(WIDTH*N)-1:0] B;       // ALU inputs
    logic [(8*N)-1:0] os;         // Other signal 
    logic [3:0] sel;             //Selction of peration
    logic arst;                  //Rest 
    logic [N-1:0] enable;        //Signal to enable
    logic[((WIDTH)*N)-1:0] Z;   //Result
    logic [(WIDTH-1):0] temp1;
    logic [(WIDTH-1):0] temp2;      //Variable of to take randomize
    
    //list of function test 
    function A_big_B();
    //To declarar the inputs, put in zero
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
    //This if is to get the random value and next to connect the data in the size of A
        if (std::randomize(temp1) with{temp1<='hf;})begin
        A={N{temp1}};
        end
        if (std::randomize(temp2) with{temp2<temp1;})begin
        B={N{temp2}};
        end   
    endfunction
    
    function B_big_A();
    //To declarar the inputs, put in zero
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
    //This "if" is to get the random value and next to connect the data in the size of A
        if (std::randomize(temp1) with{temp1<='hf;})begin
        B={N{temp1}};
        end
        if (std::randomize(temp2) with{temp2<temp1;})begin
        A={N{temp2}};
        end 
     endfunction
     
     function result_zero();
     //declare the input
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        if (std::randomize(temp1) with{temp1<='h5;})begin
        B={N{temp1}};        
        A={N{temp1}};
        end
       endfunction: result_zero
       
       function sign_flag();
       //declare the inputs
            A={N{1'b0}};
            B={N{1'b0}};
            enable={N{1'b1}};
            arst=0;
            if(std::randomize(temp1) with{temp1[3]==1;})
            //define in the valor of temp1 the msb should to be always 1
            begin
                 B={N{temp1}};
            end
            if (std::randomize(temp2) with{temp2[3]==0;})begin
            //define in the valor of temp2 the msb should to be always 0
                A={N{temp2}};
            end 
            //both condition is to secure the negative sign in the result
       endfunction: sign_flag
    
endinterface:Interfaz_to_flags

