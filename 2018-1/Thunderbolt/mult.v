module mult(
input [31:0] inA,
input [31:0] inB,
input AtivMult,
output reg [31:0] outHI,
output reg [31:0] outLO,
input clk
);

reg [64:0] P;
reg [64:0] S;
reg [64:0] A;
reg [31:0] aux;
integer estado = 4;
integer flag;
integer count;


always @(posedge clk) begin
		case(estado)
			32'd0: begin // estado 0
					if(inA[31:0] == 32'd0 || inB[31:0] == 32'd0 )begin
						outHI = 32'd0;
						outLO = 32'd0;
						estado = 4;
					end
					else begin
						P[64:33] <= 32'd0;
						A[64:33] <= inA[31:0];
						aux[31:0] = ~inA[31:0];
						aux[31:0] = aux[31:0] + 32'd1;
						S[64:33] = aux[31:0];
						estado <= 1;
					end
				end
			32'd1: begin // estado 1
					A[32:1] <= 32'b0;
					S[32:1] <= 32'b0;
					P[32:1] <= inB[31:0];
					estado <= 2;
					A[0] = 1'b0;
					S[0] = 1'b0;
					P[0] = 1'b0;
					count <= 32;
				end
			32'd2: begin //estado 2
					if(count == 0)
							estado = 3;
					else begin
						case(P[1:0])
							2'b10: begin
								P = P + S;
							end
							2'b01: begin
								P = P + A;
							end
						endcase
						count = count - 1;
						P = P >>> 1; //>>> salva o bit P[64]
						//P[64] = P[63];
						estado = 2;
					end
				end
			32'd3: begin //estado 3
					outHI <= P[64:33];
					outLO <= P[32:1];
					estado <= 4;
					flag <= 0;
				end
			32'd4: begin // estado de espera(4)
					estado = 4;
					if(flag == 1)
						estado = 0;
				end
		endcase
end

always @(posedge AtivMult)begin
	flag = 1;
end
endmodule