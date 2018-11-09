//ALU
module alu(Result,DATA1,DATA2,Select);

	input [8:0]DATA1,DATA2;
	input [3:0] Select;
	output [8:0]Result;
	reg out;
	
	always@(DATA1,DATA2,Select)
	begin
	case(Select)
	//your code here//
	
	4'b0000 : Result = DATA1;
	4'b0001 : Result = DATA1 + DATA2;
	
	endcase
	
	end
endmodule

module stimulus;

	reg [8:0] REG_IN1,REG_IN2;
	wire [8:0] REG_OUT;
	
	alu alu0(REG_OUT,REG_IN1,REG_IN2,4'b0001);
	
	initial
		begin
			REG_IN1 = 0;
			REG_IN2 = 1;
			#5;
			$display("%b",REG_OUT);
			$finish;
		end

		
endmodule
