//Register File-

module regfile8x8a
	(input  clk,
	input [2:0] INaddr,
	input [7:0] IN,
	input [2:0] OUT1addr,
	output [7:0] OUT1,
	input [2:0] OUT2addr,
	output [7:0] OUT2);
	
	reg [7:0] reg0, reg1, reg2, reg3,reg4,reg5,reg6,reg7;
	
	assign OUT1 = 	OUT1addr == 0 ? reg0 :
					OUT1addr == 1 ? reg1 :
					OUT1addr == 2 ? reg2 :
					OUT1addr == 3 ? reg3 : 
					OUT1addr == 4 ? reg4 :
					OUT1addr == 5 ? reg5 :
					OUT1addr == 6 ? reg6 : reg7;

	assign OUT2 = 	OUT2addr == 0 ? reg0 :
					OUT2addr == 1 ? reg1 :
					OUT2addr == 2 ? reg2 :
					OUT2addr == 3 ? reg3 :
					OUT2addr == 4 ? reg4 :
					OUT2addr == 5 ? reg5 :
					OUT2addr == 6 ? reg6 : reg7;


	always @(negedge clk) 
	begin
	case(INaddr)
	// your code here
		0: reg0 = IN;
		1: reg1 = IN;
		2: reg2 = IN;
		3: reg3 = IN;
		4: reg4 = IN;
		5: reg5 = IN;
		6: reg6 = IN;
		7: reg7 = IN;
	endcase
	end // always @ (negedgeclk)
endmodule

module simulate;
	reg clk;
	reg[2:0] INaddr;
	reg[7:0] IN,reg0;
	reg[2:0] OUT1addr;
	wire[7:0] OUT1;
	reg[2:0] OUT2addr;
	wire[7:0] OUT2;
	
	regfile8x8a make_reg(clk,INaddr,IN,OUT1addr,OUT1,OUT2addr,OUT2);
	
	
	initial
	begin
	
	IN = 10;
	#5 clk = 1;
	INaddr = 3;
	#5 clk =0;

	
	OUT1addr = 3;
	

	#5 $display("source1 = %d",OUT1); 
	

	end
	
endmodule
	
