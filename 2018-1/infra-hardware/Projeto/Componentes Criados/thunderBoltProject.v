module control (
	input clk,
	input rst,

	// Valores para controle de PC
	output PCWrite,
	input [31:0] PCin,
	output [31:0] PCout

);
	assign resetPC = rst; 
	
	Registrador PC(clk, resetPC, PCWrite, PCin, PCout);
	
endmodule

module control_testnech();
	//create a clock signal
	reg clk;
	reg rst;
	reg [31:0] PCin;
	wire [31:0] PCout;
	reg PCWrite;
	always #10 clk = ~clk;

	initial begin
		clk = 0;
		rst = 0;
		PCin = 0;
		PCWrite = 0;
		#100;
		PCin = 10;
		PCWrite = 1;
		#100
		PCWrite = 0;
	end
	control DUT(clk, rst, PCWrite, PCin, PCout);
	
endmodule
