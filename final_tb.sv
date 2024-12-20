`timescale 1ns / 1ps
module ALU_tb;
    parameter WIDTH_flags = 4;
    parameter N_flags = 1;
    parameter N = 2;
   
    bit clk;//clock signal
    always #1 clk = !clk;
        
        
    ALU_intf #(WIDTH_flags,N_flags) ALU_i();
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
	//Arithmetic Assertions
	assert property ( @(posedge clk) ALU_i.sel == 4'b0000 |-> ALU_i.Z == ALU_i.A + ALU_i.B)
	else begin 
	$error("Error Property 1");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0000 && ALU_i.A == 0 |-> ALU_i.Z == ALU_i.B)
	else begin 
	$error("Error Property 2");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0000 && ALU_i.B == 0 |-> ALU_i.Z == ALU_i.A)
	else begin 
	$error("Error Property 3");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0001 |-> ALU_i.Z == ALU_i.A - ALU_i.B)
	else begin 
	$error("Error Property 4");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0001 && ALU_i.A == ALU_i.B |-> ALU_i.Z == 0)
	else begin 
	$error("Error Property 5");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0010 |-> ALU_i.Z == ALU_i.A * ALU_i.B)
	else begin 
	$error("Error Property 6");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0010 && ALU_i.A == 0 |-> ALU_i.Z == 0)
	else begin 
	$error("Error Property 7");
	end
	
    assert property ( @(posedge clk) ALU_i.sel == 4'b0010 && ALU_i.B == 0 |-> ALU_i.Z == 0)
	else begin 
	$error("Error Property 8");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0011 |-> ALU_i.Z == ALU_i.A / ALU_i.B)
	else begin 
	$error("Error Property 9");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0011 |-> ALU_i.Z == ALU_i.A + ALU_i.B)
	else begin 
	$error("Error Property 10");
	end
	
	assert property ( @(posedge clk) ALU_i.sel == 4'b0011 |-> ALU_i.Z == ALU_i.A + ALU_i.B)
	else begin 
	$error("Error Property 11");
	end
    
    
   //Logical Properties
   //asserts para probar el funcionamiento de la AND
   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.Z == 4'b1111)
   else begin 
   $error("Error Property 12");
   end

   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.B == 4'b0000 |-> ALU_i.Z == 4'b0000)
   else begin 
   $error("Error Property 13");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b0000 |-> ALU_i.Z == 4'b0000)
   else begin 
   $error("Error Property 14");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0100 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.Z == 4'b0000)
   else begin 
   $error("Error Property 15");
   end
   
   //asserts para probar el funcionamiento de la OR
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.Z == 4'b1111)
   else begin 
   $error("Error Property 16");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0000 |-> ALU_i.Z == 4'b1111)
   else begin 
   $error("Error Property 17");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.Z == 4'b1111)
   else begin 
   $error("Error Property 18");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0101 && ALU_i.A == 4'b0000 |-> ALU_i.Z == ALU_i.B)
   else begin 
   $error("Error Property 19");
   end
   
   //asserts para probar el funcionamiento de la XOR
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b1111 |-> ALU_i.Z == 4'b0000)
   else begin 
   $error("Error Property 20");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b0000 && ALU_i.B == 4'b0000 |-> ALU_i.Z == 4'b0000)
   else begin 
   $error("Error Property 21");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b0110 && ALU_i.A == 4'b1010 && ALU_i.B == 4'b0101 |-> ALU_i.Z == 4'b1111)
   else begin 
   $error("Error Property 22");
   end    
 
 //asserts para probar el funcionamiento de shift
   assert property ( @(posedge clk) ALU_i.sel == 4'b0111 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0001 |-> ALU_i.Z == 4'b1110)
   else begin 
   $error("Error Property 22");
   end
   
   assert property ( @(posedge clk) ALU_i.sel == 4'b1000 && ALU_i.A == 4'b1111 && ALU_i.B == 4'b0001 |-> ALU_i.Z == 4'b0111)
   else begin 
   $error("Error Property 23");
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
    property p11;@(posedge clk)(ALU_i.A>='h5 && ALU_i.A<='h9 && ALU_i.B>='h5 && ALU_i.B<='h9 && ALU_i.sel==4'b0000)|=> ALU_i.os[7]==1;endproperty
    property p12;@(posedge clk)(ALU_i.A!=0 && ALU_i.B!=0 && ALU_i.sel==4'b0001)|=>ALU_i.os[6]==1;endproperty

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
   //`define TEST_a_zero_b_random
   //`define TEST_b_zero_a_random
   //`define TEST_b_random_a_random
   //`define TEST_a_b_max
   //`define TEST_a_b_alternate
   //`define TEST_a_shft_b_1
   //`define TEST_a_1_b_shft
   //`define TEST_a_b_shft
   //`define TEST_SUM_EVEN_ODD
	//`define TEST_SUB_EVEN_ODD
	//`define TEST_SUB_ZERO
	//`define TEST_MUL_EVEN_ODD
	//`define TEST_MUL_ZERO
	//`define TEST_DIV_RANDOM
	`define TEST_BOUNDARY_VALUES
	//`define TEST_RANDOMIZED_INPUTS
	//`define TEST_ALL_ZERO_INPUTS
	//`define TEST_ALL_ONE_INPUTS
	//`define TEST_DIV_BY_ZERO
`ifdef TEST_SUM_EVEN_ODD
			initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.input_a_random_even();
					ALU_i.input_b_random_odd();
					ALU_i.sel = 4'b0000; // Addition operation
					ALU_i.enable = 4'b1111; // Enable all ALUs
					
				end
				$finish;
            end
        `endif

        `ifdef TEST_SUB_EVEN_ODD
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.input_a_random_even();
					ALU_i.input_b_random_odd();
					ALU_i.sel = 4'b0001; // Subtraction operation
					ALU_i.enable = {N{1'b1}}; // Enable all ALUs
					
				end
				$finish;
            end
        `endif

        `ifdef TEST_SUB_ZERO
			initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.inputs_a_and_b_to_random();
					ALU_i.set_b_zero();
					sel = 4'b0001; // Subtraction operation
					enable = {N{1'b1}}; // Enable all ALUs
					
				end
				$finish;
            end
        `endif

        `ifdef TEST_MUL_EVEN_ODD
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.input_a_random_even();
					ALU_i.input_b_random_odd();
					ALU_i.sel = 4'b0010; // Multiplication operation
					ALU_i.enable = {N{1'b1}}; // Enable all ALUs
					
				end
				$finish;
			end
        `endif

        `ifdef TEST_MUL_ZERO
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.inputs_a_and_b_to_random();
					ALU_i.set_b_zero();
					ALU_i.sel = 4'b0010; // Multiplication operation
					ALU_i.enable = {N{1'b1}}; // Enable all ALUs
					
				end
				$finish;
			end
        `endif

        `ifdef TEST_DIV_RANDOM
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (10) begin
					@(posedge clk);
					ALU_i.inputs_a_and_b_to_random();
					ALU_i.sel = 4'b0011; // Division operation
					ALU_i.enable = {N{1'b1}}; // Enable all ALUs
					
				end
				$finish;
            end
        `endif

        `ifdef TEST_BOUNDARY_VALUES
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				@(posedge clk);
				// Addition Boundary
				ALU_i.set_a_max();
				ALU_i.set_b_max();
				ALU_i.sel = 4'b0000; // Addition
				ALU_i.enable = {N{1'b1}};
				

				// Subtraction Boundary
				ALU_i.set_a_max();
				ALU_i.set_b_zero();
				ALU_i.sel = 4'b0001; // Subtraction
				ALU_i.enable = {N{1'b1}};
				

				// Multiplication Boundary
				ALU_i.set_a_max();
				ALU_i.set_b_max();
				ALU_i.sel = 4'b0010; // Multiplication
				ALU_i.enable = {N{1'b1}};
				

				// Division Boundary
				ALU_i.set_a_max();
				ALU_i.set_b_min_nonzero();
				ALU_i.sel = 4'b0011; // Division
				ALU_i.enable = {N{1'b1}};
				
				$finish;
			end
        `endif

        `ifdef TEST_RANDOMIZED_INPUTS
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				repeat (1000) begin
					@(posedge clk);
					ALU_i.inputs_a_and_b_to_random();
					ALU_i.sel = 4'b0000; // Randomly testing addition
					ALU_i.enable = {N{1'b1}};
				end
				$finish;
            end
        `endif

        `ifdef TEST_ALL_ZERO_INPUTS
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				@(posedge clk);
				ALU_i.set_a_zero();
				ALU_i.set_b_zero();
				ALU_i.sel = 4'b0000; // Addition
				ALU_i.enable = {N{1'b1}};
				$finish;
			end
        `endif

        `ifdef TEST_ALL_ONE_INPUTS
            initial begin
				ALU_i.arst = 1;
				ALU_i.enable = {N{1'b0}};
				ALU_i.A = 0;
				ALU_i.B = 0;
				ALU_i.sel = 4'b0000;
				#5 ALU_i.arst = 0;
				@(posedge clk);
				ALU_i.set_a_max();
				ALU_i.set_b_max();
				ALU_i.sel = 4'b0000; // Addition
				ALU_i.enable = {N{1'b1}};
				
				$finish;
			end
        `endif

	
    `ifdef TEST_a_zero_b_random
        initial begin  
            repeat (99) begin  
                ALU_i.a_zero_b_random();
                @(posedge clk);
                //$display("Resultado: %b", ALU_i.Z);
            end
            $finish;
        end
    `endif
    
    `ifdef TEST_b_zero_a_random
     initial begin 
         repeat (10) begin  
             ALU_i.b_zero_a_random();
             @(posedge clk);
             $display("Resultado: %b", ALU_i.Z);
         end
         $finish;
     end
     `endif        
        
     `ifdef TEST_b_random_a_random
      initial begin 
                repeat (10) begin  
                ALU_i.b_random_a_random();
                @(posedge clk)
                $display("Resultado: %b", ALU_i.Z);
            end
            $finish;
      end
      `endif
                
        `ifdef TEST_a_b_max
            initial begin
                repeat (10) begin  
                    ALU_i.a_b_max();
                    @(posedge clk)
                    $display("Resultado: %b", ALU_i.Z);
                end
                $finish;
            end
        `endif  

        `ifdef TEST_a_b_alternate
            initial begin
                repeat (10) begin  
                    ALU_i.a_b_alternate();
                    @(posedge clk)
                    $display("Resultado: %b", ALU_i.Z);
                end
                $finish;
            end
        `endif   

        `ifdef TEST_a_shft_b_1
            initial begin
                repeat (10) begin  
                    ALU_i.a_shft_b_1();
                    @(posedge clk)
                    $display("Resultado: %b", ALU_i.Z);
                end
                $finish;
            end
        `endif  

        `ifdef TEST_a_1_b_shft
            initial begin
                repeat (10) begin  
                    ALU_i.a_1_b_shft();
                    @(posedge clk)
                    $display("Resultado: %b", ALU_i.Z);
                end
                $finish;
            end
        `endif    

        `ifdef TEST_a_b_shft
           initial begin
                repeat (10) begin  
                    ALU_i.a_b_shft();
                    @(posedge clk)
                    $display("Resultado: %b", ALU_i.Z);
                end
                $finish;
            end
        `endif 
        `ifdef A_big_B
		/////////////////////////////////////////////////////////////////
		// In this test repeat the function 10 times to try catch the  //
		// greater than flags on                                      //
		///////////////////////////////////////////////////////////////
		  
			initial begin
				repeat(10)begin
					ALU_i.A_big_B();
					@(posedge clk)//Wait the clk
					$display("Result: %b",ALU_i.os);//display the result
					end
				$finish;        
			end
			assert property(p1)else $error("It's gone wrong in the less than flag");
		`endif

		`ifdef B_big_A
		/////////////////////////////////////////////////////////////////
		// In this test repeat the function 10 times to try catch the  //
		// less than flags on                                          //
		////////////////////////////////////////////////////////////////
			initial begin
			repeat (10)begin
			ALU_i.B_big_A();//Mentio the function
			@(posedge clk)//Wait the clk
			$display("Result: %b",ALU_i.os);//display the result
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
				ALU_i.sign_flag();
				@(posedge clk)//Wait the clk
				$display("Result: %b",ALU_i.os);//display the result
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
					ALU_i.result_zero_multiplication();
					@(posedge clk)//Wait the clk
					$display("Result: %b",ALU_i.os);//display the resul
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
				ALU_i.result_zero_suma();
				@(posedge clk)//Wait the clk
				$display("Result: %b",ALU_i.os);//display the result
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
					ALU_i.result_zero_resta();
					@(posedge clk)//Wait the clk
					$display("Result: %b",ALU_i.os);//display th
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
					ALU_i.equal_flag();
					 @(posedge clk)//Wait the clk
					 $display("Result: %b",ALU_i.os);//display the r
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
					ALU_i.overflow_flag_suma();
					 @(posedge clk)//Wait the clk
					 $display("Result: %b",ALU_i.os);//display the result
		   
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
					ALU_i.carry_out();
					 @(posedge clk)//Wait the clk
					$display("Result: %b",ALU_i.os);//display the result
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
				ALU_i.borrow_flag();
				@(posedge clk)//Wait the clk
				$display("Result: %b",ALU_i.os);//display the result
				end
			$finish
			end
			assert property(p12)else $error("It's gone wrong in the borrow flag");//assertio to result
		`endif
		
		
    //Logic Operations covergroup
    covergroup cg_ALU @(posedge clk);
       
        cp_A: coverpoint ALU_i.A;
        cp_B: coverpoint ALU_i.B;
        
        cp_Z: coverpoint ALU_i.Z;
              
        coverpoint ALU_i.sel{
            bins add_sel = {4'b0000};
            bins sub_sel = {4'b0001};
            bins mul_sel = {4'b0010};
            bins div_sel = {4'b0011};
            bins and_sel = {4'b0100};
            bins or_sel  = {4'b0101};
            bins xor_sel = {4'b0110};
            bins lsh_sel = {4'b1000};
            bins rsh_sel = {4'b1001};
        }
               
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
        
        cross ALU_i.sel, ALU_i.A, ALU_i.B;
        cross ALU_i.sel, ALU_i.Z;
        
      endgroup   
      
        cg_ALU cgalu  = new();

        

        
                             
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
    A = {N{'0}};
    std::randomize(B);
    enable={N{1'b1}};
    arst=0;
  endfunction
  
    //This function gives a random number (a) to 0 (b)
  function b_zero_a_random();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    B = '0;
    enable={N{1'b1}};
    arst=0;
    std::randomize(A);
        if (std::randomize(temp1) with{temp1<='hf;})begin
        A={N{temp1}};
        end
endfunction 
  
  //This function adds a random number (a) to 0 (b)
  function b_random_a_random();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    std::randomize(B);
    std::randomize(A);
    enable={N{1'b1}};
    arst=0;
            if (std::randomize(temp1) with{temp1<='hf;})begin
        A={N{temp1}};
        end
        if (std::randomize(temp2) with{temp2<temp1;temp2<='hf;})begin
        B={N{temp2}};
        end 
endfunction
  
   //This function gives A and B max values
  function a_b_max();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    A = 8'b1111;
    B = 8'b1111;    
    enable={N{1'b1}};
    arst=0;
endfunction
  
  //This function alternates the value of a(10101010) and b(01010101)
  function a_b_alternate();
    std::randomize(sel) with { sel >= 4; sel <= 6; };
    A = 8'b1010;
    B = 8'b0101;
    enable={N{1'b1}};
    arst=0;    
endfunction
  
   //This function alternates the value of a(10101010) and b(01010101)
  function a_shft_b_1();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(A);
    B = 4'b0001;
    enable={N{1'b1}};
    arst=0;  
            if (std::randomize(temp1) with{temp1<='hf;})begin
        A={N{temp1}};
        end   
endfunction
  
    //This function alternates the value of a(10101010) and b(01010101)
  function a_1_b_shft();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(B);
    A = 4'b0001;
    enable={N{1'b1}};
    arst=0;   
endfunction
    
    //This function alternates the value of a(10101010) and b(01010101)
  function a_b_shft();
    std::randomize(sel) with { sel >= 7; sel <= 8; };
    std::randomize(B);
    std::randomize(A);
    enable={N{1'b1}};
    arst=0;    
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
	   
	   function void inputs_a_and_b_to_random();
        std::randomize(A);
        std::randomize(B);
		endfunction

		// Functions to set specific input patterns
		function void set_a_zero();
			A = {((WIDTH)*N){1'b0}};
		endfunction

		function void set_b_zero();
			B = {((WIDTH)*N){1'b0}};
		endfunction

		function void set_a_max();
			A = {((WIDTH)*N){1'b1}};
		endfunction

		function void set_b_max();
			B = {((WIDTH)*N){1'b1}};
		endfunction

		function void set_b_min_nonzero();
			B = {((WIDTH)*N){1'b0}};
			B[0] = 1'b1; // Set least significant bit to 1
		endfunction

		function void input_a_random_even();
			std::randomize(A) with {A[0] == 0;};
		endfunction

		function void input_b_random_even();
			std::randomize(B) with {B[0] == 0;};
		endfunction

		function void input_a_random_odd();
			std::randomize(A) with {A[0] == 1;};
		endfunction

		function void input_b_random_odd();
			std::randomize(B) with {B[0] == 1;};
		endfunction
		
endinterface:ALU_intf
