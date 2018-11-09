module halfAdder(S,C,A,B);

	input A,B;
	output S,C;
	
	xor xor1(S,A,B);
	and and1(C,A,B);
	
endmodule

module fullAdder(SUM,CO,CI,P,Q);
	
	input CI,P,Q;
	output SUM,CO;
	wire adder1_out,co1_out,co2_out;
	
	halfAdder halfAdder1(adder1_out,co1_out,P,Q);
	halfAdder halfAdder2(SUM,co2_out,CI,adder1_out);
	or or1(CO,co1_out,co2_out);

endmodule

module Adder3bit(z0,z1,z2,x0,x1,x2,y0,y1,y2);

	input x0,x1,x2,y0,y1,y2;
	output z0,z1,z2;
	wire c1,c2,c3;
	
	fullAdder fullAdder0(z0,c1,x0,y0,1'b0);
	fullAdder fullAdder1(z1,c2,x1,y1,c1);
	fullAdder fullAdder2(z2,c3,x2,y2,c2);

endmodule

module simulate;

	reg x0,y0,x1,y1,x2,y2;
	wire z0,z1,z2;
	
	Adder3bit Adder3bit1(z0,z1,z2,x0,x1,x2,y0,y1,y2);
	
	initial 
	begin
	
		x0 = 1'b1;
		x1 = 1'b0;
		x2 = 1'b0;
		
		y0 = 1'b1;
		y1 = 1'b0;
		y2 = 1'b0;
		
		#10;
		$display("%b %b %b",z0,z1,z2);
		
		end
		
endmodule
