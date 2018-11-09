module srlatch(q,nq,s,r); //srlatch
	input s,r;
	output q,nq;

	nand nand1(q,s,nq);
	nand nand2(nq,r,q);

endmodule

module my_dlatch(Q,nQ,D,En); //D-Latch

	input D,En;
	output Q,nQ;

	wire nD,nand1_out,nand2_out;
	
	nand nand1(nand1_out,D,En);
	not not1(nD,D);
	nand nand2(nand2_out,nD,En);
	srlatch sr1(Q,nQ,nand1_out,nand2_out);
	
endmodule
	
module my_Dff(Q,D,clk); //D-Flip Flop

	input D,clk;
	output Q;
	wire nQ;
	
	wire nclk,Dlatch_out,nDlatch_out;
	
	my_dlatch Dlatch1(Dlatch_out,nDlatch_out,D,clk);
	not not1(nclk,clk);
	my_dlatch Dlatch2(Q,nQ,Dlatch_out,nclk);
	
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
	
	my_Dff dff3(q3,p3,clk);
	my_Dff dff2(q2,p2,clk);
	my_Dff dff1(q1,p1,clk);
	my_Dff dff0(q0,p0,clk);
	
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
	or or1(C[1],zOut[1],sOut[0]);
	or or2(C[2],zOut[2],sOut[1]);

endmodule

module CO221(C,A,B,load1,load2,op_code,run);

	input [2:0] A,B;
	input load1,load2,run;
	output [2:0] C; 
	input [3:0] op_code;


	ALU mu_alu1(C,A,B,load1,load2,op_code,run);

endmodule
