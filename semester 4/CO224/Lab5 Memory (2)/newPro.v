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
			32'h00000000: Instruction = 32'h08030005;
			
			32'h00000001: Instruction = 32'h08030005;
			32'h00000002: Instruction = 32'h08040009;
			
			32'h00000003: Instruction = 32'h101A0003;
			32'h00000004: Instruction = 32'h01000403;
			32'h00000005: Instruction = 32'h1806001A;
			
			32'h00000006: Instruction = 32'h10100004;
			32'h00000007: Instruction = 32'h09010403; 
			32'h00000008: Instruction = 32'h18070010;
			
			32'h00000009: Instruction = 32'h01000607;
		/*/
			
			32'h00000000: Instruction = 32'h08040001;
			
			32'h00000001: Instruction = 32'h08040001;
			32'h00000002: Instruction = 32'h08060002;
			32'h00000003: Instruction = 32'h08030003;
			32'h00000004: Instruction = 32'h01050603;
			32'h00000005: Instruction = 32'h02010405;
			32'h00000006: Instruction = 32'h03020106;
			32'h00000007: Instruction = 32'h00070002;
			32'h00000008: Instruction = 32'h09040703; 
			
			32'h00000009: Instruction = 32'h101A0004;
			32'h00000010: Instruction = 32'h08030000;
			32'h00000011: Instruction = 32'h1800001A;
			
			32'h00000012: Instruction = 32'h08030005;
			32'h00000013: Instruction = 32'h101B0003;
			32'h00000014: Instruction = 32'h1800002C;
			
			*/
		
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


module cu(select,mux0,mux1,mux2,mux3,OPCODE,Immediate,OUT1addr, OUT2addr, INaddr,read_mem,write_mem,wait_mem,address_mem,Instruction);
	
	input [31:0] Instruction;
	output [2:0] OUT1addr;
	output [2:0] OUT2addr;
	output [2:0] INaddr;
	output [7:0] OPCODE;
	output [7:0] Immediate;
	output reg mux0,mux1,mux2,mux3;
	output [2:0] select;
	wire [7:0] tmp;
	
	//input wait_mem;
	output reg read_mem,write_mem,wait_mem;
	output reg [7:0] address_mem;
	
	assign select = Instruction[26:24];
	assign OUT1addr = Instruction[2:0];
	assign OUT2addr = Instruction[10:8];
	assign INaddr = Instruction[18:16];
	assign Immediate = Instruction[7:0];
	assign OPCODE = Instruction[31:24];
	
	assign tmp = INaddr;

	
	always @(OPCODE) 
	begin
	
	case(OPCODE)
	//add your code here.
	//use the instruction flow given in the last page. Convert them to 32bit binary.
		
		8:begin //ldri    0000 1000	/loadi 4, X, 0xFF (load the immediate value 0xFF to register 4. Ignore SOURCE 2)
			read_mem = 1'b0;
			write_mem = 1'b0;
			//mux0 = 1'b0;
			mux1 = 1'b1;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
			
		1:begin //add    0000 0001	/add 4, 2, 1 (add value in register 1 to value in register 2, and place the result in register 4)
			read_mem = 1'b0;
			write_mem = 1'b0;
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
			
		9:begin //sub 	0000 1001	/sub 4, 2, 1 (subtract value in register 1 from the value in register 2, and place the result in register 4)
			read_mem = 1'b0;
			write_mem = 1'b0;
			mux0 = 1'b0;
			mux1 = 1'b0;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
			
		3:begin //or	0000 0011	/or 4, 2, 1 (perform bit-wise OR on values in registers 1 and 2, and place the result in register 4)
			read_mem = 1'b0;
			write_mem = 1'b0;
			mux0 = 1'b1;
			mux1 = 1'b1;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
			
		0:begin //mov	0000 0000	/mov 4, X, 1 (copy the value in register 1 to register 4. Ignore SOURCE 2)
			read_mem = 1'b0;
			write_mem = 1'b0;
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
			
		2:begin //and	0000 0010	/and 4, 2, 1 (perform bit-wise AND on values in registers 1 and 2, and place the result in register 4)
			read_mem = 1'b0;
			write_mem = 1'b0;
			mux0 = 1'b1;
			mux1 = 1'b0;
			mux2 = 1'b1;
			mux3 = 1'b0;
			end
		
		24:begin //load 0001 1000	/load 4, X, 0x1F (read value at memory address 0x1F into register 4. Ignore SOURCE 2)
			$display(">> READ");
			read_mem = 1'b1;
			write_mem = 1'b0;
			wait_mem = 1'b1;
			mux0 = 1'b1;
			mux1 = 1'b0;
			//mux2 = 1'b1;
			mux3 = 1'b1;
			assign address_mem = Instruction[7:0];
			
			end
			
		16:begin //store 0001 0000	/store0x8C, X, 2(write value in register 2 into the memory at address 0x8C. Ignore SOURCE 2)
			$display(">> STORE");
			read_mem = 1'b0;
			write_mem = 1'b1;
			wait_mem = 1'b1;
			mux0 = 1'b1;
			mux1 = 1'b0;
			//mux2 = 1'b1;
			mux3 = 1'b0;
			assign address_mem = Instruction[23:16];
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

module data_mem(clk,rst,read,write,address,write_data,read_data,busy_wait);
	input clk;
	input rst;
	input read;
	input write;
	input[7:0] address;
	input[7:0] write_data;
	output[7:0] read_data;
	output reg busy_wait;

	reg[7:0] read_data;

	integer  i;

	// Declare memory 256x8 bits 
	reg [7:0] memory_array [255:0];
	//reg [7:0] memory_ram_q [255:0];
	
	
	always @(posedge rst)
	begin
		if (rst)
		begin
			for (i=0;i<256; i=i+1)
				memory_array[i] <= 0;
		end
	end


	always @(*)
	begin
	
		if (write && !read)
		begin
			busy_wait = 1;
			// artificially delay 100 cycles
			memory_array[address] = write_data;
			busy_wait <= 0;
		end
		
		
		if (!write && read)
		begin
			busy_wait <= 1;
			// artificially delay 100 cycles
			read_data = memory_array[address];
			busy_wait <= 0;
		end
	end
 
endmodule


module processor(clk,reset,reset_reg,RESULT,Instruction);

	input clk,reset,reset_reg;
	wire [31:0] Read_addr;
	output [31:0] Instruction;
	wire [7:0] OPCODE,Immediate,OUT1,OUT2,twosComplement0,twosComplement1,mux2out,mux1out,mux0out;
	wire [2:0] alu_select,OUT1addr,OUT2addr,INaddr,select;
	wire mux1,mux2,mux0,mux3;
	output[7:0] RESULT;
	wire [7:0] address_mem,write_data,mux3out;
	wire [7:0] read_data_mem;
	wire read_mem,write_mem,wait_mem,busy_wait;
	
	counter counter0(clk,reset,Read_addr);
	Instruction_reg InsReg0(clk, Read_addr, Instruction);
	cu cu0(select,mux0,mux1,mux2,mux3,OPCODE,Immediate,OUT1addr, OUT2addr, INaddr,read_mem,write_mem,wait_mem,address_mem,Instruction);
	data_mem data_mem1(clk,reset,read_mem,write_mem,address_mem,RESULT,read_data_mem,wait_mem);
	MUX m3(mux3out,read_data_mem,RESULT,mux3);
	regfile8x8a regf0(clk,INaddr,mux3out,OUT1addr,OUT1,OUT2addr,OUT2);
	twos_comp tcmp0(OUT1,twosComplement0);
	twos_comp tcmp1(OUT2,twosComplement1);
	MUX m0(mux0out,OUT1,twosComplement0,mux0);
	MUX m1(mux1out,Immediate,mux0out,mux1);
	MUX	m2(mux2out,OUT2,twosComplement1,mux2);
	alu alu(RESULT,mux1out,mux2out,select);
	
	
endmodule

module simulate;

	reg clk,reset,reset_reg;
	wire[7:0] RESULT;
	wire [31:0] Instruction;

	processor pr1(clk,reset,reset_reg,RESULT,Instruction);
	
	always #10 clk = ~clk;
	
	initial begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,simulate);	
		clk = 0;
		reset = 1;
		reset = 0;
		reset_reg = 1;
		reset_reg = 0;
		#200 $finish;
	end

	initial begin
		while(1) begin
		#20 $display("Instruction : %h		result = %d",Instruction,RESULT);
		end
	end
	
endmodule 
  
  
  /*
		// Wait for 5 clock cycles
		repeat (5) begin
			@ (posedge clk) ;
		end
		
  */
