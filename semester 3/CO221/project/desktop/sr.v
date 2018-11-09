module srlatch(q,nq,s,r);
	input s,r;
	output q,nq;

	nand nand1(q,s,nq);
	nand nand2(nq,r,q);

endmodule

module Dlatch(Q,nQ,D,En);

	input D,En;
	output Q,nQ;

	wire nD,nand1_out,nand2_out;
	
	nand nand1(nand1_out,D,En);
	not not1(nD,D);
	nand nand2(nand2_out,nD,En);
	srlatch sr1(Q,nQ,nand1_out,nand2_out);
	
endmodule
	
module MS_Dff(Q,D,clk);

	input D,clk;
	output Q,nQ;
	
	wire nclk,Dlatch_out,nDlatch_out;
	
	Dlatch Dlatch1(Dlatch_out,nDlatch_out,D,clk);
	not not1(nclk,clk);
	Dlatch Dlatch2(Q,nQ,Dlatch_out,nclk);
	
endmodule

module Tff(Q,T,clk);

	input T,clk;
	output Q;
	
	wire xor_out;
	xor xor1(xor_out,T,Q);
	MS_Dff dff1(Q,xor_out,clk);
	
endmodule

module ripple_counter(A0,A1,A2,A3,T,count);

	input count,T;
	output A0,A1,A2,A3;
	
	Tff tff0(A0,T,count);
	Tff tff1(A1,T,A0);
	Tff tff2(A2,T,A1);
	Tff tff3(A3,T,A2);
	
endmodule

module change(Q,A,load,I);

	input load,I,A;
	output Q;
	
	wire nclk,and1_out,and2_out,t,nt;
	
	not not1(t,load);
	not not2(nt,t);
	and and1(and1_out,A,t);
	and and2(and2_out,nt,I);
	or or1(Q,and1_out,and2_out);
	
endmodule


module wave;


	


	/*
	reg d0,clock,I0,I1,I2,load;
	wire q0,q1,q2,t0,t1,t2;
	
	change change0(t0,q0,load,I0);
	MS_Dff dff0(q0,t0,clock);
	change change1(t1,q1,load,I1);
	MS_Dff dff1(q1,t1,clock);
	change change2(t2,q2,load,I2);
	MS_Dff dff2(q2,t2,clock);
	*/
	
	initial
	begin
	
		//$dumpfile("wavedata.vcd");
		//$dumpvars(0,wave);
		load = 1'b0;
		I0 = 1'b1;
		I1 = 1'b0;
		I2 = 1'b0;
		
		#400 $finish;
	end
	
	always
	begin
		clock = 1'b0;
		#10;
		$display("q0 = %b | q1 = %b | q2 = %b",q0,q1,q2);
		#10;
		
		clock = 1'b1;
		#10;
		$display("q0 = %b | q1 = %b | q2 = %b",q0,q1,q2);
		#10;
		
		
	end
		
endmodule

