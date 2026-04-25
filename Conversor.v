module Conversor(Dez, Uni, Q);
	input [4:0] Q;
	output [1:0]Dez;
	output [3:0]Uni;
	
	wire [4:0]Qn;
	wire [11:0]T;
	
	not(Qn[0], Q[0]);
	not(Qn[1], Q[1]);
	not(Qn[2], Q[2]);
	not(Qn[3], Q[3]);
	not(Qn[4], Q[4]);
	
	// Dezenas
	
	and(Dez[1], Q[4], Q[2]);
	
	and(T[0], Q[4], Qn[2]);
	and(T[2], T[1], Q[3]);
	or(T[1], Q[2], Q[1]);
	or(Dez[0], T[1], T[2]);
	
	// Unidades
	
	and(T[3], Q[4], Q[1]);
	and(T[4], Q[3], Qn[2], Qn[1]);
	or(Uni[3], T[3], T[4]);
	
	and(T[5],Q[2], Q[1]);
	and(T[6], Qn[4], Qn[3], Q[2]);
	and(T[7], Q[4], Qn[2], Qn[1]);
	or(Uni[2], T[5], T[6], T[7]);
	
	and(T[8], Qn[4], Qn[3], Q[1]);
	and(T[9], Q[3], Q[2], Qn[1]);
	and(T[10], Q[4], Qn[2], Qn[1]);
	or(Uni[1], T[8], T[9], T[10]);
	
	or(T[11], Qn[4], Qn[2]);
	and(Uni[0], T[11], Q[0]);

endmodule