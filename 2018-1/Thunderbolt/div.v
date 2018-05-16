module div(
input [31:0] inA,
input [31:0] inB,
input AtivDiv,
output reg [31:0] outLO,
output reg [31:0] outHI,
input clk
);

integer flag = 0 ;

always @(posedge clk) begin
	if(flag == 1)begin
		outLO <= inA / inB;
		outHI <= inA % inB;
		flag = 0;
	end
end

always @(posedge AtivDiv)begin
	flag = 1;
end

endmodule