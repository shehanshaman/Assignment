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
		//$dumpfile("wavedata.vcd");
	    //$dumpvars(0,testbed);

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
		#5 $display("%d + %d = %d",A,B,C);
		/*
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
		*/
		#5 op_code=4'b1010; 
		#5 run=1'b1;
		#5 run=1'b0;
		#5 $display("%b >> 1 = %b\n",A,C);
		
		//A = 2 and B = 5
		#5 A=4'd2; B=4'd5; 
		#5 load1=1'b1;
		#5 load1=1'b0;
		#5 load2=1'b1;
		#5 load2=1'b0;
		#5 op_code=4'b0000;
		#5 run=1'b1;
		#5 run=1'b0;
		#5 $display("%d + %d = %d",A,B,C);
		/*
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
		*/
		#5 op_code=4'b1010; 
		#5 run=1'b1;
		#5 run=1'b0;
		#5 $display("%b >> 1 = %b\n",A,C);
		
		//Add your test case here.
		
		$finish;	
		
	end

endmodule

//your modules should go here

module srlatch(q,nq,s,r); //srlatch
	input s,r;
	output q,nq;

	nand nand1(q,s,nq);
	nand nand2(nq,r,q);

endmodule

module Dlatch(Q,nQ,D,En); //D-Latch

	input D,En;
	output Q,nQ;

	wire nD,nand1_out,nand2_out;
	
	nand nand1(nand1_out,D,En);
	not not1(nD,D);
	nand nand2(nand2_out,nD,En);
	srlatch sr1(Q,nQ,nand1_out,nand2_out);
	
endmodule
	
module Dff(Q,D,clk); //D-Flip Flop

	input D,clk;
	output Q,nQ;
	
	wire nclk,Dlatch_out,nDlatch_out;
	
	Dlatch Dlatch1(Dlatch_out,nDlatch_out,D,clk);
	not not1(nclk,clk);
	Dlatch Dlatch2(Q,nQ,Dlatch_out,nclk);
	
endmodule

module shift(y,x1,x0,s); //shift cell

	input x1,x0,s;
	output y;
	wire ns,and1_out,and0_out;
	
	not (ns,s);
	and and1(and1_out,s,x1);
	and and2(and0_out,ns,x0);
	or or1(y,and0_out,and1_out);
	
endmodule

module register(q3,q2,q1,q0,p3,p2,p1,p0,clk); // register

	input p3,p2,p1,p0,clk;
	output q3,q2,q1,q0;
	
	Dff dff3(q3,p3,clk);
	Dff dff2(q2,p2,clk);
	Dff dff1(q1,p1,clk);
	Dff dff0(q0,p0,clk);
	
endmodule

module shift1Bit(y2,y1,y0,x2,x1,x0,clk); // Shift one bit right

	input x0,x1,x2,clk;
	output y0,y1,y2;
	wire t0,t1,t2,dc;
	
	register register1(t2,t1,t0,dc,x2,x1,x0,1'b0,clk);
	
	shift shift2(y2,t0,t2,1'b1);
	shift shift1(y1,t2,t1,1'b1);
	shift shift0(y0,t1,t0,1'b1);
	
endmodule

//adder
module halfAdder(S,C,A,B); //Half Adder

	input A,B;
	output S,C;
	
	xor xor1(S,A,B);
	and and1(C,A,B);
	
endmodule

module fullAdder(SUM,CO,CI,P,Q); //Full adder using Half adder
	
	input CI,P,Q;
	output SUM,CO;
	wire adder1_out,co1_out,co2_out;
	
	halfAdder halfAdder1(adder1_out,co1_out,P,Q);
	halfAdder halfAdder2(SUM,co2_out,CI,adder1_out);
	or or1(CO,co1_out,co2_out);

endmodule

module Adder3bit(z0,z1,z2,x0,x1,x2,y0,y1,y2,loadA,loadB); // Three bit full adder

	input x0,x1,x2,y0,y1,y2,loadA,loadB;
	output z0,z1,z2;
	wire c1,c2,c3,A0,A1,A2,B0,B1,B2,dc;
	
	register registerA(dc,A2,A1,A0,1'b0,x2,x1,x0,loadA);
	register registerB(dc,B2,B1,B0,1'b0,y2,y1,y0,loadB);
	
	fullAdder fullAdder0(z0,c1,A0,B0,1'b0);
	fullAdder fullAdder1(z1,c2,A1,B1,c1);
	fullAdder fullAdder2(z2,c3,A2,B2,c2);

endmodule

module ALU(C,A,B,load1,load2,op_code,run);

	input [2:0] A,B;
	input load1,load2,run;
	input [3:0] op_code;
	
	output [2:0] C;
	
	wire [2:0] z,s,zOut,sOut;
	wire [3:0] code_re,nCode;
	
	Adder3bit Adder3bit1(z[0],z[1],z[2],A[0],A[1],A[2],B[0],B[1],B[2],load1,load2);
	shift1Bit shift1Bit1(s[0],s[1],s[2],A[0],A[1],A[2],load1);
	
	register register1(code_re[0],code_re[1],code_re[2],code_re[3],op_code[0],op_code[1],op_code[2],op_code[3],run);
	
	not not0(nCode[0],code_re[0]);
	not not1(nCode[1],code_re[1]);
	not not2(nCode[2],code_re[2]);
	not not3(nCode[3],code_re[3]);
	
	and and0(zOut[0],z[0],nCode[0],nCode[1],nCode[2],nCode[3]);
	and and1(zOut[1],z[1],nCode[0],nCode[1],nCode[2],nCode[3]);
	and and2(zOut[2],z[2],nCode[0],nCode[1],nCode[2],nCode[3]);
	
	and and3(sOut[0],s[0],code_re[3],nCode[2],code_re[1],nCode[0]);
	and and4(sOut[1],s[1],code_re[3],nCode[2],code_re[1],nCode[0]);
	and and5(sOut[2],s[2],code_re[3],nCode[2],code_re[1],nCode[0]);
	
	or or0(C[0],zOut[0],sOut[2]);
	or or1(C[1],zOut[1],sOut[1]);
	or or2(C[2],zOut[2],sOut[0]);

endmodule



