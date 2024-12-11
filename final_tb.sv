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
        
        
    ALU_intf #(WIDTH_flags,N_flags)ALU_i();
        Vectorial_ALU #(WIDTH_flags, N_flags) DUT1 (
            .A(ALU_i.A),
            .B(ALU_i.B),
            .clk(clk),
            .arst(ALU_i.arst),
            .enable(ALU_i.enable),
            .os(ALU_i.os),
            .Z(ALU_i.Z),
            .sel(ALU_i.sel)
    );

   
   //modulo for assert property    
    //Arithmetic Properties 
    
    
   //Logical Properties
   //asserts para probar el funcionamiento de la AND
   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.result == 4'b1111)
   else begin 
   $error;
   end

   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0000 |-> ALU_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   //asserts para probar el funcionamiento de la OR
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0000 |-> ALU_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.result == 4'b1111)
   else begin 
   $error;
   end
   
   //asserts para probar el funcionamiento de la XOR
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b0000 && ALU_i.B == 4'b0000 |-> ALU_i.result == 4'b0000)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.result == 4'b1111)
   else begin 
   $error;
   end    
 
 //asserts para probar el funcionamiento de shift
   assert property ( @(posedge clk) ALU_i.sel == 4'b0111 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0001 |-> ALU_i.result == 4'b1110)
   else begin 
   $error;
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b1000 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0001 |-> ALU_i.result == 4'b0111)
   else begin 
   $error;
   end

    
    //Conditional Properties
    property p1;@(posedge clk)(ALU_i.A!=0 && ALU_i.B!=0 && ALU_i.sel<=4'b0101)|=> (ALU_i.os[2]==1);endproperty
    property p2;@(posedge clk)(ALU_i.A!=0 && ALU_i.B!=0 && ALU_i.sel<=4'b0101)|=> ALU_i.os[1]==1;endproperty
    property p3;@(posedge clk)(ALU_i.A==0 && ALU_i.B!=0 && ALU_i.sel==4'b0010)|=> ALU_i.os[5]==1;endproperty
    property p4;@(posedge clk)(ALU_i.A==0 && ALU_i.B==0 && ALU_i.sel==4'b0000)|=> ALU_i.os[5]==1;endproperty
    property p5;@(posedge clk)(ALU_i.A==ALU_i.B && ALU_i.sel==4'b0001)|=> ALU_i.os[5]==1;endproperty
    property p6;@(posedge clk)(ALU_i.A[3]==0 && ALU_i.B[3]==1 && ALU_i.sel<=4'b0101)|=> ALU_i.os[4]==1;endproperty
    property p7;@(posedge clk)(ALU_i.A==ALU_i.B && ALU_i.sel<=4'b0101)|=> ALU_i.os[0]==1;endproperty
    property p8;@(posedge clk)(ALU_i.B!=0 && ALU_i.A!=0 && ALU_i.sel==4'b0000)|=> ALU_i.os[3]==1;endproperty
    property p11;@(posedge clk)(ALU_ii.A>='h5 && ALU_i.A<='h9 && ALU_i.B>='h5 && ALU_i.B<='h9 && ALU_i.sel==4'b0000)|=> ALU_i.os[7]==1;endproperty
    property p12;@(posedge clk)(ALU_i.A!=0 && ALU_ii.B!=0 && ALU_i.sel==4'b0001)|=>ALU_i.os[6]==1;endproperty
   
    //`define A_big_B
    //`define B_big_A
    //`define sign_flags
    //`define result_zero_multiplication
    //`define result_zero_suma
    //`define result_zero_resta
    //`define equal_flag
    //`define overflow_flag_suma
    //`define carry_out
    //`define borrow_flag
   //`define TEST1
   //`define TEST2
   //`define TEST3
   //`define TEST4
   //`define TEST5
   
   
   `ifdef TEST_a_zero_b_random
    always @(posedge clk) begin 
        repeat (10) begin  
            ALU_i.a_zero_b_random();
            $display("Resultado: %b", ALU_i.Z);
        end
    end
    `endif
        
    `ifdef TEST_b_zero_a_random
     always @(posedge clk) begin
         repeat (10) begin  
             ALU_i.b_zero_a_random();
             $display("Resultado: %b", ALU_i.Z);
         end
     end
     `endif        
        
     `ifdef TEST_b_random_a_random
      always @(posedge clk) begin
            repeat (10) begin  
                ALU_i.b_random_a_random();
                $display("Resultado: %b", ALU_i.Z);
            end
      end
      `endif
                
        `ifdef TEST_a_b_max
            always @(posedge clk) begin
                repeat (10) begin  
                    ALU_i.a_b_max();
                    $display("Resultado: %b", ALU_i.Z);
                end
            end
        `endif  

        `ifdef TEST_a_b_alternate
            always @(posedge clk) begin
                repeat (10) begin  
                    ALU_i.a_b_alternate();
                    $display("Resultado: %b", ALU_i.Z);
                end
            end
        `endif   

        `ifdef TEST_a_shft_b_1
            always @(posedge clk) begin
                repeat (10) begin  
                    ALU_i.a_shft_b_1();
                    $display("Resultado: %b", ALU_i.Z);
                end
            end
        `endif  

        `ifdef TEST_a_1_b_shft
            always @(posedge clk) begin
                repeat (10) begin  
                    ALU_i.a_1_b_shft();
                    $display("Resultado: %b", ALU_i.Z);
                end
            end
        `endif    

        `ifdef TEST_a_b_shft
            always @(posedge clk) begin
                repeat (10) begin  
                    ALU_i.a_b_shft();
                    $display("Resultado: %b", ALU_i.Z);
                end
            end
        `endif  

    
    
  `ifdef A_big_B
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // greater than flags on                                      //
    ///////////////////////////////////////////////////////////////
      
        initial begin
            repeat(10)begin
                ALU_i_i.A_big_B();
                @(posedge clk)//Wait the clk
                $display("Result: %b",ALU_i_i.os);//display the result
                end
            $finish;        
        end
        //assert property(p1)else $error("It's gone wrong in the less than flag");
    `endif
    
    `ifdef B_big_A
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // less than flags on                                          //
    ////////////////////////////////////////////////////////////////
        initial begin
        repeat (10)begin
        ALU_i_i.B_big_A();//Mentio the function
        @(posedge clk)//Wait the clk
        $display("Result: %b",ALU_i_i.os);//display the result
        end
        $finish;        
        end
        //assert property(p2)else $error("It's gone wrong in the less than flag");//assertio to result
    `endif
   
    `ifdef sign_flags
     /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // sign flag, with the aritmetic operation                    //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
            //assign the multiplication
            ALU_i_i.sign_flag();
            @(posedge clk)//Wait the clk
            $display("Result: %b",ALU_i_i.os);//display the result
            end
        $finish;
        end
         assert property(p6)else $error("It's gone wrong in the sign flag");//assertio to result
    `endif
    
    `ifdef result_zero_multiplication
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // zero flag, with the aritmetic operation                    //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
                ALU_i_i.result_zero_multiplication();
                @(posedge clk)//Wait the clk
                $display("Result: %b",ALU_i_i.os);//display the resul
            end
        $finish; 
        end
        assert property(p3)else $error("It's gone wrong in the zero flag");//assertio to result
    `endif
    
    `ifdef result_zero_suma
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // zero flag, with the adder operation                         //
    ////////////////////////////////////////////////////////////////
        initial begin
        repeat (10) begin
            ALU_i_i.result_zero_suma();
            @(posedge clk)//Wait the clk
            $display("Result: %b",ALU_i_i.os);//display the result
        end
        $finish;
       end
       assert property(p4)else $error("It's gone wrong in the zero flag");//assertio to result 
    `endif
    
    `ifdef result_zero_resta
        /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the     //
    // zero flag, with the substraction operation                    //
    //////////////////////////////////////////////////////////////// //
        initial begin
            repeat (10) begin
                ALU_i_i.result_zero_resta();
                @(posedge clk)//Wait the clk
                $display("Result: %b",ALU_i_i.os);//display th
            end
        $finish;
        end
        assert property(p5)else $error("It's gone wrong in the zero flag");//assertio to result
    `endif
    
    `ifdef equal_flag
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // equal flag, with the aritmetic operation                    //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
                ALU_i_i.equal_flag();
                 @(posedge clk)//Wait the clk
                 $display("Result: %b",ALU_i_i.os);//display the r
            end
        $finish;
       end
       assert property(p7)else $error("It's gone wrong in the equal flag");//assertio to result
    `endif
    
    `ifdef overflow_flag_suma
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // overflow flag, with the adder operation                    //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
                ALU_i_i.overflow_flag_suma();
                 @(posedge clk)//Wait the clk
                 $display("Result: %b",ALU_i_i.os);//display the result
       
            end
        $finish;
        end
        assert property(p8)else $error("It's gone wrong in the overflow flag");//assertio to result
    `endif
    
  
    
    
    
    `ifdef carry_out
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // carry out flag, with the aritmetic operation                //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
                ALU_i_i.carry_out();
                 @(posedge clk)//Wait the clk
                $display("Result: %b",ALU_i_i.os);//display the result
            end
        $finish;
        end
        assert property(p11)else $error("It's gone wrong in the carry out flag");//assertio to result
    `endif
    
    `ifdef borrow_flag
    /////////////////////////////////////////////////////////////////
    // In this test repeat the function 10 times to try catch the  //
    // borrow flag, with the aritmetic operation                    //
    ////////////////////////////////////////////////////////////////
        initial begin
            repeat (10) begin
            ALU_i_i.borrow_flag();
            @(posedge clk)//Wait the clk
            $display("Result: %b",ALU_i_i.os);//display the result
            end
        $finish;
        end
        assert property(p12)else $error("It's gone wrong in the borrow flag");//assertio to result
    `endif
    
    //Logic Operations covergroup
    covergroup cg_logic @(posedge clk);
        coverpoint ALU_i.A{
            bins zero    = {0};
            bins typical = {[1:3'b111]};
            bins max_val = {4'b1111};
            bins alter   = {4'b1010};
            bins alter_1 = {4'b0101};
            
        }
        
        coverpoint ALU_i.B{
            bins zero    = {0};
            bins typical = {[1:3'b111]};
            bins max_val = {4'b1111};
            bins alter   = {4'b1010};
            bins alter_1 = {4'b0101};
        }
        
        coverpoint ALU_i.Z{
            bins zero    = {0};
            bins typical = {[1:3'b111]};
            bins max_val = {4'b1111};
        }  
              
        coverpoint ALU_i.sel{
            bins and_sel = {4'b0100};
            bins or_sel  = {4'b0101};
            bins xor_sel = {4'b0110};
        }
               
        cross sel, A, B;
        cross sel, Z;
        
      endgroup
    //Conditional covergroup
    covergroup cg_flags();
        cp_equal: coverpoint ALU_i.os[0];
        cp_less_than: coverpoint ALU_i.os[1];
        cp_greater_than: coverpoint ALU_i.os[2];
        cp_over: coverpoint ALU_i.os[3];
        cp_sign: coverpoint ALU_i.os[4];
        cp_zero: coverpoint ALU_i.os[5];
        cp_borrow: coverpoint ALU_i.os[6];
        cp_carry: coverpoint ALU_i.os[7];
        // cross
        SignaAndLess:cross cp_sign,cp_less_than;
        SignAndGreater:cross cp_sign,cp_greater_than;
        SignAndOver: cross cp_sign,cp_over;
        signAndBorrow: cross cp_sign,cp_borrow;
        SignAndCarry: cross cp_sign,cp_carry;
        EqualAndZero: cross cp_equal,cp_zero;          
    endgroup

    
                              
endmodule :ALU_tb

interface ALU_intf#(parameter WIDTH=4, N=2)();
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
  
      //list of function test 
    function A_big_B();
    //this function put in zero the inputs.
    //then get the value to sel in to the range between 0 to 3 (is the aritmetic operation)
    //next put value the inputs 0 to 15 but not equal
    //the values of A is always bigger than B
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        std::randomize(sel) with{sel>=0;sel<=3;};
        if (std::randomize(temp1) with{temp1<='hf;})begin
        A={N{temp1}};
        end
        if (std::randomize(temp2) with{temp2<temp1;temp2<='hf;})begin
        B={N{temp2}};
        end   
    endfunction
    
    function B_big_A();
   //this function put in zero the inputs.
   //then get the value to sel in to the range between 0 to 3 (is the aritmetic operation)
   //next put value the inputs 0 to 15 but not equal
   //the values of B is always bigger than A
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        std::randomize(sel) with{sel>=0;sel<=3;};
        if (std::randomize(temp1) with{temp1<='hf;})begin
        B={N{temp1}};
        end
        if (std::randomize(temp2) with{temp2<temp1;})begin
        A={N{temp2}};
        end 
     endfunction
     
     function result_zero_multiplication();
     //this function put in zero the A inputs and on the other signals
     //then get the value to sel especific to multiplication operation
     //next put value to B input between 0 to 15
     //the value of A is always zero
        A={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0010;
        if (std::randomize(temp1) with{temp1<='hf;})begin
            B={N{temp1}};        
        end
       endfunction: result_zero_multiplication
       
       function result_zero_suma();
       //this function put in zero the both inputs and put on the signal
       //select the adder in the sel input
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0000;
       endfunction: result_zero_suma
       
       function result_zero_resta();
       //this function put in seto the inputs signal and on the enable's signal 
       //select the substraction in the sel signal 
       //randomize the value for inputs between 0 to 15
       //get the same value to A and B
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0001;
        if(std::randomize(temp1) with{temp1<='hf;})begin
            B={N{temp1}};
            A={N{temp1}};
        end
       endfunction: result_zero_resta
       
       function sign_flag();
       //this function put in zero the inputs signal and onn the enable's signal
       //randomize the sel value between 0 to 3 values the aritmetic operation
       //randomize the value to B inputs between 0 to 15, also the MBS is always 1, to made the positive value
       //randomize the value to A inputs between 0 to 15, also, the MBS is always 0, to made the negative value
            A={N{1'b0}};
            B={N{1'b0}};
            enable={N{1'b1}};
            arst=0;
            std::randomize(sel) with{sel>=0;sel<=3;};
            if(std::randomize(temp1) with{temp1[3]==1;})
            begin
                 B={N{temp1}};
            end
            if (std::randomize(temp2) with{temp2[3]==0;})begin
                A={N{temp2}};
            end 
       endfunction: sign_flag
       
       function equal_flag();
       //this function put in zero the inputs signal and on the enable's signal 
       //select the all aritmetic operation in the sel signal 
       //randomize the value for inputs between 0 to 5, to evite the overflow
       //get the same value to A and B
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        std::randomize(sel) with{sel>=0;sel<=3;};
        if(std::randomize(temp1) with{temp1<='h5;})
            begin
                A={N{temp1}};
                B={N{temp1}};
            end
       endfunction:equal_flag
       
       function overflow_flag_suma();
       //in this function put in zero the A signal and put B in 15, on the enable signal
       //select the adder operation
       //randomize the value to A between 0 to 15
        A={N{4'ha}};
        B={N{4'hb}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0000;
        if (std::randomize(temp1) with {temp1<='hf;temp1>='h8;}) 
           begin
                A={N{temp1}};
           end
      if (std::randomize(temp2) with {temp2<='hf;temp2>='h8;temp2>=temp1;}) 
        begin
            B={N{temp2}};
        end
       
       endfunction:overflow_flag_suma
       
       function overflow_flag_multiplication();
       //in this function put in zero the A signal and put B in 15, on the enable signal
       //select the multiplication operation
       //randomize the value to A between 5 to 15
        A={N{1'b0}};
        B={N{4'hf}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0010;
        if(std::randomize(temp1) with{temp1>='hC;temp1<='hf;})
            begin
              A={N{temp1}};
            end
       endfunction:overflow_flag_multiplication
       

       
       function carry_out();
       //this function look to randomize the value to A between 5 to 9 this to made the values with 2 digits
       //the B values look the same objects and be different to A
        A={N{1'b0}};
        B={N{1'b0}};
        enable={N{1'b1}};
        arst=0;
        sel=4'b0000;
        if (std::randomize(temp1) with{temp1>='ha;})
            begin
                A={N{temp1}};
            end
        if(std::randomize(temp2) with{temp2>='ha;})
            begin
                B={N{temp2}};
            end        
       endfunction:carry_out
       
       function borrow_flag();
       //this function look to made the value to A are the 2 digits
       //the value to B should to be the 6 to 15, this to made the borrow option
       //select the substraction operation
         A={N{1'b0}};
         B={N{1'b0}};
         enable={N{1'b1}};
         arst=0;
         sel=4'b0001;
         if (std::randomize(temp1) with{temp1[0]==0;})
            begin
                A={N{temp1}};
            end
         if (std::randomize(temp2) with{temp2[0]==1;})
            begin
                B={N{temp2}};
            end
       endfunction: borrow_flag
  
endinterface:ALU_intf