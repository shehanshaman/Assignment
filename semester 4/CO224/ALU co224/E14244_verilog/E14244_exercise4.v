module my_or(out,a,b);

	input a,b;
	output out;

	wire t1,t2;

	nand n1(t1,a,a);
	nand n2(t2,b,b);

	nand n3(out,t1,t2);



endmodule

module my_and(out,a,b);

	input a,b;
	output out;
	
	wire t;
	
	nand n1(t,a,b);
	nand n2(out,t,t);
	
endmodule

module my_not(out,a);
	
	input a;
	output out;
	
	nand n1(out,a);
	
endmodule

module my_xor(out,x,y);

	input x,y;
	output out;
	
	wire t1,t2,t3,t4;
	
	my_not not1(t1,y);
	my_not not2(t2,x);

	my_and and1(t3,x,t1);
	my_and and2(t4,y,t2);
	
	my_or or1(out,t3,t4);

endmodule

module simulate;

	wire out_or, out_and, out_not,out_xor;
	reg x, y;
	
	my_xor xor1(out_xor,x,y);
	
	initial
		begin
		
		x = 1'b0;
		y = 1'b0;
		#2;
		$display("%b^%b = %b",x,y,out_xor);
		y = 1'b1;
		#2;
		$display("%b^%b = %b",x,y,out_xor);
		x = 1'b1;
		y = 1'b0;
		#2;
		$display("%b^%b = %b",x,y,out_xor);
		y = 1'b1;
		#2;
		$display("%b^%b = %b",x,y,out_xor);
		end
endmodule
