module decorder(Q0,Q1,Q2,Q3,A,B);
	input A,B;
	output Q0,Q1,Q2,Q3;
	
	wire An,Bn;
	
	not not1(An,A);
	not not2(Bn,B);
	
	and and0(Q0,An,Bn);
	and and1(Q1,An,B);
	and and2(Q2,A,Bn);
	and and3(Q3,A,B);

endmodule

module simulate;

	wire out_Q0,out_Q1,out_Q2,out_Q3;
	reg A,B;
	
	decorder de(out_Q0,out_Q1,out_Q2,out_Q3,A,B);
	
	initial
		begin
			A = 1'b0;
			B = 1'b0;
			#5;
			$display("A = %b, B = %b",A,B);
			$display("Q3 = %b, Q2 = %b, Q1 = %b, Q0 = %b\n",out_Q3,out_Q2,out_Q1,out_Q0);
			B = 1'b1;
			#5;
			$display("A = %b, B = %b",A,B);
			$display("Q3 = %b, Q2 = %b, Q1 = %b, Q0 = %b\n",out_Q3,out_Q2,out_Q1,out_Q0);
			A = 1'b1;
			B = 1'b0;
			#5;
			$display("A = %b, B = %b",A,B);
			$display("Q3 = %b, Q2 = %b, Q1 = %b, Q0 = %b\n",out_Q3,out_Q2,out_Q1,out_Q0);
			B = 1'b1;
			#5;
			$display("A = %b, B = %b",A,B);
			$display("Q3 = %b, Q2 = %b, Q1 = %b, Q0 = %b\n",out_Q3,out_Q2,out_Q1,out_Q0);
			$finish;
		end
		
endmodule
