module partialproduct(input1,segment,output1);
	input [7:0] input1;
	input [2:0] segment;
	output reg [15:0] output1;
	
		always @(*) begin
			case (segment)
				3'b000:output1=$signed(1'b0);
				3'b001:output1=$signed(input1);
				3'b010:output1=$signed(input1);
				3'b011:
					begin
					output1=$signed(input1);
					output1=$signed(input1)<<<1;
					end
				3'b100:begin
					output1=$signed(input1);
					output1=$signed(~output1+1'b1);
					output1=$signed(output1)<<<1;
					end
				3'b101:begin
					output1=$signed(input1);
					output1=$signed(~output1+1'b1);
					end
				3'b110:begin
					output1=$signed(input1);
					output1=$signed(~output1+1'b1);
					end
				3'b111:output1=$signed(16'b0);	
			endcase
		end
	
endmodule
 
module boothmulitplier(a,b,c);
	input [7:0] a;
	input [7:0] b;
	output [15:0] c;
	wire [15:0] temp [3:0];
	
	partialproduct p0(a,{b[1:0],1'b0},temp[0]);
	partialproduct p1(a,b[3:1],temp[1]);
	partialproduct p2(a,b[5:3],temp[2]);
	partialproduct p3(a,b[7:5],temp[3]);
	assign c = $signed(temp[0])+$signed(temp[1]<<<2)+$signed(temp[2]<<<4)+$signed(temp[3]<<<6);	
endmodule

module boothmultiplier_testbench();
	reg [7:0] a;
	reg [7:0] b;
	wire [15:0] c;
	
	boothmulitplier DUT(a, b, c);
	
	initial begin
		a = 0; b = 0;
		#100
		#(100) a = 10;
		b = 10;
		#(100) b = 20;
	end
	
endmodule
