//E14244 Lab 4 - Simple Processor
//*******************************

module alu(Result,DATA1,DATA2,Select); //ALU
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


module counter (clk, reset,Read_addr);
	
	input clk;
	input reset;
	output [31:0] Read_addr;
	// The outputs are defined as registers too
	reg [31:0] Read_addr = 0;
	// The counter doesn't have any delay since the
	// output is latched when the negedge of the clock happens.
	/*always @(reset) 
	begin
		Read_addr = 0;
	end*/

	always @(negedge clk)
	begin
	// add code here//
		Read_addr = Read_addr + 1;
	end
	 
endmodule


//Instruction Registermodule
module instruction_mem(Read_addr,Instruction);
	input [31:0] Read_addr;
	output reg [31:0] Instruction;
	//reg Instruction;

	always @(Read_addr) begin
		case(Read_addr)
			32'h00000000: Instruction = 32'h08040001;
			32'h00000001: Instruction = 32'h08040001;
			32'h00000002: Instruction = 32'h08060002;
			32'h00000003: Instruction = 32'h08030003;
			32'h00000004: Instruction = 32'h01050603;
			32'h00000005: Instruction = 32'h02010405;
			32'h00000006: Instruction = 32'h03020106;
			32'h00000007: Instruction = 32'h00070002;
			32'h00000008: Instruction = 32'h09040703;
		endcase
	end
endmodule

module Instruction_reg (clk, Read_Addr, instruction);

	input clk;
	input [31:0] Read_Addr;
	output [31:0] instruction;
	// define necessary reg's here//
	
	instruction_mem insMemory0(Read_Addr,instruction);
	
	always @(negedge clk) 
	begin
	//add your code here//
		
	end

endmodule


module cu(select,mux0,mux1,mux2,OPCODE,Immediate,OUT1addr, OUT2addr, INaddr,Instruction);
	
	input [31:0] Instruction;
	output [2:0] OUT1addr;
	output [2:0] OUT2addr;
	output [2:0] INaddr;
	output [7:0] OPCODE;
	output [7:0] Immediate;
	output reg mux0,mux1,mux2;
	output [2:0] select;
	
	assign select = Instruction[26:24];
	assign OUT1addr = Instruction[2:0];
	assign OUT2addr = Instruction[10:8];
	assign INaddr = Instruction[18:16];
	assign Immediate = Instruction[7:0];
	assign OPCODE = Instruction[31:24];
	
	always @(OPCODE) 
	begin
	
	case(OPCODE)
	//add your code here.
	//use the instruction flow given in the last page. Convert them to 32bit binary.
		8:begin //ldr    0001 0000
			//mux0 = 1'b0;
			mux1 = 1'b1;
			mux2 = 1'b1;
			end
			
		1:begin //add    0000 0001
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			end
			
		9:begin //sub 	0001 0001
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b0;
			end
			
		3:begin //or	0000 0011
			mux0 = 1'b1;
			mux1 = 1'b1;
			mux2 = 1'b1;
			end
			
		0:begin //mov	0000 0000
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			end
			
		2:begin //and	0000 0010
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			end
			
	
	endcase
	end
	
endmodule

module twos_comp(IN,COMP);		//twos complement unit
	input [7:0] IN;
	output [7:0] COMP;
	wire [7:0]nIn,nINplus;

	assign nIn = ~ IN;
	assign nINplus = nIn + 8'b00000001;
	assign COMP = nINplus;
	
endmodule

module MUX(out,data1,data2,select); //MUltiplexer

	input [7:0] data1;
	input [7:0] data2;
	input select;
	output [7:0] out;
	
	assign out = (select) ? data1 : data2;

endmodule


module simulate;

	reg clk,reset,reset_reg;
	wire [31:0] Read_addr,Instruction;
	wire [7:0] OPCODE,Immediate,OUT1,OUT2,RESULT,twosComplement0,twosComplement1,mux2out,mux1out,mux0out;
	wire [2:0] alu_select,OUT1addr,OUT2addr,INaddr,select;
	wire mux1,mux2,mux0;

	counter counter0(clk,reset,Read_addr);
	Instruction_reg InsReg0(clk, Read_addr, Instruction);
	cu cu0(select,mux0,mux1,mux2,OPCODE,Immediate,OUT1addr, OUT2addr, INaddr,Instruction);
	regfile8x8a regf0(clk,INaddr,RESULT,OUT1addr,OUT1,OUT2addr,OUT2);
	twos_comp tcmp0(OUT1,twosComplement0);
	twos_comp tcmp1(OUT2,twosComplement1);
	MUX m0(mux0out,OUT1,twosComplement0,mux0);
	MUX m1(mux1out,Immediate,mux0out,mux1);
	MUX	m2(mux2out,OUT2,twosComplement1,mux2);
	alu alu(RESULT,mux1out,mux2out,select);


	always #10 clk = ~clk;

	initial begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,simulate);	
		clk = 0;
		reset = 1;
		reset = 0;
		reset_reg = 1;
		reset_reg = 0;
		#160 $finish;
	end

	initial begin
		while(1) begin
		#20 $display("%h   a1=%d   a2=%d   ina=%d   Out1=%d   Out2=%d   im=%d   m0=%d   m1=%d   mux2=%d   Result=%d   select=%d",Instruction,OUT1addr,OUT2addr,INaddr,OUT1,OUT2,Immediate,mux0out,mux1out,mux2out,RESULT,select);
		end
	end
endmodule
