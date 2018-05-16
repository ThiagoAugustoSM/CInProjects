module mux_32_2(
	input wire [32:0] in0,
	input wire [32:0] in1,
	input wire [32:0] in2,
	input wire [32:0] in3,
	input wire [2:0] sel,
	
	output reg [32:0]out
);
	always @(sel or in0 or in1 or in2 or in3) begin
		case (sel)
			0: out = in0;
			1: out = in1;
			2: out = in2;
			3: out = in3;
		endcase
	end
endmodule

module mux_32_2_testbench();
	reg [32:0] in0;
	reg [32:0] in1;
	reg [32:0] in2;
	reg [32:0] in3;
	
	reg [2:0] sel;
	wire [32:0] out;
	
	mux_32_2 DUT(in0, in1, in2, in3, sel, out);
	initial begin
		in0 = 0; in1 = 0; in2 = 0; in3 = 0; sel = 0;
		#(100) in0 = 72;
		#(100) sel = 0;
		#(100) sel = 1;
		
	end
endmodule
