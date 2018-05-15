module controle(
	clock,
	reset,
);

input	clock;
output 

parameter estadoReset = 4'd0, S2 = 4'd0, S1 = 4'd1, S8 = 4'd2, S3 = 4'd3,
	S7 = 4'd4, S0 = 4'd5, S4 = 4'd6, S3I = 4'd7, S6 = 4'd8,
	blank = 4'd9;

always @ (posedge clock_dividido)
	begin
		if(reset)
			estadoAtual <= estadoReset;
		else
			case(estadoAtual)
				cicloBasico:
					
				estadoReset:
				
	end
