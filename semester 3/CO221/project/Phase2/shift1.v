module shift(y,x1,x0,s);

	input x1,x0,s;
	output y;
	wire ns,and1_out,and0_out;
	
	not (ns,s);
	and and1(and1_out,s,x1);
	and and2(and0_out,ns,x0);
	or or1(y,and0_out,and1_out);
	
endmodule

module simulate;

	reg s,x0,x1,x2;
	wire y0,y1,y2;
	
	shift shift2(y2,x0,x2,s);
	shift shift1(y1,x2,x1,s);
	shift shift0(y0,x1,x0,s);
	
	initial
	begin
	
	x2 = 1'b0;
	x1 = 1'b0;
	x0 = 1'b1;
	
	s = 1'b0;
	#10;
	$display("%b %b %b",y2,y1,x0);
	#10;
	
	s = 1'b1;
	#10;
	$display("%b %b %b",y2,y1,y0);
	#10;
	
	end
	
endmodule
