module multiplexer(out,i0,i1,i2,i3,s1,s0);
	input i0,i1,i2,i3,s1,s0;
	output out;
	
	wire s1n,s0n,y0,y1,y2,y3;
	
	not n1(s1n,s1);
	not n2(s0n,s0);
	and a1(y0,i0,s1n,s0n);
	and a2(y1,i1,s1n,s0);
	and a3(y2,i2,s1,s0n);
	and a4(y3,i3,s1,s0);
	
	or o1(out,y0,y1,y2,y3);

endmodule

module simulate;

	wire out_mu;
	reg i0,i1,i2,i3,s1,s0;
	
	multiplexer mu1(out_mu,i0,i1,i2,i3,s1,s0);
	
	initial
		begin
		
		i0 = 1'b0; i1 = 1'b1; i2 = 1'b0; i3 = 1'b1;
		
		s1 = 1'b0; s0 = 1'b0;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s0 = 1'b1;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s1 = 1'b1; s0 = 1'b0;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s0 = 1'b1;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
		
		
		i0 = 1'b1; i1 = 1'b0; i2 = 1'b1; i3 = 1'b0;
	
		s1 = 1'b0; s0 = 1'b0;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s0 = 1'b1;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s1 = 1'b1; s0 = 1'b0;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b\n",i0,i1,i2,i3,out_mu);
			#5;
		s0 = 1'b1;
		#5;
		$display("s1 = %b, s0 = %b",s1,s0);
		$display("i0 = %b, i1 = %b, i2 = %b, i3 = %b, out = %b",i0,i1,i2,i3,out_mu);
		
		$finish;
		end
		
endmodule
