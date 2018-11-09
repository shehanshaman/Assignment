//CO221 - Digital Design 
// Project - Phase 2: Verilog implementation of the ALU
// March, 2017
// Test bed for the simple ALU

// Group no.: 
// Members: 

// Top level stimulus module
// This module can be directly used in your design
module testbed;

	reg [2:0] A,B;
	reg load1,load2,run;
	wire [2:0] C; 
	reg [3:0] op_code;

	//A and B are the two 3-bit inputs coming from switches
	//C is the 3-bit output that comes from the accumulator once run is set to high
	//load1 is the load signal for operand 1 register
	//load2 is the load signal for operand 2 register
	//op_code selects the operator
		// op_code=4'b0000 - Addition
		// op_code=4'b0001 - Bitwise XOR
		// op_code=4'b0010 - Multiplication
		// op_code=4'b0011 - Shift Left
		// op_code=4'b0100 - Shift Right
		// op_code=4'b0101 - Bitwise AND
		// op_code=4'b0110 - Bitwise OR
		// op_code=4'b0111 - Bitwise NAND
		// op_code=4'b1000 - Bitwise NOR
		// op_code=4'b1001 - One bit shift left
		// op_code=4'b1010 - One bit shift right

	//you don't have to model switches or the LEDs in Verilog

	// Instatiation of the ALU module
	ALU mu_alu(C,A,B,load1,load2,op_code,run);

	initial
	begin

		//generate files needed to plot the waveform
		//you can plot the waveform generated after running the simulator by using gtkwave
		$dumpfile("wavedata.vcd");
	    $dumpvars(0,testbed);

		//You should simulate the ALU for the given inputs
		// Input 1: A=5, B=2
		// Input 2: A=2, B=5
		//You should add another test case of your own as well
		//Out of the given op_codes and $display statements, you should select only those
		//corresponging to your implementation and erase others
	
		//A = 5 and B = 2
		A=3'd5; B=3'd2; 
		#5 load1=1'b1;
		#5 load1=1'b0;
		#5 load2=1'b1;
		#5 load2=1'b0;
		#5 op_code=4'b0000;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%d + %d = %d",A,B,C);
		#5 op_code=4'b0001;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ^ %b = %b",A,B,C);
		#5 op_code=4'b0010;
		#5 run=1'b1;
		#5 run=1'b0; 
		$display("%d * %d = %d",A,B,C);
		#5 op_code=4'b0011; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b << 2 = %b",A,C);
		#5 op_code=4'b0100; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b >> 2 = %b",A,C);
		#5 op_code=4'b0101;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b & %b = %b",A,B,C);
		#5 op_code=4'b0110;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b | %b = %b",A,B,C);
		#5 op_code=4'b0111;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ~& %b = %b",A,B,C);
		#5 op_code=4'b1000; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ~| %b = %b",A,B,C);
		#5 op_code=4'b1001; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b << 1 = %b",A,C);
		#5 op_code=4'b1010; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b >> 1 = %b\n",A,C);
		
		//A = 2 and B = 5
		#5 A=4'd2; B=4'd5; 
		#5 load1=1'b1;
		#5 load1=1'b0;
		#5 load2=1'b1;
		#5 load2=1'b0;
		#5 op_code=4'b0000;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%d + %d = %d",A,B,C);
		#5 op_code=4'b0001;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ^ %b = %b",A,B,C);
		#5 op_code=4'b0010; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%d * %d = %d",A,B,C);
		#5 op_code=4'b0011; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b << 2 = %b",A,C);
		#5 op_code=4'b0100; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b >> 2 = %b",A,C);
		#5 op_code=4'b0101;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b & %b = %b",A,B,C);
		#5 op_code=4'b0110;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b | %b = %b",A,B,C);
		#5 op_code=4'b0111;
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ~& %b = %b",A,B,C);
		#5 op_code=4'b1000; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b ~| %b = %b",A,B,C);
		#5 op_code=4'b1001; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b << 1 = %b",A,C);
		#5 op_code=4'b1010; 
		#5 run=1'b1;
		#5 run=1'b0;
		$display("%b >> 1 = %b\n",A,C);
		
		//Add your test case here.
		
		$finish;	
		
	end

endmodule

//your modules should go here



