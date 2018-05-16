module controle(
	IorD,
	WR,
	AluSrcA,
	AluSrcB,
	AluOP,
	PCSrc,
	PCWrite,
	IRWrite,
	muxR1,
);

output [1:0]IorD;
output WR;
output AluSrcA;
output [2:0]AluSrcB;
output [1:0]AluOP;
output [1:0]PCSrc;
output [1:0]PCWrite;
output IRWrite;
output muxR1;

endmodule
