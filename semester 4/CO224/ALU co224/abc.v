module alu(Result,DATA1,DATA2,Select);
input [7:0]DATA1,DATA2;
input [2:0]Select;
output reg[7:0]Result;

always@(DATA1,DATA2,Select)

begin
case(Select)
//your code here//
	3'b000 : Result = DATA1;
	3'b001 : Result = DATA1 + DATA2;
	3'b010 : Result = DATA1 & DATA2;
	3'b011 : Result = DATA1 | DATA2;
	
endcase
end
endmodule

module simulate;

reg [7:0]DATA1,DATA2;
wire [7:0]Result;
reg [2:0]Select;

alu ALU0(Result,DATA1,DATA2,Select);

initial
begin

DATA1 = 0;
DATA2 = 6;
Select = 3;

#5 $display("out = %d",Result);

$finish;

end

endmodule
