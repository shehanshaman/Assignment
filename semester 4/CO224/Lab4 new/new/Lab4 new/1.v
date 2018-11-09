module alu;
	
	reg [8:0]DATA1,DATA2;
	reg [3:0] Select;
	reg [8:0]Result;
	wire out;
	
	always@(DATA1,DATA2,Select)

	case(Select)
		
		//your code here//
		//4'b0000 : Result = DATA1;
		4'b0001 :begin
					
					Adder9bit add0(Result,DATA1,DATA2);
					
				end

	endcase
	
	
	initial begin
	#5 Select = 4'b0001;
	#5 DATA1 = 4'b0001;
	#5 DATA2 = 4'b0010;
	
	end
	
	
endmodule

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

module Adder9bit(OUT,DATA1,DATA2);

	input [8:0]DATA1,DATA2;
	output [8:0]OUT;
	wire [0:8]c;
	
	fullAdder fullAdder0(OUT[0],c[0],DATA1[0],DATA2[0],1'b0);
	fullAdder fullAdder1(OUT[1],c[1],DATA1[1],DATA2[1],c[0]);
	fullAdder fullAdder2(OUT[2],c[2],DATA1[2],DATA2[2],c[1]);
	fullAdder fullAdder3(OUT[3],c[3],DATA1[3],DATA2[3],c[2]);
	fullAdder fullAdder4(OUT[4],c[4],DATA1[4],DATA2[4],c[3]);
	fullAdder fullAdder5(OUT[5],c[5],DATA1[5],DATA2[5],c[4]);
	fullAdder fullAdder6(OUT[6],c[6],DATA1[6],DATA2[6],c[5]);
	fullAdder fullAdder7(OUT[7],c[7],DATA1[7],DATA2[7],c[6]);
	fullAdder fullAdder8(OUT[8],c[8],DATA1[8],DATA2[8],c[7]);
	
endmodule
